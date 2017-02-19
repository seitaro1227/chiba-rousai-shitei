Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'hospitals#index'
  post 'hospitals/set_geolocation'
end
