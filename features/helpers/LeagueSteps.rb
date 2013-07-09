module LeagueSteps
  include Capybara::DSL

  def has_only_leagues_of?( sport_center_name )
    @sport_center = SportCenter.find_by_name(sport_center_name)

    organizers = all(".span3.organizer a")

    #has_css?("table.leagues tr", count: @sport_center.leagues.count)
    organizers.all?{ |o| o.text == @sport_center.name }
  end

  def has_edit_buttons?
    has_button?(I18n.t('leagues.show.btn_edit')) &&
    has_button?(I18n.t('leagues.show.btn_delete'))
  end
end
