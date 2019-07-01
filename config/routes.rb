Rails.application.routes.draw do
  # トップページ
  get '/' => 'home#top'

  # 療養者新規登録ページ
  get 'patients/new' => 'patients#new'
  # 療養者新規登録
  post 'patients/create' => 'patients#create'
  # 療養者詳細ページ
  get 'patients/:id' => 'patients#show'
  # 療養者一覧
  get 'patients' => 'patients#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
