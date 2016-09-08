class Api::V1::ContractorsController < Api::V1::BaseController

  def index
    contractors = User.contractors.all
    render :json => array_serializer(contractors)
  end

  def show
    contractor = User.contractors.find(params[:id])
    render :json => contractor.restrict_for_api.to_json
  end

  def update
    contractor = UpdateContractorService.perform(permitted_params, params[:id])
    return api_error(status: 422, errors: contractor.errors) unless contractor.save
    render(
      json:contractor.exceptional_availabilities.last,
      status: 201,
      location: api_v1_contractor_path(contractor.id)
    )
  end

  def array_serializer contractors
      contractors_serialized = Array.new
      contractors.each do |contractor|
        contractors_serialized.push(contractor.restrict_for_api)
      end
      contractors_serialized
  end

  private

  def permitted_params
    params.require(:user).permit(
      :firstname,
      :lastname,
      :phone_number,
      address_attributes: [
        :latitude,
        :longitude
      ],
      exceptional_availabilities_attributes: [
        :available_now
      ],
      weekly_availability_attributes: WeeklyAvailability::TIME_SLOTS.map do |from_to|
        WeeklyAvailability::DAYS.map do |day|
          :"#{day}_#{from_to}_availability"
        end
      end.flatten << :id
    )
  end
end
