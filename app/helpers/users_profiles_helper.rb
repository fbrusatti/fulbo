module UsersProfilesHelper

  POSITIONS = %w{Goalkeeper Defender Midfielder Forward Coach Coaching Staff Referee Assistant }
  FOOTS = %w{right left ambidextro  }

  def profile_avatar(profile,size)
    image_tag profile.avatar_url(size)
  end      
end

