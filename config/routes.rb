Rails.application.routes.draw do
  root to: 'users#index'
  get 'availabilities/compare', to: 'availabilities#compare', as: 'availabilities_compare'
  post 'users/:id/compare_availability', to: 'users#compare_availability', as: 'compare_availability'
  resources :users do
    resources :availabilities
  end
end


