class ApplicationMailer < ActionMailer::Base
  default from: 'yokoyama.hiro05@gmail.com' # from以下のメールアドレスからメールを送信
  layout 'mailer' # /app/views/layouts配下のmailerファイルを使用すると明示
end
