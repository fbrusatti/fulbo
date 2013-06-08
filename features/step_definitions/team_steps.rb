Given(/^I am logged in$/) do
  @user = FactoryGirl.create(:user)
  login_as(@user, :scope => :user)
end

Given(/^I am( not)? owner of a team$/) do |negation|
  if negation.present?
    @user.team.destroy unless @user.team.blank?
  else
    @user.create_team(name:"Myteam")
  end
end

When(/^I go to teams page$/) do
  visit teams_path
end

Then(/^I should( not)? see "(.*?)" button$/) do |negation, name_button|
  if negation.present?
    page.should_not have_button name_button
  else
    page.should have_button name_button
  end
end

Given(/^I am authorized for create a team$/) do
  steps %{
    Given I am logged in
    And I am not owner of a team }
end

When(/^I press "(.*?)" button$/) do |name_button|
  click_button name_button
end

When(/^I fill in "name" with "Barcelona"$/) do
  fill_in "team_name", with: "Barcelona"
end