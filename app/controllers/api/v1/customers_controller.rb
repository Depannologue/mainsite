class Api::V1::CustomersController < Api::V1::BaseController

  def index
    customers = User.customers.all
    render :json => array_serializer(customers)
  end

  def show
    customer = User.customers.find(params[:id])
    render :json => customer.restrict_for_api.to_json
  end

  def create
    customer = User.create(permitted_params)
    return api_error(status: 422, errors: customer.errors) unless customer.save
    render(
      json: customer,
      status: 201,
      location: api_v1_customer_path(customer.id)
    )
  end

  def update
    customer = UpdateCustomerService.perform(permitted_params, params[:id])
    return api_error(status: 422, errors: customer.errors) unless customer.save
    render(
      json:customer.exceptional_availabilities.last,
      status: 201,
      location: api_v1_customer_path(customer.id)
    )
  end

  def array_serializer customers
      customers_serialized = Array.new
      customers.each do |customer|
        customers_serialized.push(customer.restrict_for_api)
      end
      customers_serialized
  end

  private

  def permitted_params
    params.require(:user).permit(
      :firstname,
      :lastname,
      :phone_number,
      :email,
      :role,
      address_attributes: [
        :address1,
        :zipcode,
        :city
      ]
    )
  end
end
