Feature: Team Album

  Scenario: See all team albums
    Given PENDING
    Given I am a team owner 
    When I go to my team profile 
    And I click in album link
    Then I should be able to see my albums

