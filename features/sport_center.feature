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

Scenario: Friendly urls
  Given There exists a SportCenter named "Doble 5 Retirate"
  When I visit the address "/sport_centers/doble-5-retirate"
  Then I should see the sport center profile page

Scenario: See all Sport Centers
  Given I am logged in
  And there exists a few Sport Centers
  When I go to page of all Sport Centers
  Then I should see all the Sport Centers listed

Scenario: See calendar reservation of my SportCenter
  Given I am logged in
  And I am owner of Sport Center "Doble 5"
  When I go to page of my sport center
  Then I should see calendar reservation link

Scenario: See calendar reservation of my SportCenter
  Given I am logged in
  And I am not owner of Sport Center "Doble 5"
  When I go to page of my sport center
  Then I should not see calendar reservation link


# Scenario: See all Sport Centers when there are not SportCenter
#   Given I am logged in
#   And there are not SportCenters
#   When I go to page of all Sport Centers
#   Then I should see an empty list of Sport Centers
