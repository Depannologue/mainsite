class Client::FormController < ApplicationController

  def new
    raise ActionController::RoutingError.new('Not Found') unless InterventionType.exists?(slug: params[:intervention_parent_slug]) && InterventionType.exists?(slug: params[:intervention_child_slug])
    @user_informations_form = UserInformationsForm.new
  end

  def create
    @user_informations_form = UserInformationsForm.new(user_information_form_params)
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
  def user_information_form_params
    params.require(:user_informations_form).permit(:firstname, :lastname, :address1, :address2, :zipcode, :phone_number, :city, :email)
  end


end
