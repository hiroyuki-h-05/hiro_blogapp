# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord

  # 値が存在するかどうか
  validates :title, presence: true

  # 文字数
  validates :title, length: { minimum: 2, maximum: 100 }

  # 正規表現
  validates :title, format: { with: /\A(?!\@)/ }

  validates :content, presence: true
  validates :content, length: { minimum: 10 }
  validates :content, uniqueness: true

  # 独自のルール
  # validate :validate_title_and_content_length

  # Userモデルに所属している
  belongs_to :user        # belongs_toの場合は単数系

  # 時間を表示するためのインスタンスメソッド
  def display_created_at
    I18n.l(self.created_at, format: :default)
  end

  def author_name
    user.display_name
  end

  private

  # 独自のバリデーション
  def validate_title_and_content_length
    char_count = self.title.length + self.content.length
    unless char_count > 100
      # エラーメッセージを追加
      errors.add(:content, '100文字以上で！')
    end
  end
  
end
