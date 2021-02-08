class NotificationFromAdminJob < ApplicationJob
  queue_as :default
  
  # jobを実行したときにperformメソッドが実行される（ルール）
  def perform(msg)
    User.all.each do |user|
      NotificationFromAdminMailer.notify(user, msg).deliver_later
    end
  end
end