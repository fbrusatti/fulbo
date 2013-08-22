When(/^I press button to create a new League$/) do
  click_on(I18n.t("sport_centers.show.tournaments"))
  click_on(I18n.t("sport_centers.show.new_tournament"))
end

When(/^I submit the form$/) do
  click_button(I18n.t("leagues.btn_submit"))
end

Then(/^I should see a message advising me of the correctness$/) do
  page.should have_content I18n.t('flash.error_create_form')
end

When(/^I fill in all values in form league$/) do
  step 'I fill in "league_name" with "apertura"'
  choose 'league_category_5'
  fill_in "league_start_date", with: "2015-11-11"
end

Then(/^I should see successfully created league message$/) do
  page.should have_content I18n.t('flash.league',
                                  message: I18n.t('flash.created'),
                                  name: "apertura")
end

When(/^I go to to sport center "(.*?)" page$/) do |sport_center_name|
  sport_center = SportCenter.find_by_name(sport_center_name)
  visit sport_center_path(sport_center)
end

When(/^I click to see its leagues$/) do
  within("#top_navigation ul li#tournament") do
    first("a").click

    click_link I18n.t("sport_centers.show.see_tournaments")
  end
end

Given(/^There exists a SportCenter named "(.*?)"$/) do |sport_center_name|
  @sport_center = FactoryGirl.create(:sport_center, name: sport_center_name, slug: sport_center_name)
end

When(/^I visit the address "(.*?)"$/) do |address|
  visit address
end

Then(/^I should see the sport center profile page$/) do
  page.should have_content(@sport_center.name)
end

When(/^I go to page of all Sport Centers$/) do
  visit sport_centers_path
end

And (/^there exists a few Sport Centers$/) do
  3.times { FactoryGirl.create(:sport_center) }
end

Then(/^I should see all the Sport Centers listed$/) do
  # page.should have_all_sport_centers
  page.should have_css('.sport-center', count: SportCenter.count)
end
