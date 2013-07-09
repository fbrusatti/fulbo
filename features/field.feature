Feature: Field feature

  Scenario: Authorized for create a field
    Given I am in my sport center page
    And I have location
    When I go to a location
    Then I should see new field button

  Scenario: Success create field
    Given I am authorized for create a field
    When I press new field button
    And I fill all values in form field
    And I press save field
    Then I should see Successfully created field