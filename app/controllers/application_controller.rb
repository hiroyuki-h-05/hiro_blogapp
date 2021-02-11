class ApplicationController < ActionController::Base
  before_action :set_locale

  # deviseとActiveDecoratorの相性問題を解決
  def current_user
    ActiveDecorator::Decorator.instance.decorate(super) if super.present?
    super
  end

  # 必ず実行されるメソッド（規約）
  def default_url_options
    { locale: I18n.locale }
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end

# /articles?id=1
  # params[:id] => 1