class CreateInterventionService
  def self.perform(address, customer, intervention_type)
    new.perform(address, customer, intervention_type)
  end

  def perform(address, customer, intervention_type)
    # Duplicate the address with a new id for the intervention
    intervention_address = address.dup
    intervention_address.save
    # create an intervention
    intervention = persist intervention_address, customer, intervention_type
    # send mail and sms to client
    ClientMailer.confirm_booking(intervention).deliver_later
    NotifyBookingOkBySmsService.perform(intervention)
    # send mail and sms to pros available and nearby
    pros = intervention.pros_now_available_and_nearby
    pros.each do |pro|
      ProMailer.notify_intervention_created(pro, intervention).deliver_later
    end
    NotifyProsBySmsService.perform(intervention, pros)
    intervention
  end


  private

  def persist intervention_address, customer, intervention_type
    intervention = Intervention.create(address: intervention_address, customer: customer, intervention_type: intervention_type, state: 'pending_pro_validation')
  end
end
