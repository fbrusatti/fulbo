Feature: Leagues

  Background:
    Given exists at least one League

  Scenario: Listing all leagues
    When I go to page of all Leagues
    Then I should see all leagues listed

  Scenario: Listing leagues of a sport center logged
    Given I am logged in
    When I go to to sport center "Maradona" page
    And I click to see its leagues
    Then I should see only the leagues of "Maradona" sport center

  Scenario: Listing leagues of a sport center w/o be loged in
    Given PENDING
