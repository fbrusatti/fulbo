Given(/^I am in my sport center page$/) do
  step 'I am logged in'
  @current_user.sport_center = FactoryGirl.create(:sport_center, name: "Double 5")
  @current_user.save
  visit sport_center_path(@current_user.sport_center)
end

When(/^I go to location page$/) do
  visit sport_center_locations_path(@current_user.sport_center)
end

Then(/^I should see new location button$/) do
  page.should have_button(I18n.t("locations.index.btn_new"))
end

Given(/^I am authorized for create a location$/) do
  step 'I am in my sport center page'
end

When(/^I press new location button$/) do
  click_button(I18n.t("locations.index.btn_new"))
end

Then(/^I should see Successfully created location$/) do
  page.should have_content(I18n.t('flash.location',
                                  message: (I18n.t 'flash.created')))
end
