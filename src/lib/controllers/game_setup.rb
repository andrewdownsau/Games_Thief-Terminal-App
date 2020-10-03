module GameSetup
  include GameHelper
  def new_game_setup_0
    @game = Game.new
    @main_ui.page_title = "Game Setup - Number of Players"
    @main_ui.instruction =  INSTRUCTION_SETUP_NUMBER
    @main_ui.prompt = PROMPT_SETUP_NUMBER
    @game.players = []
    @main_ui.player_list = []
  end

  def new_game_setup_1
    @main_ui.page_title = "Game Setup - Player Names"
    @main_ui.instruction =  INSTRUCTION_SETUP_PLAYER
    @main_ui.prompt = PROMPT_SETUP_PLAYER
  end

  def new_game_setup_2
    @main_ui.page_title = "Game Setup - Confirm Start"
    @main_ui.instruction =  INSTRUCTION_SETUP_CONFIRM
    @main_ui.prompt = PROMPT_CONFIRM_SETUP
  end
end