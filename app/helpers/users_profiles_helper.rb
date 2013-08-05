module UsersProfilesHelper

  POSITIONS = %w{Goalkeeper Defender Midfielder Forward Coach Coaching Staff Referee Assistant }
  FOOTS = %w{right left ambidextro}.map{ |key| I18n.t("user_profile.#{key}")}

  def search_result_message(name, pos)
    pos = I18n.t(".user_profile.playing_position.#{pos}") if pos.present?

    if name.present? && pos.present?
      I18n.t('user_profile.result_search_params', name: name, position: pos)
    elsif name.present? || pos.present?
      I18n.t('user_profile.result_search_param',
           name: "#{name} #{pos}")
    end
  end

  def result_found(profiles)
    I18n.t('user_profile.not_found_result') if profiles.empty?
  end

  def positions
    POSITIONS.map{ |pos| [I18n.t(".user_profile.playing_position.#{pos}"), pos] }
  end

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

  def avatar(form, profile)
    form.label :avatar, :class => "img-polaroid pull-right" do
      image_tag(@profile.avatar_url(:thumb)) if @profile.avatar?
    end
  end

  def remove_avatar_section(form)
    if @profile.avatar.url.present?
      check_box = form.check_box :remove_avatar
      label     = form.label :remove_avatar, I18n.t("user_profile.remove_avatar")
      content_tag :div, check_box + label, class: 'form-inline'
    end
  end

  def edit_button
    if user_signed_in? && current_user == @user
      link_to t('.link_edit'),
              edit_user_profile_path(@user),
              class: 'btn btn-info'
    end
  end
end
