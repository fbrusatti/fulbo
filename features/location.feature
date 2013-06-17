Feature: Location feature

  Scenario: Authorized for create a location
    Given I am in my sport center page
    When I go to location page
    Then I should see new location button

  Scenario: Success create location
    Given I am authorized for create a location
    When I go to location page
    And I press new location button
    And I fill in "location_name" with "Centro 11"
    And I fill in "location_address" with "Parana 1452"
    And I press Save
    Then I should see Successfully "created" location
    And I should see "Centro 11"
    