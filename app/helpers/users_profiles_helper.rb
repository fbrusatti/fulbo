module UsersProfilesHelper

  POSITIONS = %w{Goalkeeper Defender Midfielder Forward Coach Coaching Staff Referee Assistant }
  FOOTS = %w{right left ambidextro}.map{ |key| I18n.t("user_profile.#{key}")}

  def profile_avatar(profile,size)
    image_tag profile.avatar_url(size)
  end      

  def user_profile_positions(form)
    label = content_tag :label,
                        I18n.t('user_profile.field_position')

    options = ""
    UsersProfilesHelper::POSITIONS.each do |position|
      check_box = form.check_box :playing_position,
                                 {:multiple => true},
                                 position,
                                 nil
      position_label = form.label position

      options << check_box + position_label
    end

    options_div = content_tag :div, options.html_safe, class: 'user-profile-positions'
    label + options_div
  end
end

