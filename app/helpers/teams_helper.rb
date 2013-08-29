module TeamsHelper
  CATEGORY = %w{5 6 7 8 9 10 11}
  SURFACE = %w{sand grass parquet synthetic_grass land cement}

  def owner_permission?
    user_signed_in? and current_user == @team.owner
  end

  def profile_badge(profile,size)
    image_tag profile.badge_url(size)
  end

  def surfaces
    SURFACE.map{ |sur| [I18n.t(".teams.surfaces.#{sur}"), sur] }
  end

  def search_result_messages(name, surface, category)
    surface = I18n.t(".teams.surfaces.#{surface}") if surface.present?
    has_name_and_sur = name.present? && surface.present?
    has_name_and_cat = name.present? && category.present?
    has_sur_and_cat = surface.present? && category.present?
    
    if name.present? && surface.present? && category.present?
      I18n.t('.teams.result_search_params', name: name, surface: surface, category: category)
    elsif has_name_and_sur 
      result_message(name, surface)
    elsif has_name_and_cat
      result_message(name, category)
    elsif has_sur_and_cat
      result_message(surface, category)
    elsif name.present? || surface.present? || category.present?
      I18n.t('.teams.result_search_param', param:  "#{name} #{surface} #{category}")
    end
  end

  def result_message (first_param, second_param)
    I18n.t('.teams.result_search_two_params', 
           first_param: first_param, second_param: second_param)
  end

  def result_found(teams_profiles)
    I18n.t('.teams.not_found_result') if teams_profiles.empty?
  end

  def team_button
    if user_signed_in? && current_user.team.present?
      path = team_path(current_user.team)
      btn_msj = t("teams.search_data.btn_team")
    else
      path = new_team_path
      btn_msj = t("teams.search_data.btn_create")
    end
    link_to btn_msj, path, class: "btn-team"
  end

end
