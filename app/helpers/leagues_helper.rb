module LeaguesHelper
  CATEGORY = %w{5 6 7 8 9 10 11}

  def owner_of_league?(league)
    current_user == league.organizer.owner
  end
end
