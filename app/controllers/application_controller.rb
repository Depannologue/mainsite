class ApplicationController < ActionController::Base
  include Knock::Authenticable
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :check_for_lockup, if: -> { Rails.application.secrets[:lockup_actived] }

  layout :layout_by_resource

  def after_sign_in_path_for(resource)
    if resource.has_role? :contractor
      pro_interventions_path
    else
      client_interventions_path
    end
  end

  private

  protected

  def layout_by_resource
    if devise_controller?
      if resource_name == :admin
        "admin/application"
      elsif resource_name == :pro
        "pro/application"
      else
        "client/application"
      end
    else
      "client/application"
    end
  end
end
