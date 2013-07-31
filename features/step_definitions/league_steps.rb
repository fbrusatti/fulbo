Given(/^exists at least one League$/) do
  @owner_sc = FactoryGirl.create(:user)
  @sport_center = FactoryGirl.create(:sport_center, name: 'Maradona',
                                                    owner: @owner_sc)
  3.times {
    @sport_center.leagues << FactoryGirl.create(:league)
  }
end

Given(/^I am logged in like( not)? owner of a team$/) do |negation|
  if negation.present?
    login_as(@current_user, :scope => :user)
  else
    @owner_team = FactoryGirl.create(:user)
    @owner_team.team = FactoryGirl.create(:team)
    login_as(@owner_team, :scope => :user)
  end
end

When(/^I go to page of all Leagues$/) do
  visit leagues_path
end

When(/^I choose one League$/) do
  @league = @sport_center.leagues.last
  click_link("#{I18n.t('leagues.index.name')}: #{@league.name}")
end

Then(/^I should( not)? see inscription button to the League$/) do |negation|
  if negation.present?
    should_not have_button I18n.t("leagues.show.btn_send_affiliation")
  else
    should have_button(I18n.t("leagues.show.btn_send_affiliation"))
  end
end

Then (/^I should see all leagues listed$/) do
  page.should have_css("table.leagues tr", :count => League.count)
end

Then(/^I should see only the leagues of "(.*?)" sport center$/) do |sport_center_name|
  page.should have_only_leagues_of(sport_center_name)
end

Given(/^I visit the league page$/) do
  visit league_path(@sport_center.leagues.last)
end

When(/^I press inscription button$/) do
  click_on(I18n.t("leagues.show.btn_send_affiliation"))
end

Then(/^I should see that it was send$/) do
  page.should have_content(I18n.t("leagues.show.has_been_sent_affiliation"))
end

Given(/^I am logged in like owner of a league$/) do
  login_as(@owner_sc, scope: :user)
end

Given(/^I have an inscription request to my league$/) do
  @league = @sport_center.leagues.last
  requested_id = @league.id
  requested_type = @league.class.name
  @owner_team = FactoryGirl.create(:user)
  @owner_team.team = FactoryGirl.create(:team)
  @owner_team.team.inscription_requesters.create(requested_id: requested_id,
                                      requested_type: requested_type)
end

When(/^I go to edit page of my league$/) do
  visit edit_league_path(@league)
end

When(/^I press accept button of the inscription$/) do
  click_on(I18n.t('leagues.edit.action_affiliate'))
end

Then(/^I should see the team in list of teams that will play$/) do
  page.should have_content(I18n.t('leagues.edit.action_delete'))
end

Then(/^I should see the buttons to edit and delete my league$/) do
  page.should have_edit_buttons
end

Given(/^I have a fixture generated$/) do
  @league = @sport_center.leagues.last
  3.times {
    owner = FactoryGirl.create(:user)
    @league.teams << FactoryGirl.create(:team, owner: owner)
  }
  requested_id = @league.id
  requested_type = @league.class.name
  owner = FactoryGirl.create(:user)
  team = FactoryGirl.create(:team, owner: owner)
  team.inscription_requesters.create(requested_id: requested_id,
                                     requested_type: requested_type)
  @league.fixture = FactoryGirl.create(:fixture)
end

When(/^I go to teams tag on the League page$/) do
  visit edit_league_path(@league)
  click_on I18n.t('leagues.edit.teams')
end

Then(/^I should see disable the buttons to affiliate or unaffiliate$/) do
  page.should have_disable_buttons_of_teams
end

Then(/^I should see the delete fixture button$/) do
  page.should have_fixture_delete_button
end

Given(/^I have more than one team registered in my League$/) do
  @league = @sport_center.leagues.last
  2.times {
    owner = FactoryGirl.create(:user)
    @league.teams << FactoryGirl.create(:team, owner: owner)
  }
end

When(/^I click on button Generate Fixture of League$/) do
  click_on I18n.t("leagues.edit.generate_fixture")
end

Then(/^I should see the generate fixture page$/) do
  current_path.should == new_league_fixture_path(@league)
end

Given(/^I have less than two teams registered in my League$/) do
  @league = @sport_center.leagues.last
  owner = FactoryGirl.create(:user)
  @league.teams << FactoryGirl.create(:team, owner: owner)
end

Then(/^I should see the Fixture generate button disable$/) do
  page.should have_disable_fixture_generate_button
end
