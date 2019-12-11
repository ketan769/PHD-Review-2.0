Feature: search students with uin 
  As an admin/faculty 
  so that I can review and add decision 
  I want to be able to search the uin
  
Background: students in database
      
    Given: The following student exists in users:
     |uin|advisor|
     |328|""|
     |329|""|
    
    
    Scenario: search user with uin
     Given the website is set up
     Given I am on the search page
     When I fill in "329" for "uin" 
     And I press "Search Reviews"
     Then I should see "329"

