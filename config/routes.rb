Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # homeコントラーラのindexアクションを実行
  # get '/' => 'home#index'

  # root_pathの設定(/のパス)
  root to: 'articles#index'

  # 色々なURLを生成する(今回はshowのみ使用)
  resources :articles, only: [:show]

end
