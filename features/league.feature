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

 @javascript
  Scenario: Authorized to generate Fixture
    Given I am logged in like owner of a league
    And I have more than one team registered in my League
    When I go to teams tag on the League page
    And I click on button Generate Fixture of League
    Then I should see the generate fixture page

  @javascript
  Scenario: Not Authorized to generate Fixture
    Given I am logged in like owner of a league
    And I have less than two teams registered in my League
    When I go to teams tag on the League page
    Then I should see the Fixture generate button disable

  @javascript
  Scenario: Fixture generated
    Given I am logged in like owner of a league
    And I have a fixture generated
    When I go to teams tag on the League page
    Then I should see disable the buttons to affiliate or unaffiliate
    And I should see the delete fixture button
