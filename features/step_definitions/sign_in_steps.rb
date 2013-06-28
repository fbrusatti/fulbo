Given /^I am signed in$/ do
  ui.sign_in
end

Given(/^I am not authenticated$/) do
end

Given(/^I am not logged in$/) do
  page.driver.submit :delete, '/users/sign_out', {}
end

When(/^I go to register$/) do
  visit new_user_registration_path
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in field, with: value
end

When(/^I press "(.*?)"$/) do |button|
  click_button button
end

Then(/^I should see signed in message for "(.*?)"$/) do |user|
  page.should have_content I18n.t('flash.welcome')
end

When(/^I go to login page$/) do
  visit new_user_session_path
end

And(/^I enter (my correct|wrong) credentials$/) do |correctness|
  password = correctness == 'wrong' ? 'bad_password' : 'password'
  @user = FactoryGirl.create(:user)

  fill_in 'user_email', with: @user.email
  fill_in 'user_password', with: password
  click_button 'Ingresar'
end

Then(/^I should( not)? be logged in$/) do |negation|
  expectation = negation.present? ? :should_not : :should

  page.send(expectation, have_content(@user.email))
end
