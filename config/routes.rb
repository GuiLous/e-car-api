require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admins

  authenticate :admin do
    mount Sidekiq::Web => '/sidekiq'
    
    resources :assistant_submissions do
      member do
        post :approve
        post :reject
      end
    end
  end

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
