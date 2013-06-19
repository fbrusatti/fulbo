Feature: Sport Center

Scenario: Lack of name in League
  Given I am in my sport center page
  When I press button to create a new League
  And I submit the form
  Then I should see a message advising me of the correctness

Scenario: Create a League successfully
  Given I am in my sport center page
  When I press button to create a new League
  And I fill in form league
  And I submit the form
  Then I should see successfully created league message
