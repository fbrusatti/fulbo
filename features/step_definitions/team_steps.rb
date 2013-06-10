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

Then(/^I should( not)? see "(.*?)" button$/) do |negation, button_name|
  if negation.present?
    page.should_not have_button button_name
  else
    page.should have_button button_name
  end
end

Given(/^I am authorized for create a team$/) do
  steps %{
    Given I am logged in
    And I am not owner of a team }
end

When(/^I press "(.*?)" button$/) do |button_name|
  click_button button_name
end

When(/^I fill in "name" with "Barcelona"$/) do
  fill_in "team_name", with: "Barcelona"
end