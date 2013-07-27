Given /I have added "(.*)" with rating "(.*)"/ do |title, rating|
  steps %Q{
    Given I am on the Create New Movie page
    When I fill in "Title" with "#{title}"
    And I select "#{rating}" from "Rating"
    And I press "Save Changes"
  }
end

Then /I should see "(.*)" before "(.*)" on (.*)/ do |string1, string2, path|
  step "I am on #{path}"
  regexp = /#{string1}.*#{string2}/m
  assert_match regexp, page.body
end


When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  stub_request(:get, tmdb_request_url(value)).
    to_return(body: tmdb_mock_results(value))
  fill_in(field, :with => value)
end