@javascript
Feature:  Markets
  As a consumer of only the finest local produce
  I want to be able to find a farmer's market nearby carrying the food I desire
  So that my belly gets full

  Background:
    #Given I log in as a consumer
    Given I go to the markets index page

  Scenario: Search basics
    Then I should see a search allowing me to find markets by name, produce type and zip code 

  Scenario: Default market listing
    Then I should see 25 elements kind of "tr.market-result"

  Scenario: Searching for a market by market name and zip code
    And I fill in "market_search_query" with "Aurora"
    And I fill in "market_search_location" with "80231"
    And I press "Find it"
    Then I should see 1 element kind of "tr.market-result"

  Scenario: Searching for a market by food product and zip code
    And I fill in "market_search_query" with "Apple"
    And I fill in "market_search_location" with "80231"
    And I press "Find it"
    Then I should see 1 element kind of "tr.market-result"

  Scenario: Searching for a market by food product (stemming) and zip code
    And I fill in "market_search_query" with "Appling"
    And I fill in "market_search_location" with "80231"
    And I press "Find it"
    Then I should see 1 element kind of "tr.market-result"