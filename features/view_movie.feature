Feature: User can view details about a movie

Scenario: User clicks on the movie to view more details about it
  Given I am on the RottenPotatoes home page
  And I have added "Zorro" with rating "PG-13"
  When I follow "Zorro"
  Then I should be on the Zorro details page
  And I should see "Rating PG-13"
  And I should see "Description"