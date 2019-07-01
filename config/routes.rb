Rails.application.routes.draw do
  # トップページ
  get '/' => 'home#top'

  # 療養者詳細
  get 'patients/:id' => 'patients#show'
  # 療養者一覧
  get 'patients' => 'patients#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
