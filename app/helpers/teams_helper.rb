module TeamsHelper
  CATEGORY = %w{5 6 7 8 9 10 11}
  SURFACE = %w{sand grass parquet synthetic_grass land cement}

  def owner_permission?
    user_signed_in? and current_user == @team.owner
  end

  def profile_badge(profile,size)
    image_tag profile.badge_url(size)
  end
end
