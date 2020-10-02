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
  INSTRUCTION_ROLL_OUTCOME = "Dice cast, make your choices depending on results\n\n"
  INSTRUCTION_ROLL_OUTCOME << "Roll outcome:"
  INSTRUCTION_ROLL_OUTCOME1 = "\nNo valid values from roll\n"
  INSTRUCTION_ROLL_OUTCOME1 << "Please confirm selection to move to next player"
  INSTRUCTION_ROLL_OUTCOME2 = "\nAll dice show valid calues from roll!\n"
  INSTRUCTION_ROLL_OUTCOME2 << "Please confirm selection to chain score and re-roll"
  INSTRUCTION_ROLL_OUTCOME3 = "\nSome dice are valid from roll\n"
  INSTRUCTION_ROLL_OUTCOME3 << "Please select which values to hold, then confirm"
  INSTRUCTION_ROLL_OUTCOME4 = "\nCongrats XD! You won the game!\n"
  INSTRUCTION_ROLL_OUTCOME4 << "Please select to start a new game or exit"
  INSTRUCTION_HOLD_ERROR = "\nError: Please hold at least one dice value"
  INSTRUCTION_TURN_OPTIONS = "Dice have been confirmed as held\n"
  INSTRUCTION_TURN_OPTIONS << "Now you must decide to pass or continue rolling\n\n"
  INSTRUCTION_TURN_OPTIONS << "If you pass the next player could steal your turn\n"
  INSTRUCTION_TURN_OPTIONS << "If you continue you could bust your next roll\n"

  #Prompts
  PROMPT_MENU = {
    type: "select",
    header: "Please select from the following:",
    options: ["Tutorial", "New Game", "Exit App"],
    values: ["tutorial", "new_game", "exit_app"],
    colors: [nil, nil, nil]
  }.freeze
  PROMPT_SETUP_NUMBER = {
    type: "ask_range",
    header: "Number of players (3-6):",
    input_expected: "3-6",
    error_message: "%{value} out of expected range"
  }.freeze
  PROMPT_SETUP_PLAYER = {
    type: "ask_text",
    header: "Name of new player: "
  }.freeze
  PROMPT_CONFIRM_SETUP = {
    type: "select",
    header: "Would you like to proceed to the game?",
    options: ["Start Game", "Reset settings", "Exit to menu"],
    values: ["start_game", "reset_game", "exit_to_menu"],
    colors: [nil, nil, nil]
  }.freeze
  PROMPT_ROLL = {
    type: "select",
    header: "Roll dice by confirming below:",
    options: ["Roll dice", "Exit to menu"],
    values: ["roll_dice", "exit_to_menu"],
    colors: [nil, nil]
  }.freeze
  PROMPT_BUST = {
    type: "select",
    header: "Confirm end of round:",
    options: ["End round", "Exit to menu"],
    values: ["end_round", "exit_to_menu"],
    colors: [nil, nil]
  }.freeze
  PROMPT_CHAIN = {
    type: "select",
    header: "Confirm chaining pot and re-rolling:",
    options: ["Chain & roll dice", "Exit to menu"],
    values: ["chain_roll_dice", "exit_to_menu"],
    colors: [nil, nil]
  }.freeze
  PROMPT_WIN = {
    type: "select",
    header: "Confirm to start new game or exit:",
    options: ["Start New Game", "Exit to menu"],
    values: ["start_new_game", "exit_to_menu"],
    colors: [nil, nil]
  }.freeze
  PROMPT_TURN_OPTIONS = {
    type: "select",
    header: "Confirm to pass or continue:",
    options: ["Pass to next player", "Continue & reroll", "Exit to menu"],
    values: ["pass_turn", "roll_dice", "exit_to_menu"],
    colors: [nil, nil]
  }
end