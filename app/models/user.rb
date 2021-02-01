# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  ######################################################
  # リレーション
  ######################################################
    # 複数形になっているがarticlesモデルのことを指している
    # dependent: :destroyはuserが削除された時にarticleも削除するよという意
  has_many :articles, dependent: :destroy
  has_one :profile, dependent: :destroy # 単数系で記述

  
  # 中間テーブル(likes)を経由して記事を取得（user→like→article)
  # fabvorites_articlesは関連名
  # sourceは  Likeモデルのarticle_id  のことを指す
  has_many :favorite_articles, through: :likes, source: :article
  has_many :likes, dependent: :destroy
  

  

  # delegate
  delegate :birthday, :age, :gender, to: :profile, allow_nil: true

      # def birthday
      #   profile&.birthday
      # end

      # def gender
      #   profile&.gender
      # end

  #######################################################
  # インスタンスメソッド
  #######################################################
  
  def has_written?(article)
    articles.exists?(id: article.id)
  end

  def has_liked?(article)
    # current_userのいいねの中に、article_idが引数で渡されたインスタンスのidをもついいねが存在するか
    likes.exists?(article_id: article.id)
  end

  # ぼっち演算子(&.)で記述（こちらを使うと値がnilだったとしてもエラーが起こらない）
  def display_name
    # 左の式がtrueなら左の式の値を返す、そうでないなら右の式を実行（||演算子）
    profile&.nickname || self.email.split('@').first
  end

  # profileがあるば値を取得、なければ空のプロフィールインスタンスを容易
  def prepare_profile
    profile || build_profile
  end

  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end

end
