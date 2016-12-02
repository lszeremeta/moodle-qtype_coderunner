@qtype @qtype_coderunner @javascript @sqrfunctests
Feature: Preview the Python 3 sqr function CodeRunner question
  To check the CodeRunner questions I created work
  As a teacher
  I must be able to preview them

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email            |
      | teacher1 | Teacher   | 1        | teacher1@asd.com |
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0        |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | C1     | editingteacher |
    And the following "question categories" exist:
      | contextlevel | reference | name           |
      | Course       | C1        | Test questions |
    And the following "questions" exist:
      | questioncategory | qtype      | name            | template |
      | Test questions   | coderunner | Square function | sqr      |
    And I log in as "teacher1"
    And I follow "Course 1"
    And I follow "Question bank"

  Scenario: Preview the Python3 sqr function question and get it right
    When I click on "Preview" "link" in the "Square function" "table_row"
    And I switch to "questionpreview" window
    And I set the field "How questions behave" to "Adaptive mode"
    And I press "Start again with these options"
    And I set the field with xpath "//textarea[contains(@name, 'answer')]" to "def sqr(n): return n * n"
    And I press "Check"
    Then the following should exist in the "coderunner-test-results" table:
      | Test           |
      | print(sqr(11)) |
      | print(sqr(-7)) |
    And "print(sqr(11))" row "Expected" column of "coderunner-test-results" table should contain "121"
    And "print(sqr(11))" row "Got" column of "coderunner-test-results" table should contain "121"
    And I should see "Passed all tests!"
    And I should not see "Show differences"
    And I should see "Marks for this submission: 31.00/31.00"

  Scenario: Preview the Python3 sqr function question and submit syntactically invalid answer
    When I click on "Preview" "link" in the "Square function" "table_row"
    And I switch to "questionpreview" window
    And I set the field "How questions behave" to "Adaptive mode"
    And I press "Start again with these options"
    And I set the field with xpath "//textarea[contains(@name, 'answer')]" to "def sqr(n); return n * n"
    And I press "Check"
    Then I should see "Testing was aborted due to error."
    And I should see "Marks for this submission: 0.00/31.00"

  Scenario: Preview the Python3 sqr function question and get it wrong
    When I click on "Preview" "link" in the "Square function" "table_row"
    And I switch to "questionpreview" window
    And I set the field "How questions behave" to "Adaptive mode"
    And I press "Start again with these options"
    And I set the field with xpath "//textarea[contains(@name, 'answer')]" to "def sqr(n): return n * n * n"
    And I press "Check"
    Then the following should exist in the "coderunner-test-results" table:
      | Test           |
      | print(sqr(11)) |
      | print(sqr(-7)) |

    And "print(sqr(11))" row "Expected" column of "coderunner-test-results" table should contain "121"
    And "print(sqr(11))" row "Got" column of "coderunner-test-results" table should contain "1331"
    And I should see "Some hidden test cases failed, too."
    And I should see "Marks for this submission: 3.00/31.00"
