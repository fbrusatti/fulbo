Feature: League

  Background:
    Given exists at least one League

  Scenario: Authorized to register a team in a league
    Given I am logged in like owner of a team
    When I go to page of all Leagues
    And I choose one League
    Then I should see inscription button to the League

  Scenario: Not authorized to register a team in a league
    Given I am logged in like not owner of a team
    When I go to page of all Leagues
    And I choose one League
    Then I should not see inscription button to the League

  Scenario: Authorized to modify a league
    Given I am logged in like owner of a league
    When I visit the league page
    Then I should see the buttons to edit and delete my league

  @javascript
  Scenario: Send inscription request
    Given I am logged in like owner of a team
    And I visit the league page
    When I press inscription button
    Then I should see that it was send

  @javascript
  Scenario: Accepted  inscription request
    Given I am logged in like owner of a league
    And I have an inscription request to my league
    When I go to edit page of my league
    And I press accept button of the inscription
    Then I should see the team in list of teams that will play

  @wip
  Scenario:  Success generate League Fixture
    Given I am logged in like owner of a league
    And I have a few teams registered in my League
    When I go to the League page
    And I click on button Generate League Fixture of League
    Then I should see The fixture generated
