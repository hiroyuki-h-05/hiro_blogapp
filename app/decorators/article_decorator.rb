module ArticleDecorator
  
  # 時間を表示するためのインスタンスメソッド
  def display_created_at
    I18n.l(self.created_at, format: :default)
  end

  # 投稿者の名前を取得
  def author_name
    user.display_name
  end

  def like_count
    likes.count
  end
  
end