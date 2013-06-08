@javascript
Feature:  Markets
  As a consumer of only the finest local produce
  I want to be able to find a farmer's market nearby carrying the food I desire
  So that my belly gets full

  Background:
    Given I log in as a consumer
    And I go to the markets index page

  Scenario: Search basics
    Then I should see a search allowing me to find markets by name, produce type and zip code 
