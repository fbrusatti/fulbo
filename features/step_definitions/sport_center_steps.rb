Given(/^I am in my sport center page$/) do
  steps %{ Given I am logged in }
  @user.sport_center = FactoryGirl.create(:sport_center)
  visit user_sport_center_path(@user)
end

When(/^I press button to create a new League$/) do
  click_on(I18n.t("sport_centers.show.tournaments"))
  click_on(I18n.t("sport_centers.show.new_tournament"))
end

When(/^I submit the form$/) do
  click_button(I18n.t("sport_centers.show.btn_submit"))
end

Then(/^I should see a message advising me of the correctness$/) do
  page.should have_content I18n.t('flash.error_create_form')
end

When(/^I fill in form league$/) do
    steps %{
      I fill in "name" with "apertura"
      I fill in "category" with "5"
      I fill in "start_date" with "12/12/2012"
    }
end

Then(/^I should see successfully created league message$/) do
  page.should have_content I18n.t('flash.league', 'flash.created', name: "apertura")
end
