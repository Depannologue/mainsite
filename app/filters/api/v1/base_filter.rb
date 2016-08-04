class Api::V1::BaseFilter
  attr_reader :resource, :params

  def initialize(resource, params)
    @resource = resource
    @params = params
  end

  def collection
    return resource
  end

  protected
  def with_associations(res, model: nil)
    unless model
      model = self.class.to_s.demodulize.gsub('Filter','').singularize.constantize
    end

      model.reflect_on_all_associations.map(&:name).each do |association|

        if params[association]

          association_name = association.to_s.titleize.split.join
          res = res.joins(association).merge(
            "Api::V1::#{association_name.pluralize}Filter".constantize.new(
              association_name.constantize.all, params[association]
            ).collection
          )

        end
      end

    return res

  end
end
