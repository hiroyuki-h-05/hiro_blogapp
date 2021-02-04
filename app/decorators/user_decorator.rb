# frozen_string_literal: true

module UserDecorator

  # ぼっち演算子(&.)で記述（こちらを使うと値がnilだったとしてもエラーが起こらない）
  def display_name
    # 左の式がtrueなら左の式の値を返す、そうでないなら右の式を実行（||演算子）
    profile&.nickname || self.email.split('@').first
  end

  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end

end
