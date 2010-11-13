Feature: Managing listing
  In order to sell things
  a seller
  can manage listings

  Scenario: Viewing a listing
    Given a listing exists with a title of "Old Car"
    When I go to the homepage
    And I follow "Old Car"
    Then I should see "Old Car"
    And I should see "Place a bid"