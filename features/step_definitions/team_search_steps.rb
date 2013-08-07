Given(/^there exists a team named "(.*?)"$/) do |name|
  step 'I am logged in'
  @current_user.team = FactoryGirl.create(:team, name: name)
  @current_user.save
end

Then(/^I should see a text Team not found$/) do
  page.should have_content I18n.t('teams.not_found_result')
end
