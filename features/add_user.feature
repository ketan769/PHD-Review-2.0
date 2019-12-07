Feature: Add a new student
  
  As an admin
  So that I can add new PHD student details
  I want to add a new student
  
#Background: students in databse
Scenario: Add new student
  Given I am on the Searches page
  When I click on "Add User"
  Then I should be on Create Users page