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

  #FIXME: need to improve DB seeding so it's consistent- currently random 
  Scenario: Searching for a market by food product
    And I fill in "market_search_query" with "Apple"
    And I press "Find it"
    Then I should see 10 element kind of "tr.market-result"

  Scenario: Searching for a market by food product (stemming)
    And I fill in "market_search_query" with "Appling"
    And I press "Find it"
    Then I should see 10 element kind of "tr.market-result"

  Scenario: Viewing a market
    And I fill in "market_search_query" with "apple"
    And I press "Find it"
    And I click the first market in the results
    Then I should see the Market Details page