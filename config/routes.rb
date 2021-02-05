Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # homeコントラーラのindexアクションを実行
  # get '/' => 'home#index'

  # root_pathの設定(/のパス)
  root to: 'articles#index'

  # URLの生成（入れ子構造になっている）
  resources :articles do
    resources :comments, only: [:index, :new, :create]
    resource :like, only: [:show, :create, :destroy]
  end

  # ユーザーごとのアカウント詳細ページと、それに関するフォロー・アンフォロー
  resources :accounts, only: [:show] do
    resources :follows, only: [:create]
    resources :unfollows, only: [:create]
  end

  resource :timeline, only: [:show]

  # indexページやパスに渡すid必要性もないのでuserとprofileは1対1の関係なのでresourceと記述（indexページは必要ない）
  resource :profile, only: [:show, :edit, :update]

  # いいね一覧 (中級編 day25-4)
  resources :favorites, only: [:index]
  
end
