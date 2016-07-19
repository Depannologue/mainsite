class Client::FormController < ApplicationController

  def new
    raise ActionController::RoutingError.new('Not Found') unless InterventionType.exists?(slug: params[:intervention_parent_slug]) && InterventionType.exists?(slug: params[:intervention_child_slug])
    intervention_type = InterventionType.find_by_slug(slug: params[:intervention_child_slug])
    @user_informations_form = UserInformationsForm.new(intervention_type)
  end

  def create
    @user_informations_form = UserInformationsForm.new(user_information_form_params)
    if @user_informations_form.save
      session[:address_id] = @user_informations_form.intervention_id
      redirect_to quotations_new_path(@user_informations_form.address_id)
    else
      render :new
    end
  end

  private
  # Using strong parameters
  def user_information_form_params
    params.require(:user_informations_form).permit(:firstname, :lastname, :address1, :address2, :zipcode, :phone_number, :city, :email)
  end


end
