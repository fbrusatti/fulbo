Given(/^I have two field in my Sport Center$/) do
  @sport_center.locations << FactoryGirl.create(:location)
  @location = @sport_center.locations.first
  2.times { @location.fields << FactoryGirl.create(:field) }
end

When(/^I go to Fixture create page$/) do
  visit new_league_fixture_path(@league)
end

When(/^I select the Sunday day and press next$/) do
  check "0"
  click_link "next_step"
end

When(/^I choose time start (\d+):(\d+) PM  and time to finish (\d+):(\d+) PM for Sunday$/) do |h1, m1, h2, m2|
  fill_in 'rules__time_from', :with => "#{h1}:#{m1}"
  fill_in 'rules__time_to', :with => "#{h2}:#{m2}"
end

When(/^I choose the first field for Sunday$/) do
  field_id = @location.fields.first.id
  find(:css, "#rules__fields_[value='#{field_id}']").set(true)
end

When(/^I press the Fixture create button$/) do
  click_on I18n.t("fixtures.new.create_fixture")
end

Then(/^I should see Successfully created Fixture$/) do
  page.should have_content I18n.t('flash.fixture',
                                  message: I18n.t('flash.created'),
                                  name: @league.name)
end
