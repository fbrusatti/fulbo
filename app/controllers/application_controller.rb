class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    profile = current_user.user_profile
    if profile
      root_path
    else
      new_user_profile_path(current_user.id)
    end
  end


end
