class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_dashboard_path

    elsif current_user.name.blank?
      edit_user_profile_path(current_user)

    else
      root_path
    end
  end

  private
  def set_locale
    if language_request = request.env["HTTP_ACCEPT_LANGUAGE"]
      language   = extract_locale_from_accept_language_header(language_request)
      @locale     = language.blank? ? params[:lang] : language
      I18n.locale = @locale
    end
  end

  def extract_locale_from_accept_language_header(http_var)
    http_var.scan(/^[a-z]{2}/).first
  end
end
