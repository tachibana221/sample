Rails.application.routes.draw do
  get 'patients/index'
  get '/' => 'home#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end