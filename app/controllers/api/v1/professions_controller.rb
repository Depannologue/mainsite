class Api::V1::ProfessionsController < Api::V1::BaseController

  def index
    professions = Profession.all
    render :json => array_serializer(professions)
  end

  def show
    profession = Profession.find(params[:id])
    render :json => profession.restrict_for_api.to_json
  end

  def array_serializer interventions
      interventions_serialized = Array.new
      interventions.each do |intervention|
        interventions_serialized.push(intervention.restrict_for_api)
      end
      interventions_serialized
  end
end
