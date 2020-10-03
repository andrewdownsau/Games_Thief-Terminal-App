# Thief Game Test Cases

## Instructions

This terminal application has a large amount of complex functionality that interacts with the user mainly through tty-prompt menu options. Because this project was not implemented with TDD, the tests should be conducted manually without automatic coding tests. Such tests may be written at a future date.

The test case table below should be updated as testing of the features are implemented by testers. Below the table are detailed methods for testing each case.

## Test Case Table
<table>
  <tr>
    <th>Test Case</th>
    <th>Outcome</th>
    <th>Date</th>
    <th>Tester</th>
    <th>Comments</th>
  </tr>
  <tr>
    <td>1. Game setup</td>
    <td>Success</td>
    <td>3/10/20</td>
    <td>Andrew</td>
    <td>Doesn't check for character length, otherwise good</td>
  </tr>
  <tr>
    <td>2. Roll checking</td>
    <td>Success</td>
    <td>3/10/20</td>
    <td>Andrew</td>
    <td>Checks are limited but perform as expected</td>
  </tr>
  <tr>
    <td>3. Roll outcome 1-4</td>
    <td>Success</td>
    <td>3/10/20</td>
    <td>Andrew</td>
    <td>Performs as expected</td>
  </tr>
  <tr>
    <td>4. Stealing turn</td>
    <td>Success</td>
    <td>3/10/20</td>
    <td>Andrew</td>
    <td>Performs as expected, could be smoother with options</td>
  </tr>
</table>

<br>

### 1. Game setup
Check that the following operations and conditions are working as expected:
- Open Terminal application
- Select new game option
- New game option results in game setup page
- Set-up page prompts user to input number of players
- Only a number between 3-6 can be entered, else the user must input again
- Once valid number submitted player names are entered (must be valid string)
- Names are automatically capitalized when entered and appear in player list
- Once all names have been entered there is a menu is given to start game, reset settings or quit

### 2. Roll Checking
Check that the following operations and conditions are working as expected:
- Uncomment out round.rb code line 93 to test straight roll checker
- Comment out app_router line 54 and uncomment line 55 to skip game setup
- Run application and start new game
- Game active page should load with "Tom", "Harry" and "Richard" preloaded
- Select roll dice option
- Output expected for straight is the pot adds 2500 to active player
- Repeat process for other test cases by uncomment round.rb lines 94 then 95 to check the set checker
- Set checker outputs 4000 to pot for the complete [1, 1, 1, 1, 1] set
- Set checker outputs 1000 to pot for the partial [1, 1, 1, 2, 2] set once set is held

### 3. Roll outcome 1-4
Check that the following operations and conditions are working as expected:
- Outcome 1: bust, use roll checking test instructions by uncomment round.rb line 96
- Bust outcome should result in end round option to pass turn to next player
- Outcome 2: chain, use roll checking instructions for test case straight set
- Chain should result in adding score to pot total without holding values and provide option to chain roll
- Outcome 3: some valid, comment out all test case lines in round and roll dice as normal
- Some valid (either 1, 5 or set) results in valid values listed as options to hold dice
- Outcome 4: win, use roll checking instruction for test case straight set and chain 3 times
- Win condition results in congrats message and option to start a new game with same players

### 4. Stealing Turn
Check that the following operations and conditions are working as expected:
- Make sure all round.rb test case lines are commented out
- Run application, start new game and roll dice
- Hold 1 valid value and confirm (end round and repeat roll if bust)
- Select pass to next player option after confirming hold
- Stealing option should be directed to next player
- Steal turn and roll results in new roll being thrown with new active player (pot moves to them)



