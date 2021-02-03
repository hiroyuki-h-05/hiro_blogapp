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


  # リレーション
  
  # has_manyの関連名は複数形。articlesモデルのことを指している。
  has_many :articles, dependent: :destroy # Userモデルのインスタンスが削除されたときに関連づいたモデルのインスタンスも削除するための記述
  has_one :profile, dependent: :destroy # 単数系で記述

  
  # 中間テーブル(likes)を経由して記事を取得（user→like→article)
  # fabvorites_articlesは関連名
  has_many :likes, dependent: :destroy
  has_many :favorite_articles, through: :likes, source: :article # sourceは  Likeモデルのarticle_id  のことを指す


  # 自分がフォローしている相手を探す
  
    has_many :following_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy

    # following_relationshipsテーブルのfollower_id（自分のid）を経由し、following_id（フォロー対象）の情報を取得
    has_many :followings, through: :following_relationships, source: :following

  # フォロワーを探す

    has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'following_id', dependent: :destroy
    has_many :followers, through: :follower_relationships, source: :follower                                            # フォロワーの情報を取得するための記述

  # delegate

    delegate :birthday, :age, :gender, to: :profile, allow_nil: true

        # def birthday
        #   profile&.birthday
        # end

        # def gender
        #   profile&.gender
        # end

  # インスタンスメソッド
  
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

  # フォローするためのメソッド
  # 自分（follwer_id）が紐づいたインスタンスをもとに生成。
  # 引数にはフォローしたいユーザーのインスタンスを渡す。
  def follow!(user)
    user_id = get_user_id(user)
    following_relationships.create!(following_id: user_id)
  end

  def unfollow!(user)
    user_id = get_user_id(user)
    relation = following_relationships.find_by!(following_id: user_id)
    relation.destroy!
  end

  def has_followed?(user)
    following_relationships.exists?(following_id: user.id)
  end

  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end

  private

  def get_user_id(user)
    if user.is_a?(User)
      user.id
    else
      user
    end
  end
end
