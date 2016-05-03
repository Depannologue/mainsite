class Admin::CustomersController < ApplicationController
  include Admin::AuthenticateConcern
  include Admin::AbilityConcern
  layout 'admin/application'

  before_filter :load_customer, only: %i(edit update)

  def index
    @customers = User.customers.page(params[:page])
  end

  def edit
  end

  def update
    if @customer.update_without_password(customer_params)
      flash[:success] = "Client mise à jour"
      redirect_to admin_customers_path
    else
      flash[:error] = "Erreur lors de la mise à jour du client"
      render :edit
    end
  end

  private

  def customer_params
    params.require(:user).permit(
      :email,
      :phone_number
    )
  end

  def load_customer
    @customer = User.customers.find(params[:id])
  end
end
