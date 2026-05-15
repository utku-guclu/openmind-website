Rails.application.routes.draw do
  # Style guide (development only)
  get "styleguide", to: "pages#styleguide" if Rails.env.development?

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Public pages
  root "pages#home"
  get "about", to: "pages#about"
  get "volunteer", to: "pages#volunteer"
  get "volunteer/retired",       to: "pages#volunteer_audience", defaults: { audience: "retired" },       as: :volunteer_retired
  get "volunteer/gap-year",      to: "pages#volunteer_audience", defaults: { audience: "gap_year" },      as: :volunteer_gap_year
  get "volunteer/internship",    to: "pages#volunteer_audience", defaults: { audience: "internship" },    as: :volunteer_internship
  get "volunteer/career-break",  to: "pages#volunteer_audience", defaults: { audience: "career_break" },  as: :volunteer_career_break
  get "volunteer/csr",           to: "pages#volunteer_audience", defaults: { audience: "csr" },           as: :volunteer_csr
  get "research-development", to: "pages#research"

  # Projects
  resources :projects, only: [:index, :show], param: :slug

  # Destinations
  resources :destinations, only: [:index, :show], param: :slug

  # News/Blog
  resources :posts, only: [:index, :show], param: :slug, path: "news", as: "news"

  # Volunteer applications
  resources :applications, only: [:new, :create], path: "apply"

  # Contact
  resource :contact, only: [:new, :create]

  # Donate redirect
  get "donate", to: redirect("https://fundhub.openskills.dev/", status: 302)

  # Analytics beacon
  post "analytics/track", to: "analytics#track"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Admin namespace (Phase 4)
  # namespace :admin do
  #   root "dashboard#index"
  #   resources :projects
  #   resources :destinations
  #   resources :posts
  #   resources :applications, only: [:index, :show, :update]
  #   resources :team_members
  #   resources :partners
  #   resources :testimonials
  #   resource :settings, only: [:edit, :update]
  # end
end
