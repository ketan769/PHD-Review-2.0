Feature: Enter Student details
  As a system administrator
  In order to keep student details updated
  I want to be able to enter Prelim Date
 
  Background:
    Given the app is set up
    And I am logged into the admin panel

  Scenario: Successfully enter student details
    Given I am on the Student Details page
    When I fill in "Prelim Exam" with "12-31-2019"
    And I press "Submit"
    Then I should be on the Searched Items page
    When I view the student details
    Then I should see "12-31-2019" for Qualifier Date