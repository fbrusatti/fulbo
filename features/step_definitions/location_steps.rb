Given(/^I am in my sport center page$/) do
  steps %{ Given I am logged in }
  @user.sport_center = FactoryGirl.create(:sport_center)
  @user.save
  visit sport_center_path(@user.sport_center)
end

When(/^I go to location page$/) do
  visit sport_center_locations_path(@user.sport_center)
end

Then(/^I should see new location button$/) do
  page.should have_button(I18n.t("locations.index.btn_new"))
end

Given(/^I am authorized for create a location$/) do
  steps %{
    Given I am in my sport center page }
end

When(/^I press new location button$/) do
  click_button(I18n.t("locations.index.btn_new"))
end

Then(/^I should see Successfully "(.*?)" location$/) do |arg1|
  page.should have_content(I18n.t('flash.location', message: (I18n.t 'flash.created')))
end
