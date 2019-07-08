Rails.application.routes.draw do
  # トップページ
  root 'home#top'

  # これでそれぞれにrouteingを書かなくてもいい感じにしてくれる
  # まじでon railsってかんじ
  # https://guides.rubyonrails.org/routing.html#crud-verbs-and-actions
  resources :patients
  resources :nurses
  resources :depressure_tools
  resources :care_tools
  resources :bedsore_parts

  # ログイン・ログアウト用
  get    'login'   => 'sessions#index'
  get    'login/:id'   => 'sessions#new'
  post   'login/:id'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
