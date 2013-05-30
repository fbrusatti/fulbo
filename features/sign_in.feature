Feature: Sign in

  Scenario: Success Log in
    Given I am not logged in
    When I go to login page
    And I enter my correct credentials
    Then I should be logged in

  Scenario: Fail Log in
    Given I am not logged in
    When I go to login page
    And I enter wrong credentials
    Then I should not be logged in
