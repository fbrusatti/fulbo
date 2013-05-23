class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
        admin_dashboard_path
    end
    if current_user.name.blank?
      edit_user_profile_path(current_user)
    else
      root_path
    end
  end
end
