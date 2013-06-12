When(/^I am( not)? owner to sport center$/) do |negation|
  @user.sport_center = negation.present? ? nil : FactoryGirl.create(:sport_center)
end

Then(/^I should( not)? view link dashboard sport center$/) do |negation|
	visit root_path
	expectation = negation.present? ? :should_not : :should
  page.send(expectation, have_content(I18n.t('navigation.sport_center')))
end

