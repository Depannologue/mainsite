class CreateInterventionService
  def self.perform(address, customer, intervention_type, profession_id,is_immediate,date_intervention)
    new.perform(address, customer, intervention_type, profession_id ,is_immediate,date_intervention)
  end

  def perform(address, customer, intervention_type, profession_id, is_immediate,date_intervention)
    # Duplicate the address with a new id for the intervention
    intervention_address = address.dup
    intervention_address.save
    # create an intervention
    intervention = persist intervention_address, customer, intervention_type , is_immediate , date_intervention
    # send mail and sms to client
    ClientMailer.confirm_booking(intervention).deliver_later
    NotifyBookingOkBySmsService.perform(intervention)
    # send mail and sms to pros available and nearby and matched profession
    pros = intervention.pros_now_available_and_nearby
      pros.each do |pro|
        if pro.with_client_profession profession_id
          ProMailer.notify_intervention_created(pro, intervention).deliver_later
          NotifyProsBySmsService.perform(intervention, pro)
        end
      end

    intervention

  end


  private

  def persist intervention_address, customer, intervention_type , is_immediate , date_intervention
    intervention = Intervention.create(address: intervention_address, customer: customer, intervention_type: intervention_type, state: 'pending_pro_validation', immediate_intervention: is_immediate , intervention_date: date_intervention)
  end
end
