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
                                              class: "btn"
      end
      btn_delete = content_tag(:div, class: "btn-group" ) do
        button_to t(".btn_delete"), league_path(@league),
                                                method: :delete,
                                                class: "btn btn-danger",
                                                confirm: t(".confirm_delete_msg")
      end
      btn_edit + btn_delete
    end
  end

  def buttons_owner_team(league)
    if is_owner_of_team? && has_sent_request_to_league?(@league)
      btn = content_tag(:div, class: "btn btn-primary disabled") do
        t(".has_been_sent_affiliation")
      end
      btn and return
    end
    if is_owner_of_team? && !playing_league?(league)
      field_requested = hidden_field_tag :requested_id, league.id
      field_requested_type = hidden_field_tag :requested_type, league.class.name
      button = submit_tag t(".btn_send_affiliation"), class: "btn btn-primary"
      form = form_for(@request_inscription,
                     url: team_request_inscriptions_path(current_user.team, league),
                     remote: true) do |f|
        field_requested + field_requested_type + button
      end
      form
    end
  end
end
