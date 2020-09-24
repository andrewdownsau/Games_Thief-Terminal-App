# Thief game terminal app

### GitHub Code Repository : https://github.com/andrewdownsau/thief_game_terminal_app

<br>

## Installation and setup

<br>

## Software Development Plan

Welcome to Thief! A fun dice/card game (created by my sister Cassandra Downs) that incorporates risk/reward chaining and using your hand of tools to throw off your opponents and claim your victory!

In these times of social isolation it's become more important than ever for people to remain connected through events, interaction and fun activities. This terminal application is meant to provide the programmatic scaffolding of the business logic required for a web-based application to allow players to engage with this game remotely. I'm personally developing this application because I really enjoy playing this game with my friends and I think other people will be able to enjoy it too.

The target audience of this application will be a group of players (between 3-6 people) of this game. They will most likely be non-technical laypeople who want to enjoy the game with their friends.

The game works with a set of 5 dice. Valid values and sets from rolls include only the following:

<table>
  <tr>
    <th>Die/Dice Value (not 1)</th>
    <th>Points</th>
    <th>Die/Dice Value (1)</th>
    <th>Points</th>
  </tr>
  <tr>
    <td>[5]</td>
    <td>50</td>
    <td>[1]</td>
    <td>100</td>
  </tr>
  <tr>
    <td>[x, x, x] x > 1</td>
    <td>x * 100</td>
    <td>[1, 1, 1]</td>
    <td>1000</td>
  </tr>
  <tr>
    <td>[x, x, x, x] x > 1</td>
    <td>x * 200</td>
    <td>[1, 1, 1, 1]</td>
    <td>2000</td>
  </tr>
  <tr>
    <td>[x, x, x, x, x] x > 1</td>
    <td>x * 300</td>
    <td>[1, 1, 1, 1, 1]</td>
    <td>3000</td>
  </tr>
  <tr>
    <th>Dice Value (straight)</th>
    <th>Points</th>
  </tr>
  <tr>
    <td>[1, 2, 3, 4, 5]</td>
    <td>2500</td>
  </tr>
</table>

<br>


At the beginning of a new turn a player rolls 5 dice, the following outcomes can result.
- Outcome 1: Valid values or sets are present with other values not present: player has the choice of passing or holding at least one of their dice values/sets and rolling the remaining dice to increase their score.
- Outcome 2: No values or sets are present with dice that are rolled: player's turn is forfeit and no points added to overall score, next players turn
- Outcome 3: All 5 dice results are valid values or sets: the player rolling chains their current points and rolls the full set again

After a player has passed their turn:
- The next player has the option to steal the last player's score or play their own turn.
  - If they steal they continue the turn as though it were theirs with the dice values and accumulated points present
  - If they don't steal the player who was just rolling adds the accumulated points to their score, then it's the next players turn

- Game round ends when first player reaches 10,000 points (players cannot steal if total goes over limit for rolling player)

An expansion feature of the game is to include a deck of cards that adds more complexity to the game in that players can on their or other's turn play game cards that provide buffs and de-buffs to the current rolling player.

The scope of this project will allow for the group of players to run the game application on a single terminal window or (if there is enough time to implement) through a series of networked terminals run through a host server. If there is enough time to implement further I would like to create a series of rudimentary AIs to play against so a single user can play through the game.

<br>

## Minimum Viable Product Features

Listed are a number of features that are defined as actions that the user should be able to perform when interacting with the program:

- Access and run the application and utilize a tty-prompt style menu with the overall features of of the application. In this way the user inputs are limited to only selecting options available with the arrow keys on their keyboard. The terminal window should always only include the valid options and outputs to display for the current selection or in-game stage (using system clears to clean the terminal). The menu will include all of the subsequent features listed below as well as an option to exit the program.

- Learn the basic rules of the game; the user should be able to select a menu option that brings them to a step-by-step tutorial. This tutorial system will run a preprogrammed game run-through with instructions and advice for decisions made in the game to better inform their decisions while playing.

- Create a new game. This will need to prompt and accept user settings such as the number of players and a display name for each player (assuming that all players are on the same terminal window/device). Again, to avoid errors, the user will use arrow keys to select number of players from the available options. The display name of players can include any string character set from the user text input as long as it is more than 2 characters.

- Play through their individual turns. There must be a prompt that asks if the user is ready to take their turn and then once they select they are the turn starts with the option of rolling their dice (this extra step is implemented to make expanding with the game cards easier, to start rolling will be the only option). 

- Be presented with game options for a player's turn. Once they select to roll and the results are outputted (prefer as a graphic but will start with plain text) the three outcomes listed in the development plan determine what options the user will be presented with. If there is at least one valid value or set, then the active player has the choice of continuing to roll, or ending their turn. If there are no valid values or sets with the dice that were rolled, the player ends their turn and no one receives any points. If all dice show valid values/sets then the total is added to the pot and the active roller must select to roll all 5 dice again. Whenever there is an active pot its value must be seen present and show how it will be added to the current player's score (eg "Sarah: 2400 + [700]").

- Next player in sequence must be presented the option to steal a player's pot and take over their turn if, in the first outcome, the active player chooses to end their turn. Should they choose to steal they get to continue the turn as if it was theirs and the pot moves to them to win; if not then all of the valid dice values/sets get added to the roller's total score. 

- Current player who chooses to continue/steal the turn is presented with the option to hold as many valid values or sets to add to their accumulated total for that turn (but they must select at least one). By default all valid values and sets are selected and show how the accumulated pot will add to their score. Once they are happy with their held dice they have the option to then roll the remaining dice (which shows how many are unselected as the user selects) to continue the process. 


<br>

## Expanded features (may not be included in the scope of current assignment):

- Option presented to all players to start a subsequent round, have certain players opt-out/in, save or complete the game once a player has reached passed 10,000 points. Presentation will hold results for each round and highlight the winning player. If new round selected, start game as normal with players remaining. If completed a short title page shows the current podium of winning players and then returns to the main menu. A sidebar/header menu should also provide the options to save or quit the game or for one of the players to opt-out/in at any time (if a player opts-out of the game all their scores and data for the game are deleted and can only be recovered if starting from a save file).

- Be able to save and load games using a local file containing game data. Save game data will include game state, game round, previous rounds scores, players list, current scores, current player, current pot accumulated, current dice values set and current active choices of player (holding, not yet chosen dice etc). These functions are designed so that the game can be saved and loaded from any point.

- Option to opt-in at any point rudimentary AI players that have random funny names (eg V1Ki, ST3V3) that have very predictable choices in a narrow scope (eg: always chooses to steal if 3 or more dice still to roll, never ends turn unless have 2 or 1 dice left). This is just to give the user someone to play with as well as to train themselves to get better or understand the game beyond the tutorial.

- Option to host and join online servers to play with other players on different devices. This is much more advanced and will only be attempted if there is time.

<br>

## User interaction outline

The user will first need to follow the instructions outlined for installation and setup as shown in the top section of the README.md file. Once they have followed the instructions and run the application, they will access a main menu which will have a welcome message to instruct them to navigate through the menu options using the arrow keys on their keyboard. The options present will be in plain english and include (for MVP):
- Learn the rules of Thief
- Start a new game
- Quit

The tutorial option will then go through the setup for the game with a step by step process driven by the user directing the steps with the left and right arrow keys (which will appear as an instruction at the top of the terminal window for each instruction stage). At each step there will be text at the bottom of the screen with notes to explain what is going on and the reasoning behind game choices. At any point they can quit the tutorial by pressing the "q" key on their keyboard (which also appears in the instructions above).

New game option brings the user to a setup menu where they input the number of players (int between 3-6) and then a following prompt that allows the users to input their individual names depending on the number of players in the game. This is the only instance of a user option that is not a tty-prompt and will require that the user inputs valid response between 3-15 characters for the player names and a integer value between 3-6 for the number of players. If the user does not input the correct values, an error will flag and the user will be asked to repeat their response with the proper values.

In the game loop proper, the player order will be randomly chosen with the active player highlighted in the header scoreboard. This player will then be instructed to select the option to roll the number of dice available (not held, starts with full 5 set). The output of the roll will show as a series of numbers with valid values/sets highlighted (sets will be encompassed with []). In outcome 1 where there are valid and invalid values/sets, the user then is prompted to select between two options of re-rolling or ending their turn.

If they choose to re-roll all dice values/sets are un-highlighted and the user is instructed to select the values/sets that they would like to hold for the subsequent rolls (and that at least one must be selected). Once selected the values/set are highlighted in a different color/style to denote a "held" status (which remains until either outcome 2 or 3 is reached). When satisfied with their selection, the user is then instructed to select the prompt for the re-roll and the process continues with the remaining dice.

If the user chooses to end their turn then the active player highlight moves to the next in the sequence and they are then prompted to ask whether they want to steal the previous player's turn. 

If they choose to not steal then they begin a new turn and the previous player's pot gets added to their total score.

If they choose to steal then the pot moves to them and that player now continues the previous player's turn but must re-roll at least once before ending their turn. They are not provided the option to end their turn until have rolled the remaining dice that have not been held.

In outcome 2 where there are no valid values/sets from the dice rolled then the active player ends their turn, receives no points added to their score and the highlighted active player moves to the next one in the sequence.

In outcome 3 where all 5 dice have a valid value/set then the held dice become un-held, the accumulated points stay in the pot and the active player is prompted to continue their turn by rolling all 5 dice again.

At any point in the game (for MVP) the players can end the game and return to the menu by pressing "q" while in the game loop. This option is shown as a footer in the game area.

This application focuses on creating a user experience that minimizes the need for error handling from the user inputs. Almost all menu options from the terminal app will be using tty-prompt options with the exception of the feature that accepts a string input of the player's names and the number input for the number of players. 