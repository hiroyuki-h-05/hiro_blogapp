namespace :notification do
  desc '利用者にメールを送付'

  task send_emails_from_admin: :environment do
    puts '初めてのRake task'
  end
end