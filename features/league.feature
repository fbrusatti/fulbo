Feature: League

  Background:
    Given I am logged in
    And exists at least one League

  Scenario: Authorized to register a team in a league
    Given I am owner of a team
    When I go to page of all Leagues
    And I choose one League
    Then I should see inscription button to the League

  Scenario: Not authorized to register a team in a league
    Given I am not owner of a team
    When I go to page of all Leagues
    And I choose one League
    Then I should not see inscription button to the League
