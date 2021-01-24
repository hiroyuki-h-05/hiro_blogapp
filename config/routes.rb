Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # homeコントラーラのindexアクションを実行
  # get '/' => 'home#index'

  # root_pathの設定(/のパス)
  root to: 'articles#index'

  # URLの生成（入れ子構造になっている）
  resources :articles do
    resources :comments, only: [:new, :create]
    resource :like, only: [:create, :destroy]
  end

  # userとprofileは1対1の関係なのでresourceと記述（indexページは必要ない）
  resource :profile, only: [:show, :edit, :update]

  # いいね一覧
  resources :favorites, only: [:index]
  
  # onlyオプション（指定のアクションのみ）
      # resources :articles only: [:show, :new, :create, :edit, :update, :destroy]

end
