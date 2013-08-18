module LeaguesHelper
  CATEGORY = %w{5 6 7 8 9 10 11}

  def is_owner_of_team?
    current_user && current_user.team
  end

  def has_sent_request_to_league?(league)
    team = current_user.team
    team.inscription_requesters.exists?(requested_id: league, status: :waiting)
  end

  def playing_league?(league)
    team = current_user.team
    team.leagues.exists?(league)
  end

  def buttons_organizer_league(league)
    if current_user == league.organizer.owner
      btn_edit = content_tag(:div, class: "btn-group" ) do
        button_to t(".btn_edit"), edit_league_path(@league),
                                              method: :get,
                                              class: "edit-button"
      end
      btn_delete = content_tag(:div, class: "btn-group" ) do
        button_to t(".btn_delete"), league_path(@league),
                                                method: :delete,
                                                class: "delete-button",
                                                confirm: t(".confirm_delete_msg")
      end
      btn_edit + btn_delete
    end
  end

  def buttons_owner_team(league)
    return if league.fixture
    if is_owner_of_team? && has_sent_request_to_league?(@league)
      btn = content_tag(:div, class: "affiliation-sent-button") do
        t(".has_been_sent_affiliation")
      end
      btn and return
    end
    if is_owner_of_team? && !playing_league?(league)
      field_requested = hidden_field_tag :requested_id, league.id
      field_requested_type = hidden_field_tag :requested_type, league.class.name
      button = submit_tag t(".btn_send_affiliation"), class: "send-affiliation-button"
      form = form_for(@request_inscription,
                     url: team_request_inscriptions_path(current_user.team, league),
                     remote: true) do |f|
        field_requested + field_requested_type + button
      end
      form
    end
  end

  def fixture_league_button(league)
    if league.fixture.blank?
      link_to t(".generate_fixture"),
              new_league_fixture_path(league),
              confirm: t(".fixture_confirm"),
              class: "generate-fixture"
    else
      link_to t(".destroy_fixture"),
              league_fixture_path(league),
              method: :delete,
              confirm: t(".fixture_confirm"),
              class: "destroy-fixture"
    end
  end

  def league_fixture(league)
    if league.fixture
      link_to t("leagues.index.see_fixture"),
              league_fixture_path(league),
              class: "see-fixture"
    end
  end

  def league_status(league)
    html = ""
    if league.number_teams.present?
      if league.teams.count < league.number_teams
        html << content_tag(:div, class: "label label-success" ) do
          "#{t('leagues.index.available_inscriptions')}: #{league.number_teams - league.teams.count}"
        end
      else
        html << content_tag(:div, class: "label label-important" ) do
          t('leagues.index.unavailable_inscriptions')
        end
      end
      html << "<br>"
      html << t('leagues.index.registered')
      html << content_tag(:div, class: "label label-default" ) do
        "#{league.teams.count}/#{league.number_teams}"
      end
      html.html_safe
    else
      html << "#{t('leagues.index.registered')}"
      html << content_tag(:div, class: "label label-default" ) do
        "#{league.teams.count}/#"
      end
      html.html_safe
    end
  end

  def league_categories(league, form)
    html = ""
    LeaguesHelper::CATEGORY.each do |category|
      radio_button = form.radio_button :category, category, { }
      category_label = form.label "category_#{category}", "#{category}"
      cl = category_label + radio_button
      html << (content_tag :div, cl, class: "category").to_s
    end
    categories = content_tag :div, html.html_safe, class: "categories"
  end
end
