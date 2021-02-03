class ApplicationController < ActionController::Base

  # deviseとActiveDecoratorの相性問題を解決
  def current_user
    ActiveDecorator::Decorator.instance.decorate(super) if super.present?
    super
  end
  
end