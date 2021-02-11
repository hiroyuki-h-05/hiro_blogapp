namespace :notification do
  desc '利用者にメールを送付する'

  # 2つの引数を渡している
  # :send_emails_from_admin
  # {['msg'] => :environment}    ハッシュ
  task :send_emails_from_admin, ['msg'] => :environment do |task, args|
    msg = args['msg'] # ハッシュの呼び出し
    if msg.present?
      NotificationFromAdminJob.perform_later(msg)
    else
      puts '送信できませんでした。メッセージを入力してくてださい。ex. rails notification:send_emails_from_admin\[こんにちは\]'
    end
  end
end