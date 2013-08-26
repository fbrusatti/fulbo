Given(/^there exists a Field$/) do
  @owner_sc = FactoryGirl.create(:user)
  @sport_center = FactoryGirl.create(:sport_center, name: 'Maradona',
                                                    owner: @owner_sc)
  @location = FactoryGirl.create(:location)
  @field = FactoryGirl.create(:field)
  @location.fields << @field
  @sport_center.locations << @location
end

Given(/^I am Logged in$/) do
  @current_user = FactoryGirl.create(:user)
  login_as(@current_user, :scope => :user)
end

Given(/^I am not Logged in$/) do
  page.driver.submit :delete, '/users/sign_out', {}
end

Then(/^I should see Rent button$/) do
  page.should have_button(I18n.t("fields.show.btn_rent"))
end

Then(/^Then I should see Sign In button$/) do
  page.should have_button(I18n.t("fields.show.btn_login"))
end

Then(/^I should see Succesfully rent field$/) do
  page.should have_content(I18n.t("flash.rent", message: t("flash.rented")))
end

When(/^I go to field page$/) do
  visit location_field_path(@location, @field)
end

When(/^I fill all value in form field$/) do
  date = DateTime.new
  fill_in :reservation_date, with: date
end

When(/^I press rent button$/) do
  click_on(I18n.t("fields.show.btn_rent"))
end