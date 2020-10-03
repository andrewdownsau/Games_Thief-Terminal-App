module OptionsGeneralGame
  include GameHelper

  def start_app
    @main_ui.page_title = "Main Menu"
    @main_ui.scoreboard = nil
    @main_ui.instruction =  INSTRUCTION_MENU
    @main_ui.dice_results = []
    @main_ui.prompt = PROMPT_MENU
    @main_ui.player_list = []
  end

  def initiate_round(status)
    @main_ui.instruction =  INSTRUCTION_START_ROUND
    @main_ui.prompt = PROMPT_ROLL
    @game.start_round(status)
    active_round_refresh
  end

  def start_game
    @game.randomize_players
    initiate_round("begin")
  end

  def restart_game
    @new_game = Game.new
    @new_game.players = @game.players
    @new_game.number_of_players = @game.number_of_players
    @game = @new_game
    @game.randomize_players
    initiate_round("begin")
  end

  def pass_turn
    # Passing turn gives option for next player to steal turn
    @main_ui.instruction = INSTRUCTION_STEAL_TURN
    @main_ui.prompt = PROMPT_STEAL_TURN
  end

  def steal_turn
    @game.move_to_next_player
    roll_free_dice
  end
end