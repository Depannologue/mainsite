class Client::QuotationsController < ApplicationController
  def show
    render 'quotations'
  end
  def new
    if session[:intervention_type_id].present? && params.has_key?(:id)
      # clone the address objet
      address = Address.find_by_id(params[:id])
      address_customer = address.clone
      # create a new customer and add address
      customer = User.new unless session[:customer_id].present?
      customer = User.find_by_id(session[:customer_id]) if session[:customer_id].present?

      customer.address = address_customer
      customer.firstname = address_customer.firstname
      customer.lastname  = address_customer.lastname
      customer.role = "customer"
      customer.phone_number = address_customer.phone_number
      customer.email = "ednaAttegggnte@depannologue.fr"

      if customer.save
        session[:customer_id] = customer.id
      else
        # To-Do traite validation errrors
        raise 'ok'
        render 'intervention_type#show'
        flash[:error] = I18n.t(customer.errors.message)

      end
      # create a intervention and add a customer
      intervention = Intervention.new
      intervention.state = "pending_pro_validation"
      intervention.customer = customer
      intervention.address = address
      intervention.intervention_type = InterventionType.find_by_id(session[:intervention_type_id])
      if intervention.save
        ClientMailer.confirm_booking(intervention).deliver_later
        NotifyBookingOkBySmsService.perform(intervention)

        pros = intervention.pros_now_available_and_nearby
        pros.each do |pro|
          ProMailer.notify_intervention_created(pro, intervention).deliver_later
        end
        NotifyProsBySmsService.perform(intervention, pros)
      else
        # To-Do traite validation errrors
        raise "Validation Error "
      end
      session.delete(:current_address_id) if session[:current_address_id].present?

    else
      raise 'ok3'
    end
    render 'quotations#show'
  end

end
