class NotificationFromAdminJob < ApplicationJob
  def notify(user, msg)
    @msg = msg
    mail to: user.email, subject: 'お知らせ'
  end
end