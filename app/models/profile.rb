# == Schema Information
#
# Table name: profiles
#
#  id           :bigint           not null, primary key
#  birthday     :date
#  gender       :integer
#  introduction :text
#  nickname     :string
#  subscribed   :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
class Profile < ApplicationRecord

  enum gender: { male: 0, female: 1, other: 2 } # 性別の定義付け
  belongs_to :user

  # プロフィールに仮想のavatarカラムを追加
  has_one_attached :avatar

  def age
    return '不明' unless birthday.present?
    years = Time.zone.now.year - birthday.year
    days = Time.zone.now.yday - birthday.yday   # 現在日 - 誕生日

    if days < 0       # 現在月を超えていない
      "#{years - 1}歳"
    else
      "#{years}歳"    # 現在日を超えている
    end
  end

end
