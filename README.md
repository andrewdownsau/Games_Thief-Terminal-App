# Thief game terminal app

### GitHub Code Repository : https://github.com/andrewdownsau/thief_game_terminal_app

<br><hr>

## Installation and setup

<br><hr>

## Software Development Plan

Welcome to Thief! A fun dice/card game (created by my sister Cassandra Downs) that incorporates risk/reward chaining and using your hand of tools to throw off your opponents and claim your victory!

In these times of social isolation it's become more important than ever for people to remain connected through events, interaction and fun activities. This terminal application is meant to provide the programmatic scaffolding of the business logic required for a web-based application to allow players to engage with this game remotely. I'm personally developing this application because I really enjoy playing this game with my friends and I think other people will be able to enjoy it too.

The target audience of this application will be a group of players (between 3-6 people) of this game. They will most likely be non-technical laypeople who want to enjoy the game with their friends.

The game works with a set of 6 dice. The first player rolls the dice and if there are any 1's, 5's or set of 3 or higher values in the roll then they are tallied as the players score. There are a number of possible cases for the game to account for and they include:
- Valid values or sets are present with other values not present: player has the choice of passing or holding some or all of their dice values and rolling the remaining dice to increase their score.
- No values or sets are present with dice that are rolled: player turn is forfeit and no points added to overall score, next players turn
- All 6 dice results are valid values or sets: player rolling chains current points and rolls full set again
- Player passes while dice still to roll: next player has the option of stealing score, using up their turn to usurp their tally. If they pass after rolling the player next to them has the same chance.
- Stealing player either busts or does not choose to steal: previous player points accumulated is added to their overall score

An expansion feature of the game is to include a deck of cards that adds more complexity to the game in that players can on their or other's turn play game cards that provide buffs and de-buffs to the current rolling player.

The scope of this project will allow for the group of players to run the game application on a single terminal window or (if there is enough time to implement) through a series of networked terminals run through a host server. If there is enough time to implement further I would like to create a series of rudimentary AIs to play against so a single user can play through the game.

<br><hr>

## Features

Listed are a number of features that are defined as actions that the user should be able to perform when interacting with the program:

- 