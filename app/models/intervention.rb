# == Schema Information
#
# Table name: interventions
#
#  id                     :integer          not null, primary key
#  state                  :string
#  customer_id            :integer
#  contractor_id          :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  intervention_type_id   :integer
#  price                  :decimal(, )
#  client_token_ownership :string
#  assigned_at            :datetime
#  rating                 :string
#  is_ok                  :boolean
#  opinion                :text
#  payment_method         :string
#

class Intervention < ActiveRecord::Base
  extend Enumerize
  include AASM
  serialize :preferences, JSON
  RATINGS = %w(
    a
    b
    c
    d
    e
  ).freeze

  enumerize :payment_method, in: [:credit_card, :cheque]
  belongs_to :intervention_type
  belongs_to :customer, class_name: 'User', foreign_key: 'customer_id'
  belongs_to :contractor, class_name: 'User', foreign_key: 'contractor_id'
  belongs_to :insurer
  has_one :address, as: :addressable, dependent: :destroy
  has_many :historical_transitions, as: :historisable, dependent: :destroy
  has_many :contractors_declines
  validates :address, presence: true,
            if: proc { |intervention|
              !intervention.pending?
            }
  # validates :is_ok, inclusion: [true, false],
  #           if: proc { |intervention|
  #             intervention.closed? || intervention.archived?
  #           }
  # validates :rating, inclusion: RATINGS,
  #           if: proc { |intervention|
  #             intervention.closed? || intervention.archived?
  #           }

  accepts_nested_attributes_for :customer, :address

  before_create do
    self.client_token_ownership = SecureRandom.hex(25)
  end

  after_create {|intervention| intervention.message 'create' }
  after_update {|intervention| intervention.message 'update' }
  after_destroy {|intervention| intervention.message 'destroy' }
  def message action
    msg = { resource: 'interventions',
            action: action,
            id: self.id,
            obj: self.restrict_for_api }

    $redis.publish 'rt-change', msg.to_json
  end

  def customer_attributes=(user_params)
    self.customer =
      User.where(email: user_params[:email])
      .first_or_initialize(role: 'customer')
    customer.assign_attributes user_params.except(:id, :email, :role)
  end

  aasm column: :state do
    state :pending, initial: true
    state :pending_pro_validation
    state :pro_on_the_road
    state :closed
    state :archived

    event :pay do
      before do |payment_method|
        self.payment_method = payment_method
      end

      success do # if persist successful
          ClientMailer.confirm_booking(self).deliver_later
          client = self.customer
          client.invite! if client.encrypted_password.blank?
          NotifyBookingOkBySmsService.perform(self)
      end

      transitions from:  :pending,
                  to:    :pending_pro_validation,
                  after: :_build_historical_transition


    end

    event :assign_to do
      before do |pro|
        self.contractor = pro
        self.assigned_at = Time.now
      end
      success do # if persist successful
          NotifyClientBySmsService.perform(self)
      end

      transitions from:  :pending_pro_validation,
                  to:    :pro_on_the_road,
                  after: :_build_historical_transition
    end

    event :unassign do
      before do
        self.contractor = nil

      end

      transitions from:  :pro_on_the_road,
                  to:    :pending_pro_validation,
                  after: :_build_historical_transition
    end

    event :close_by_client do
      transitions from:  :pro_on_the_road,
                  to:    :closed,
                  after: :_build_historical_transition
    end

    event :close do
      before do
        self.is_ok = true
        self.rating = "c"
      end

      transitions from:  :pro_on_the_road,
                  to:    :closed,
                  after: :_build_historical_transition
    end

    event :archive do
      transitions from:  :closed,
                  to:    :archived,
                  after: :_build_historical_transition
    end
  end

  def pros_now_available_and_nearby
    zipcode = ZipCode.find_by(zipcode: self.address.zipcode)
    area = zipcode.area if zipcode
    users ||= area.users.contractors.available_now if area
    users
  end

  def current_distance_of_pro

  end

  def restrict_for_api
    {
     id: self.id,
     state: self.state,
     profession_name: self.intervention_type.profession.name,
     profession_slug: self.intervention_type.profession.slug,
     created_at: self.created_at,
     intervention_date: self.intervention_date,
     immediate_intervention: self.immediate_intervention,
     intervention_type_short_description: self.intervention_type.short_description,
     intervention_type_price: self.intervention_type.price,
     address_address1: self.address.address1,
     address_address2:self.address.address2,
     address_zipcode:self.address.zipcode,
     address_city: self.address.city,
     customer_firstname: self.customer.firstname,
     customer_lastname:self.customer.lastname,
     customer_email:self.customer.email,
     customer_phone_number:self.customer.phone_number,
     price: self.price
    }
  end



  private

  def _build_historical_transition
    historical_transitions.build(
      event: aasm.current_event,
      from: aasm.from_state,
      to: aasm.to_state,
      processed_at: Time.now
    )
  end


end
