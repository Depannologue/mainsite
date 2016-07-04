class Client::InterventionStepsController < ApplicationController
  include Client::AbilityConcern
  include Wicked::Wizard
  layout 'client/application'

  helper_method :current_intervention

  if Rails.env.production?
    steps :start_new_intervention,
          :depannage,
          :define_intervention,
          :payment,
          :rating
  else
    steps :reset_session,
          :start_new_intervention,
          :depannage,
          :define_intervention,
          :payment,
          :rating
  end

  def show
    case step
    when :reset_session
      if session[:current_intervention_client_token_ownership].present? && session[:interventions_client_token_ownership].present?
        session[:interventions_client_token_ownership].delete session[:current_intervention_client_token_ownership]
      end
      jump_to next_step
    when :start_new_intervention
      session.delete :current_intervention_client_token_ownership
      jump_to next_step
    when :depannage
      jump_to next_step unless current_intervention.pending?
    when :define_intervention
      jump_to next_step unless current_intervention.pending?
      jump_to previous_step unless current_intervention.intervention_type.present?
      current_intervention.build_address unless current_intervention.address.present?
    when :payment
      jump_to previous_step if current_intervention.address.nil?
      if current_intervention.address.present?
        unless ZipCode.managed? current_intervention.address.zipcode
          jump_to previous_step
          flash[:error] = I18n.t('intervention_steps.errors.zipcode_not_supported')
        end
        current_intervention.build_customer unless current_intervention.customer.present?
        @pros_now_available_and_nearby = current_intervention.pros_now_available_and_nearby
      end
    when :rating
      jump_to next_step unless current_intervention.pro_on_the_road?
      current_intervention = Intervention.find_by(client_token_ownership: params[:token])
    end
    render_wizard
  end

  def create
    case step
    when :depannage, :define_intervention
      if current_intervention.update_attributes permitted_params.except(:customer_attributes)
        (session[:interventions_client_token_ownership] ||= []) << current_intervention.client_token_ownership
        session[:current_intervention_client_token_ownership] = current_intervention.client_token_ownership
        jump_to next_step
      else
        Rails.logger.info current_intervention.errors.inspect
      end
    end
    render_wizard
  end

  def update
    case step
    when :depannage, :define_intervention
      if current_intervention.update_attributes permitted_params.except(:customer_attributes)
        jump_to next_step
      else
        Rails.logger.info current_intervention.errors.inspect
      end
    when :payment

        unless params[:intervention].blank?
          current_intervention.assign_attributes permitted_params
        end

        if (current_intervention.changes.keys.include? 'customer_id') && (cannot? :set_customer, current_intervention)
          current_intervention.errors.add :customer, :invalid
          current_intervention.customer.errors.add :email, :taken
        else
          if current_intervention.customer.present? && current_intervention.address.present?
            current_intervention.customer.phone_number = current_intervention.address.phone_number
            current_intervention.address.firstname = current_intervention.customer.firstname
            current_intervention.address.lastname  = current_intervention.customer.lastname
          end
          current_intervention.pay! params[:payment_method] if current_intervention.valid?
        end
      if current_intervention.pending_pro_validation?
        jump_to next_step
        pros = current_intervention.pros_now_available_and_nearby
        if pros.empty?
          begin
            AdminMailer.none_available_pro(current_intervention).deliver_later
          rescue
            puts 'ERROR when notify admin.'
          end
        else
            pros.each do |pro|
              ProMailer.notify_intervention_created(pro, current_intervention).deliver_later
            end
            NotifyProsBySmsService.perform(current_intervention)
        end
      else
        @pros_now_available_and_nearby = current_intervention.pros_now_available_and_nearby
      end
    when :rating
      current_intervention.assign_attributes permitted_params.except(:customer_attributes)
      if current_intervention.close_by_client!
        jump_to next_step
      else
        Rails.logger.info current_intervention.errors.inspect
      end
    end
    render_wizard
  end

  def finish_wizard_path
    intervention = current_intervention
    session.delete :token
    client_intervention_path intervention
  end

  def current_intervention
    @current_intervention ||= _current_intervention
  end

  private

  def permitted_params
    params.require(:intervention).permit(
      :intervention_type_id,
      :is_ok,
      :rating,
      :opinion,
      address_attributes: [
        :address1,
        :address2,
        :zipcode,
        :city,
        :phone_number,
        :id
      ],
      customer_attributes: [
        :firstname,
        :lastname,
        :email,
        :id
      ]
    )
  end

  def _current_intervention
    intervention = Intervention.find_by_client_token_ownership(
      params[:token] ||=
      params[:intervention_client_token_ownership] ||=
      params[:interventions_client_token_ownership] ||=
      session[:intervention_client_token_ownership]
    )
    if intervention.present?
      session[:current_intervention_client_token_ownership] = params[:intervention_client_token_ownership]
    else
      intervention = Intervention.find_by_client_token_ownership(
        session[:current_intervention_client_token_ownership]
      )
      if intervention.blank?
        if client_signed_in?
          intervention = current_client.interventions.build
        else
          intervention = Intervention.new
        end
      end
    end
    intervention

  end
end
