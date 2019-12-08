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
     When: I got to new page 
     And I fill uin 329 
     And I press "submit"
     Then I should see the student 329
     
     