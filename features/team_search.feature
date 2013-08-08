Feature: Team search
  
  Background:
    Given there exists a team named "Boca Juniors"

  @javascript
  Scenario: Found User
    Given I am a guest user
    When I enter "Boca" in the search box
    Then I should see a link to "Boca" "team" as result

  @javascript
  Scenario: Not Found User
    Given I am a guest user
    When I enter "River Plate" in the search box
    Then I should see a text Team not found
