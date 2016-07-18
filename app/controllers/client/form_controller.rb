class Client::FormController < ApplicationController
  def show
    session[:intervention_type_id] = InterventionType.find_by_slug(params[:intervention_child_slug]).id
    @address = Address.new unless session[:current_address_id].present?
    @address = Address.find_by_id session[:current_address_id] if session[:current_address_id].present?
    render 'form_address'
  end

  def new
    @address = Address.new unless session[:current_address_id].present?
    @address_form = AddressForm.new(address_form_params)
    if ZipCode.managed? @address_form.zipcode
      if @address_form.save
        session[:current_address_id] = @address_form.id
        #redirect_to controller: 'quotations', action: 'show', :id => @adress_form.id
        redirect_to "/devis/#{@address_form.id}"
      else
        flash[:error] = @address_form.errors.full_messages[0]
        render 'form_address'
      end
    else
      flash[:error] = I18n.t('intervention_steps.errors.zipcode_not_supported')
      render 'form_address'
    end
  end

  def edit
    @address = Address.find_by_id session[:current_address_id] if session[:current_address_id].present?
    @address_form = AddressForm.new(address_form_params)
    if ZipCode.managed? @address_form.zipcode
      if @address_form.save
        redirect_to "/devis/#{@address_form.id}"
      else
        flash[:error] = @address_form.errors.full_messages[0]
        render 'form_address'
      end
    else
      flash[:error] = I18n.t('intervention_steps.errors.zipcode_not_supported')
      render 'form_address'
    end
  end

  private
  # Using strong parameters
  def address_form_params
    params.require(:address).permit(:firstname, :lastname, :address1, :address2, :zipcode, :phone_number, :city)
  end
end
