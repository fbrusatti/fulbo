Given /^I am signed in$/ do
  ui.sign_in
end

Given(/^I am not authenticated$/) do
  page.driver.submit :delete, '/users/sign_out', {}
end

When(/^I go to register$/) do
  visit new_user_registration_path
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  # debugger
  fill_in field, with: value
end

When(/^I press "(.*?)"$/) do |button|
  click_button button
end

Then(/^I should see "(.*?)"$/) do |text|
  page.should have_content text
end
