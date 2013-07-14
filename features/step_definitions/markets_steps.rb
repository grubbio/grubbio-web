Then(/^I should see a search allowing me to find markets by name, produce type and zip code$/) do
  page.should have_css("form[action='/markets'] input#market_search_query")
end

Given(/^I click the first market in the results$/) do
  all("tr.market-result > td > a").first.click
end

Then(/^I should see the Market Details page$/) do
  page.should have_css("#market-information")
end