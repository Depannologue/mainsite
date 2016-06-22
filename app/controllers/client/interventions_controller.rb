class Client::InterventionsController < ApplicationController
  authorize_resource :Intervention
  include Client::AbilityConcern
  layout 'client/application'

  before_filter :load_intervention, only: %i(show)

  def index
    if client_signed_in?
      interventions = current_client.interventions
    else
      interventions = Intervention.where(client_token_ownership: session[:interventions_client_token_ownership])
    end
    @q = interventions.ransack params[:q]
    @interventions = @q.result.page(params[:page]).per(params[:per_page])
  end

  def show
    case @intervention.state
    when "pending_pro_validation"
      @pros_now_available_and_nearby = @intervention.pros_now_available_and_nearby
    when "pro_on_the_road"
      @pro = ProDecorator.new @intervention.contractor
    else
    end
  end

  private

  def load_intervention
    @intervention = Intervention.find(params[:id])
    authorize! :read, @intervention, (
                      params[:token] ||=
                      params[:intervention_client_token_ownership] ||=
                      params[:interventions_client_token_ownership] ||=
                      session[:intervention_client_token_ownership] ||=
                      session[:interventions_client_token_ownership] ||=
                      session[:current_intervention_client_token_ownership]
    )
  end
end
