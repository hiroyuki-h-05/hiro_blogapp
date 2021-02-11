require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?

  # dev環境であればat以下のURLでLetterOpenerwebの内容が見れるようになるという設定
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # homeコントラーラのindexアクションを実行
  # get '/' => 'home#index'

  # root_pathの設定(/のパス)
  root to: 'articles#index'

  # URLの生成（入れ子構造になっている）
  resources :articles

  # ユーザーごとのアカウント詳細ページと、それに関するフォロー・アンフォロー
  resources :accounts, only: [:show] do
    resources :follows, only: [:create]
    resources :unfollows, only: [:create]
  end

  # ログインユーザに関するルーティング
  scope module: :apps do
    # indexページやパスに渡すid必要性もないのでuserとprofileは1対1の関係なのでresourceと記述（indexページは必要ない）
    resources :favorites, only: [:index] # いいね一覧 (中級編 day25-4)
    resource :profile, only: [:show, :edit, :update]
    resource :timeline, only: [:show]
  end

  namespace :api, defaults: {format: :json} do
    scope '/articles/:article_id' do
      resources :comments, only: [:index, :new, :create]
      resource :like, only: [:show, :create, :destroy]
    end
  end
  
end
