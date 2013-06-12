Feature: Team feature

  Scenario: Authorized for create a team
    Given I am logged in
    And I am not owner of a team
    When I go to teams page
    Then I should see create a team button

  Scenario: Not Authorized to create a team
    Given I am logged in
    And I am owner of a team
    When I go to teams page
    Then I should not see create a team button

  Scenario: Success create team
    Given I am authorized for create a team
    When I go to teams page
    And I press create a team button
    And I fill in "team_name" with "Barcelona"
    And I press Save
    Then I should see Successfully "created" team
    And I should see "Barcelona"
