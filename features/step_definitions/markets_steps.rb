Then(/^I should see a search allowing me to find markets by name, produce type and zip code$/) do
  page.should have_css("form[action='/markets'] input#market_search_query")
end