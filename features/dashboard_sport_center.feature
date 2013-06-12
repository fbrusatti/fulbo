Feature: View link dashboard sport center

	Scenario: View link
    Given I am logged in
    When I am owner to sport center
    Then I should view link dashboard sport center

  Scenario: Not view link
    Given I am logged in
    When I am not owner to sport center
    Then I should not view link dashboard sport center
