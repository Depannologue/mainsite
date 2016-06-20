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
  require 'notify_booking_ok_by_s_m_s_job'
  require 'notify_client_by_s_m_s_job'

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
  has_one :address, as: :addressable, dependent: :destroy

  has_many :historical_transitions, as: :historisable, dependent: :destroy

  validates :address, presence: true,
            if: proc { |intervention|
              !intervention.pending?
            }
  validates :is_ok, inclusion: [true, false],
            if: proc { |intervention|
              intervention.closed? || intervention.archived?
            }
  validates :rating, inclusion: RATINGS,
            if: proc { |intervention|
              intervention.closed? || intervention.archived?
            }

  accepts_nested_attributes_for :customer, :address

  before_create do
    self.client_token_ownership = SecureRandom.hex(25)
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
        begin
          ClientMailer.confirm_booking(self).deliver_later
          client = self.customer
          client.invite! if client.encrypted_password.blank?
          NotifyBookingOkBySMSJob.perform_later(self)
        rescue
          puts "ERROR when invite this client to register."
        end
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
        begin
          NotifyClientBySMSJob.perform_later(self)
        rescue
          puts "ERROR when notify client by email and SMS that pro will happen."
        end
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
