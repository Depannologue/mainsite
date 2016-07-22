class Client::FormController < ApplicationController

  def new
    raise ActionController::RoutingError.new('Not Found') unless InterventionType.exists?(slug: params[:intervention_parent_slug]) && InterventionType.exists?(slug: params[:intervention_child_slug])
    @user_informations_form = UserInformationsForm.new
  end

  def create
    @user_informations_form = UserInformationsForm.new(user_informations_form_params)
    if @user_informations_form.save
      intervention_type = InterventionType.find_by_slug(params[:intervention_child_slug])
      intervention = CreateInterventionService.perform(@user_informations_form.address, @user_informations_form.customer, intervention_type, session[:profession_id])

      if intervention.valid?
        redirect_to quotations_new_path
      else
        render :new
      end
    else
      render :new
    end
  end

  def edit
    raise 'ok'
  end
  private
  # Using strong parameters



  def user_informations_form_params
    parameters = params.require(:user_informations_form).permit(:firstname, :lastname, :address1, :address2, :zipcode, :phone_number, :city, :email, :intervention_date, :immediate_intervention)
    intervention_time = DateTime.new(parameters["intervention_date(1i)"].to_i, parameters["intervention_date(2i)"].to_i, parameters["intervention_date(3i)"].to_i,parameters["intervention_date(4i)"].to_i, parameters["intervention_date(5i)"].to_i, parameters["intervention_date(6i)"].to_i).change(:offset => "+0200")
    parameters = parameters.merge(intervention_date: intervention_time)
  end






end
