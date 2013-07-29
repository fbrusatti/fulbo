Feature: Fixture

Background:
  Given exists at least one League
  And I am logged in like owner of a league
  And I have more than one team registered in my League
  And I have two field in my Sport Center

@javascript
Scenario: Success create a Fixture
  When I go to Fixture create page
  And I select the Sunday day and press next
  And I choose time start 15:00 PM  and time to finish 16:00 PM for Sunday
  And I choose the first field for Sunday
  And I press the Fixture create button
  Then I should see Successfully created Fixture
