Feature: Reservation feauture

  Background:
    Given there exists a Field

  Scenario: I am Authorized for Rent Field
    Given I am Logged in
    When I go to field page
    Then I should see Rent button

  Scenario: Not Authorized for Rent a Field
    Given I am not Logged in
    When I go to field page
    Then I should see Sign In button

  Scenario: Succes Rent Field
    Given I am Logged in
    When I go to field page
    And I fill all value in form field
    And I press rent button
    Then I should see Succesfully rent field