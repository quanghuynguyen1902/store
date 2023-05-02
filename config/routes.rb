Rails.application.routes.draw do
  # Health check and PWA routes (outside locale scope)
  get "up" => "rails/health#show", as: :rails_health_check
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  
  # Root route redirects to default locale
  root to: redirect("/#{I18n.default_locale}")
  
  # Locale-specific routes
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root "products#index"
    resource :session
    resources :passwords, param: :token
    resources :products
  end
end
