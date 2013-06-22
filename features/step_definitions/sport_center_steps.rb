When(/^I press button to create a new League$/) do
  click_on(I18n.t("sport_centers.show.tournaments"))
  click_on(I18n.t("sport_centers.show.new_tournament"))
end

When(/^I submit the form$/) do
  click_button(I18n.t("leagues.new.btn_submit"))
end

Then(/^I should see a message advising me of the correctness$/) do
  page.should have_content I18n.t('flash.error_create_form')
end

When(/^I fill in form league$/) do
  step 'I fill in "league_name" with "apertura"'
  check('league_category_5')
  select '2014', :from => 'league_start_date_1i'
  select 'mayo', :from => 'league_start_date_2i'
  select '1', :from => 'league_start_date_3i'
end

Then(/^I should see successfully created league message$/) do
  page.should have_content I18n.t('flash.league', message: I18n.t('flash.created'), name: "apertura")
end
