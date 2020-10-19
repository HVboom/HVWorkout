class ApplicationController < ActionController::Base
  prepend_before_action :switch_locale

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :nickname])
  end


  private

  def default_url_options
    {locale: I18n.locale}
  end

  def switch_locale
    I18n.locale = params[:locale] ||
                  http_accept_language.compatible_language_from(I18n.available_locales) ||
                  I18n.default_locale
  end
end
