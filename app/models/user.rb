# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
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
    # 複数形になっているがarticlesモデルのことを指している
    # dependent: :destroyはuserが削除された時にarticleも削除するよという意
  has_many :articles, dependent: :destroy
  has_one :profile, dependent: :destroy # 単数系で記述

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

  # ぼっち演算子で記述（こちらを使うと値がnilだったとしてもエラーが起こらない）
  def display_name
    # profileの値が存在すれば profile.nickname
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
