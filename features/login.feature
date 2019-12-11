Feature: Login to application
  As a student, to upload the degree plan
  I want to be able to login to the application
  to see the student details page. If a user does not enter a password for the first time,
  he should see the prompt asking him to change password
  
  Scenario:
  Given the website is set up
  Given I am on the login page
  When I fill in "test" for "username"
  And I fill in "" for "password"
  And I press "Login"
  Then I should see "Please create a password before logging in by clicking on Change Password?"
 