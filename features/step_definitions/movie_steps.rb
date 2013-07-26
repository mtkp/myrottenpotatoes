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
  return_str = tmdb_mock_results(value)
  request_url = "http://api.themoviedb.org/3/search/movie?api_key="
  request_url << ENV["TMDB_API_KEY"]
  request_url << "&language=en&query="
  request_url << value.gsub(/\s/, '%20')

  stub_request(:get, request_url).
    to_return(body: return_str)
  fill_in(field, :with => value)
end