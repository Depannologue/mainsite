class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  before_filter :basic_authentication, if: Figaro.env.LOCK_APP

  def after_sign_in_path_for(resource)
    if resource.has_role? :contractor
      pro_interventions_path
    else
      client_interventions_path
    end
  end

  private

  def basic_authentication
    authenticate_or_request_with_http_basic do |u, p|
      return true
      u == Figaro.env.ADMIN_USER && p == Figaro.env.ADMIN_PASSWORD
    end
  end


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
