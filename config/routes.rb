Rails.application.routes.draw do
  # トップページ
  root 'home#top'

  # これでそれぞれにrouteingを書かなくてもいい感じにしてくれる
  # まじでon railsってかんじ
  # https://guides.rubyonrails.org/routing.html#crud-verbs-and-actions
  # 療養者
  resources :patients
  # 看護師
  resources :nurses
  # 除圧用具
  resources :depressure_tools
  # ケア用品
  resources :care_tools
  # 褥瘡部位
  resources :bedsore_parts
  # ケア情報
  resources :care_infos
  # 褥瘡
  resources :bedsores
  get 'bedsores/:id/paint' => 'bedsores#paint'
  # DesignR
  resources :design_rs
  
  # ログイン・ログアウト用
  get    'login'   => 'sessions#index'
  get    'login/:id'   => 'sessions#new'
  post   'login/:id'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
