class ApplicationController < ActionController::Base
  include Clearance::Controller

  before_action :require_login
  around_action :switch_locale

  def switch_locale(&action)
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    locale = extract_locale_from_accept_language_header
    logger.debug "* Locale set to '#{locale}'"
    I18n.with_locale(locale, &action)
  end

  private
    def extract_locale_from_accept_language_header
      return I18n.default_locale unless request.env['HTTP_ACCEPT_LANGUAGE']

      lang = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
      lang_region = :"#{request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}-[A-Z]{2}/).first}"
      if I18n.available_locales.include? lang_region
        return lang_region
      elsif I18n.available_locales.include? lang
        return lang
      else
        return I18n.default_locale
      end
    end

end
