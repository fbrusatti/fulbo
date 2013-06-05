include Warden::Test::Helpers

Given(/^I am logged in$/) do
	visit new_user_session_path
	@user = FactoryGirl.create(:user)
	fill_in 'user_email', with: @user.email
  fill_in 'user_password', with: "password"
	click_button 'Sign in'
end

When(/^I am owner to sport center$/) do
  @user.sport_center = FactoryGirl.create(:sport_center)
end

Then(/^I should view link dashboard sport center$/) do
	visit root_path
	page.should have_content "Complejo"
end
