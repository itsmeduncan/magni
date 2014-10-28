Rails.application.routes.draw do
  namespace :v1 do
    resources :locations, only: [:show, :create]
  end
end
