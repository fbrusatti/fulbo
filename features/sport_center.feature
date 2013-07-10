Feature: Sport Center

Scenario: Lack of name in League
  Given I am in my sport center page
  When I press button to create a new League
  And I submit the form
  Then I should see a message advising me of the correctness

Scenario: Create a League successfully
  Given I am in my sport center page
  When I press button to create a new League
  And I fill in all values in form league
  And I submit the form
  Then I should see successfully created league message

Scenario: Nice Urls are used
  Given There exists a SportCenter named "Doble 5 Retirate"
  When I visit the address "/sport_centers/doble-5-retirate"
  Then I should see the sport center profile page
