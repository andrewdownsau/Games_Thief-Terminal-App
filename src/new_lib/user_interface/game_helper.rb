module GameHelper
  PROMPT = TTY::Prompt.new(prefix: "| ")

  #Instructions
  INSTRUCTION_MENU = "Welcome to my Theif Terminal Game!"
  INSTRUCTION_SETUP_NUMBER = "Please input the number of players.\n"
  INSTRUCTION_SETUP_NUMBER << "Games can only accept groups between 3-6 players"
  INSTRUCTION_SETUP_PLAYER = "Please input name of new player\n"
  INSTRUCTION_SETUP_PLAYER << "Player name must be between 3-15 characters long\n"
  INSTRUCTION_SETUP_PLAYER << "Player names cannot be repeated"
  INSTRUCTION_SETUP_CONFIRM = "Player names have all been entered"
  INSTRUCTION_START_ROUND = "New round, please roll all 5 dice"

  #Prompts
  PROMPT_MENU = {
    type: "select",
    header: "Please select from the following:",
    options: ["Tutorial", "New Game", "Exit App"],
    values: ["tutorial", "new_game", "exit_app"],
    colors: [nil, nil, nil]
  }
  PROMPT_SETUP_NUMBER = {
    type: "ask_range",
    header: "Number of players (3-6):",
    input_expected: "3-6",
    error_message: "%{value} out of expected range"
  }
  PROMPT_SETUP_PLAYER = {
    type: "ask_text",
    header: "Name of new player: "
  }
  PROMPT_CONFIRM_SETUP = {
    type: "select",
    header: "Would you like to proceed to the game?",
    options: ["Start Game", "Reset settings", "Exit to menu"],
    values: ["start_game", "reset_game", "exit_to_menu"],
    colors: [nil, nil, nil]
  }
  PROMPT_ROLL = {
    type: "select",
    header: "Roll dice by confirming below:",
    options: ["Roll dice", "Exit to menu"],
    values: ["roll_dice", "exit_to_menu"],
    colors: [nil, nil]
  }
end