Rails.application.routes.draw do
  # トップページ
  root 'home#top'

  # これでそれぞれにrouteingを書かなくてもいい感じにしてくれる
  # https://guides.rubyonrails.org/routing.html#crud-verbs-and-actions
  # 療養者
  resources :patients
  get 'patients/:id/image_form' => 'patients#image_form'
  post 'patients/:id/upload_image' => 'patients#upload_image'
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
  # コメント
  resources :comments
  # 使用ケア物品
  resources :using_care_tools
  # 使用除圧用具
  resources :using_depressure_tools
  
  # ログイン・ログアウト用
  get    'login'   => 'sessions#index'
  get    'login/:id'   => 'sessions#new'
  post   'login/:id'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
