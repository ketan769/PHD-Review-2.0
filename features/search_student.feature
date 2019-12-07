Feature: Search for a student
  
  As an admin
  So that I can view student details
  I want to search for a student
  
#Background: students in databse
Scenario: Search using UIN
  Given I am on the Searches page
  When I fill in "uin" with "327005544"
  When I click on "Submit"
  Then I should be on Searched Items page