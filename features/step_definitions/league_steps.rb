Given(/^exists at least one League$/) do
  @sport_center = FactoryGirl.create(:sport_center)

  3.times {
    @league = FactoryGirl.create(:league)
    @sport_center.leagues << @league
  }

  @sport_center = FactoryGirl.create(:sport_center, name: 'Maradona',
                                                    owner: @current_user)
  3.times {
    @sport_center.leagues << FactoryGirl.create(:league)
  }
end

When(/^I go to page of all Leagues$/) do
  visit leagues_path
end

When(/^I choose one League$/) do
  click_link("#{I18n.t('leagues.index.name')}: #{@league.name}")
end

Then(/^I should( not)? see inscription button to the League$/) do |negation|
  if negation.present?
    should_not have_button I18n.t("leagues.show.btn_send_affiliation")
  else
    should have_button(I18n.t("leagues.show.btn_send_affiliation"))
  end
end

Then /^I should see all leagues listed$/ do
  page.should have_css("table.leagues tr", :count => League.count)
end

Then(/^I should see only the leagues of "(.*?)" sport center$/) do |sport_center_name|
  page.should have_only_leagues_of(sport_center_name)
end

