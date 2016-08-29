  class AppConstraints
  def initialize(options)
    @subdomain = options[:subdomain]
  end

  def matches?(request)
    request_subdomain = request.host.split('.').first
    return request_subdomain == @subdomain
  end
end

Rails.application.routes.draw do

  get 'test' , to: 'client/service_provider#show', as: :service_provider_show
  get 'test/form' , to: 'client/service_provider#new', as: :service_provider_new
  post 'test/form/create' , to: 'client/service_provider#create', as: :service_provider_create
  get 'profession/:profession', to: 'client/profession#show', as: :profession_show
  get '/intervention/:intervention_parent_slug', to: 'client/intervention_type#show', as: :intervention_type_show
  get '/intervention/:intervention_parent_slug/:intervention_child_slug', to: 'client/form#new', as: :intervention_form_new
  post '/intervention/:intervention_parent_slug/:intervention_child_slug', to: 'client/form#create', as: :intervention_form_create
  get '/devis', to: 'client/quotations#new', as: :quotations_new


  mount Lockup::Engine, at: '/lockup'
  constraints(AppConstraints.new subdomain: 'admin') do
    namespace :admin, module: 'admin', path: '/' do

      require 'sidekiq/web'
      authenticate :admin, lambda { |u| u.has_role? :admin } do
        mount Sidekiq::Web => '/jobs/sidekiq'
      end

      resources :areas do
        get '/zipcode/:zipcode', to: 'areas#zipcode', on: :collection
      end
      resources :intervention_types, except: :show
      resources :interventions, only: [:index, :edit, :update, :destroy]
      resources :customers, only: [:index, :edit, :update]
      resources :contractors
      root to: 'interventions#index'
    end
    devise_for :admins, class_name: 'User'
  end

  constraints(AppConstraints.new subdomain: 'pro') do
    namespace :pro, module: 'pro', path: '/' do
      resources :interventions, only: [:index, :show, :update]
      resources :interventions, only: [], param: :intervention_id do
        member do
          resources :intervention_steps, only: [:show, :update]
        end
      end
      get '/profile', to: 'profile#edit'
      put '/profile', to: 'profile#update'
      patch '/profile', to: 'profile#update'
      root to: 'interventions#index'
    end
    devise_for :pros, class_name: 'User'
  end

  get '/cgu' => 'static_pages#cgu'
  get '/mentions-legales' => 'static_pages#legals_mentions'

  constraints(AppConstraints.new subdomain: 'www') do
    namespace :client, module: 'client', path: '/' do
      resources :interventions, only: [:index, :show]
      get '/lille', to: 'home#lille'
      get '/lyon', to: 'home#lyon'
      resources :intervention_steps, path: '/', only: [:show, :update] do
        collection do
          post ':id', to: 'intervention_steps#create'
        end
      end
      root to: 'home#index'
    end
    devise_for :clients, class_name: 'User'
  end
end
