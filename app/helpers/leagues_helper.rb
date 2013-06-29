module LeaguesHelper
  CATEGORY = %w{5 6 7 8 9 10 11}

  def owner_of_league?(league)
    current_user == league.organizer.owner
  end

  def is_owner_of_team?
    current_user && current_user.team
  end

  def has_sent_request_to_league?(league)
    current_user.team.requests_to_register.exists?(@league)
  end
end
