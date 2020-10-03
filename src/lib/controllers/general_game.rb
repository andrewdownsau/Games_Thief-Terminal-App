module GeneralGame
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

  def start_game_test
    @game = Game.new
    @game.set_player("Tom")
    @game.set_player("Harry")
    @game.set_player("Richard")
    @game.number_of_players = 3
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
    active_player = @game.get_game_value("player_name", @game.active_player_index)
    if @game.active_player_index+1 < @game.number_of_players
      stealing_player = @game.get_game_value("player_name", @game.active_player_index+1)
    else
      stealing_player = @game.get_game_value("player_name", 0)
    end
    @main_ui.prompt[:header] = "Does #{stealing_player} want to steal #{active_player}'s turn?"
  end

  def steal_turn
    @game.move_to_next_player
    roll_free_dice
  end
end