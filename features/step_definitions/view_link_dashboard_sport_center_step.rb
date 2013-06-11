include Warden::Test::Helpers

Given(/^I am logged in$/) do
	visit new_user_session_path
	@user = FactoryGirl.create(:user)
	fill_in 'user_email', with: @user.email
	fill_in 'user_password', with: "password"
	click_button 'Sign in'
end

When(/^I am( not)? owner to sport center$/) do |negation|
  @user.sport_center = negation.present? ? nil : FactoryGirl.create(:sport_center)
end

Then(/^I should( not)? view link dashboard sport center$/) do |negation|
	visit root_path
	expectation = negation.present? ? :should_not : :should
  page.send(expectation, have_content(I18n.t('navigation.sport_center')))
end

