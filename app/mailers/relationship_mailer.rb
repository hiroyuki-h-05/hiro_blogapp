class RelationshipMailer < ApplicationMailer
  
  def new_follower(user, follower)
    @user = user # フォローされた人
    @follower = follower # フォローした人
    mail to: user.email, subject: '[お知らせ]フォローされました'
  end
end