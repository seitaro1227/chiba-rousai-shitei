Rails.application.routes.draw do
  get 'static_pages/about'
  get 'static_pages/top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'static_pages#top'


  # namespace :map do
    resources :hospitals, :only => :index
  # end
end
