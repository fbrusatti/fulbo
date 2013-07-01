Given(/^exists at least one League$/) do
  @sport_center = FactoryGirl.create(:sport_center)
  @league = FactoryGirl.create(:league)
  @sport_center.leagues << @league
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
