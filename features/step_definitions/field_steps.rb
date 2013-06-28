Given(/^I have location$/) do
  @location = FactoryGirl.create(:location)
  @user.sport_center.locations << @location
  @user.save
end

When(/^I go to a location$/) do
  visit sport_center_location_path(@user.sport_center, @location)
end

Then(/^I should see new field button$/) do
  page.should have_button(I18n.t("locations.show.new_field"))
end

Given(/^I am authorized for create a field$/) do
  steps %{
    Given I am in my sport center page 
    And I have location }
  visit sport_center_location_path(@user.sport_center, @location)
end

When(/^I press new field button$/) do
  click_button(I18n.t("locations.show.new_field"))
end

When(/^I fill in form field$/) do
  step 'I fill in "field_name" with "Cancha 1"'
  select 'arena', :from => 'field_surface'
  select '11', :from => 'field_category'
end

When(/^I press save field$/) do 
  click_button(I18n.t('locations.new.btn_submit'))
end 

Then(/^I should see Successfully created field$/) do
  page.should have_content(I18n.t('flash.field', message: (I18n.t 'flash.created')))
end