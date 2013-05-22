class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    if current_user.profile
      root_path
    else
      new_user_profile_path(current_user)
    end
  end
end
