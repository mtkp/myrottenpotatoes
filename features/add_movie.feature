Feature: User can manually add movie

Scenario: Add a movie
  Given I am signed in
  And I am on the RottenPotatoes home page
  When I follow "Add new movie"
  Then I should be on the Create New Movie page
  When I fill in "Title" with "Men In Black"
  And I select "PG-13" from "Rating"
  And I press "Save Changes"
  Then I should be on the RottenPotatoes home page
  And I should see "Men In Black"

Scenario: Add a movie but not logged in
  Given I am on the RottenPotatoes home page
  When I follow "Add new movie"
  Then I should be on the Log In page
  And I should see "Log in with Twitter"
  And I should see "Log in with Facebook"
  When I follow "Log in with Twitter"
  Then I should be on the RottenPotatoes home page
  When I follow "Add new movie"
  Then I should be on the Create New Movie page
