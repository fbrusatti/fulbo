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

Then(/^I should( not)? see create a team button$/) do |negation|
  if negation.present?
    page.should_not have_button(I18n.t('teams.index.btn_create'))
  else
    page.should have_button(I18n.t('teams.index.btn_create'))
  end
end

Given(/^I am authorized for create a team$/) do
  steps %{
    Given I am logged in
    And I am not owner of a team }
end

When(/^I press create a team button$/) do
  click_button(I18n.t('teams.index.btn_create'))
end

When(/^I press Save$/) do 
  click_button(I18n.t('teams.new.button'))
end

Then(/^I should see Successfully "(.*?)" team$/) do |message|
  page.should have_content(I18n.t('flash.team', message: (I18n.t 'flash.created')))
end

Then(/^I should see "(.*?)"$/) do |team|
  page.should have_content team
end
  
Given(/^I am included in the team$/) do
  @user.team.players << @user
end

When(/^I go to show my team$/) do
  visit team_path(@user.team)
end

Then (/^I should see me in the players$/) do
  page.should have_content @user.name
end 

Then(/^I should( not)? see edit link$/) do |negation|
  if negation.present?
    page.should_not have_content I18n.t('teams.show.link_edit')
  else
    page.should have_content I18n.t('teams.show.link_edit')
  end  
end

When(/^I go to show any team$/) do
  @team = FactoryGirl.create(:team)  
  visit team_path(@team)
end

