Feature: Add an item for existing student
  
  As an admin
  So that I can add student details for new review year
  I want to add an item
  
#Background: students in databse
Scenario: Adding item
  Given I am on Searched Items page
  When I follow "add_item"
  Then I should be on Add Line Item page