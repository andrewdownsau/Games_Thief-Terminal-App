module GameHelper
  PROMPT = TTY::Prompt.new(prefix: "| ")

  #Instructions
  INSTRUCTION_MENU = "Welcome to my Theif Terminal Game!"

  #Prompts
  PROMPT_MENU = [
    "Please select from the following:",
    ["Tutorial", "New Game", "Exit App"],
    ["tutorial", "new_game", "exit_app"],
    [nil, nil, nil]
  ]
end