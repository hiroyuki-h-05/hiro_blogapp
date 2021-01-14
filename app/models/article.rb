class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  # 時間を表示するためのインスタンスメソッド
  def display_created_at
    I18n.l(self.created_at, format: :default)
  end
  
end
