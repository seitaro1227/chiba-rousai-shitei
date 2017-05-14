Rails.application.routes.draw do
  get 'static_pages/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'hospitals#index'
  get 'hospitals/search'

  # namespace :map do
    resources :hospitals, :only => :index
  # end

  namespace :admin do
    resources :hospitals
  end
end
