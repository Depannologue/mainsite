class Client::InterventionTypeController < ApplicationController
  def show
    intervention_parent_id = InterventionType.find_by_slug(params[:intervention_parent_slug]).id
    @intervention_childs = InterventionType.where(parent_id: intervention_parent_id)
    render 'intervention_type'
  end

  def new
    if request.post?
      @address_form = AddressForm.new(address_form_params) unless session[:current_address_id].present?
      @address_form = Address.find_by_id session[:current_address_id] if session[:current_address_id].present?
      if ZipCode.managed? @address_form.zipcode
        if @address_form.save
          session[:current_address_id] = @address_form.id
          #redirect_to controller: 'quotations', action: 'show', :id => @adress_form.id
          redirect_to "/devis/#{@address_form.id}"
        else
          #To-do Validation errors handling
          raise @address_form.errors.inspect
          flash[:error] = @address_form.errors.message
        end
      else
        flash[:error] = I18n.t('intervention_steps.errors.zipcode_not_supported')
      end
    else
      session[:intervention_type_id] = InterventionType.find_by_slug(params[:intervention_child_slug]).id
      @address_form = AddressForm.new
      render 'form_address'
    end
  end

  private
  # Using strong parameters
  def address_form_params
    params.require(:address_form).permit(:firstname, :lastname, :address1, :address2, :zipcode, :phone_number, :city)
  end
end
