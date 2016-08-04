class Api::V1::ProfessionsFilter < Api::V1::BaseFilter

  def collection
    professions = self.resource
    unless params[:slug].blank?
      professions = professions.where("professions.slug": "#{params[:slug]}")

    end
    return self.with_associations(professions)
  end

end
