# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :string           not null
#  phone_number           :string
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string
#  invitations_count      :integer          default(0)
#  firstname              :string
#  lastname               :string
#

class User < ActiveRecord::Base
  devise :invitable,
         :database_authenticatable,
         :recoverable,
         :rememberable,
         :trackable,
        #  :lockable,
         :validatable

  ROLES = %w(
    customer
    contractor
    admin
  ).freeze

  has_many :user_areas
  has_many :areas, through: :user_areas, class_name: 'Area', inverse_of: :users
  has_many :zip_codes, through: :areas
  has_and_belongs_to_many :professions
  has_many :professions_users

  accepts_nested_attributes_for :professions
  accepts_nested_attributes_for :professions_users, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :areas
  accepts_nested_attributes_for :user_areas, reject_if: :all_blank, allow_destroy: true

  has_one :address, as: :addressable, dependent: :destroy
  has_one :weekly_availability
  has_many :exceptional_availabilities
  has_one :current_exceptional_availability,
          -> {
            where(created_at: WeeklyAvailability.current_daily_time_slot_start_at..WeeklyAvailability.current_daily_time_slot_end_at)
            .order(created_at: :desc)
          },
          class_name: 'ExceptionalAvailability'


  phony_normalize :phone_number, default_country_code: 'FR'

  validates :phone_number, phony_plausible: true
  validates :firstname, :lastname, :phone_number, presence: true, if: proc { |user|
              not user.has_role? :admin
            }
  validates :role,
            presence: true,
            inclusion: { in: ROLES }

  accepts_nested_attributes_for :weekly_availability,
                                :exceptional_availabilities,
                                :address

  scope :customers, -> { where(role: 'customer') }
  scope :contractors, -> { where(role: 'contractor') }
  scope :admins, -> { where(role: 'admin') }

  after_create {|user| user.message 'create' }
  after_update {|user| user.message 'update' }
  after_destroy {|user| user.message 'destroy' }
  def message action
    msg = { resource: 'users',
            action: action,
            id: self.id,
            obj: self.restrict_for_api }

    $redis.publish 'rt-change', msg.to_json
  end

  def areas_name
    self.areas.map(&:name).join(", ")
  end

  # TODO: convert to 'scope :available_now, -> { ... }'
  def self.available_now
    User.contractors.to_a.delete_if { |user|
      !user.available_now?
    }
  end

  # TODO: scope :nearby, -> { ... }

  def available_now?
    if current_exceptional_availability.present?
      current_exceptional_availability.available_now?
    else
      weekly_availability.present? && weekly_availability.available_now?
    end
  end

  # Impossible here to use has_many interventions
  # because the foreign_key is either customer_id or contractor_id
  # if the user is customer, the foreign_key is customer_id
  # if the user is contractor, the foreign_key is contractor_id
  def interventions
    Intervention.where("#{role}_id = #{id}")
  end

  def has_role?(sym)
    role == sym.to_s
  end

  # overriding Devise::Models::Validatable
  def password_required?
    if has_role? :customer
      !password.nil? || !password_confirmation.nil?
    else
      super
    end
  end
  #
  def with_client_profession profession_id
    profession = Profession.find_by_id(profession_id)
    if self.professions.include? profession
      true
    else
      false
    end
  end

  def restrict_for_api
    if self.role == "contractor"
    {
      id: self.id,
      firstname: self.firstname,
      lastname:self.lastname,
      email:self.email,
      phone_number:self.phone_number,
      exceptional_availabilities_available_now: self.exceptional_availabilities.last.available_now,
      weekly_availabilitie: self.weekly_availability
    }
    else
      {
        id: self.id,
        firstname: self.firstname,
        lastname:self.lastname,
        email:self.email,
        phone_number:self.phone_number
      }
    end

  end
end
