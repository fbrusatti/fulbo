Given(/^there exists a user named "(.*?)"$/) do |name|
  @profile = FactoryGirl.create(:user, name: name)
  @profile.save
end

Given(/^I am a guest user$/) do
  logout
end

When(/^I enter "(.*?)" in the search box$/) do |name|
  visit profiles_path
  fill_in "btn_search", with: name
  click_button(I18n.t('user_profile.search_buttons.btn_search'))
end

Then(/^I should see a link to "(.*?)" "(.*?)" as result$/) do |name, _ |
  page.should have_content name
end

Then(/^I should see a text Player not found$/) do
  page.should have_content I18n.t('user_profile.not_found_result')
end
