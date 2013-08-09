Feature: User profile search
  
  Background:
    Given there exists a user named "Diego"

  @javascript
  Scenario: Found User
    Given I am a guest user
    When I enter "Diego" in the search box
    Then I should see a link to "Diego" "profile" as result

  @javascript
  Scenario: Not Found User
    Given I am a guest user
    When I enter "armando" in the search box
    Then I should see a text Player not found
