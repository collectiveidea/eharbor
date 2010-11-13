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

  Scenario: Adding a listing
    Given I am signed in
    When I go to the homepage
    And I follow "Sell"
    And I fill in "Title" with "BFG 9000"
    And I fill in "Description" with "Big Fabulous Gun"
    And I select "7 days" from "Duration"
    And I press "Create Listing"
    Then I should see "BFG 9000"