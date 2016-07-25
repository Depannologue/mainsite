class Client::HomeController < ApplicationController
  include Client::AbilityConcern
  layout 'client/application'

  def index
    @profession = Profession.all
  end
end
