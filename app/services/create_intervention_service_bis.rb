class CreateInterventionServiceBis
  def self.perform(permitted_params)
    new.perform(permitted_params)
  end

  def perform(permitted_params)
    # Duplicate the address with a new id for the intervention

    # create an intervention
    intervention = persist permitted_params
    # send mail and sms to client
    NotifyBookingOkBySmsService.perform(intervention)
    # send mail and sms to pros available and nearby and matched profession
    pros = intervention.pros_now_available_and_nearby
      pros.each do |pro|
        if pro.with_client_profession intervention.intervention_type.profession_id
          ProMailer.notify_intervention_created(pro, intervention).deliver_later
          NotifyProsBySmsService.perform(intervention, pro)
        end
      end
    intervention
  end


  private

  def persist permitted_params
    intervention = Intervention.create(permitted_params)
  end
end
