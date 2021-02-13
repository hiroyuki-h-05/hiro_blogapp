class Apps::FavoritesController < Apps::ApplicationController

  # お気に入りをした記事一覧を取得
  def index
    @articles = current_user.favorite_articles
  end

end