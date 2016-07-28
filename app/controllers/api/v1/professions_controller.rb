class Api::V1::ProfessionsController < Api::V1::BaseController
  include ActiveHashRelation
  def index
    professions = Profession.all
    professions = apply_filters(professions, params)
    render(
      json: ActiveModel::ArraySerializer.new(
        professions,
        each_serializer: Api::V1::ProfessionSerializer,
        root: 'professions',
      )
    )
  end
  def show
    profession = Profession.find(params[:id])
    render(json: Api::V1::ProfessionSerializer.new(profession).to_json)
  end
end
