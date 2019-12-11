Feature: Login to application
  As a student, to upload the degree plan
  I want to be able to login to the application
  to see the student details page. If a user does not enter a password for the first time,
  he should see the prompt asking him to change password
  
  Scenario:
  Given the website is set up
  Given I am on login page
  When I fill in "username" with "test"
  And I fill in "password" with ""
  And I press "Login"
  Then I should see "Please create a password before logging in by clicking on Change Password?"