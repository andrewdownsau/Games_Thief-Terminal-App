# gems
require 'tty-prompt'
require 'terminal-table'
require 'colorize'

# files
require_relative 'game_helper'
require_relative 'options_general_game'
require_relative 'options_setting_game'
require_relative 'options_roll_outcome'
require_relative 'main_ui'
require_relative '../game_logic/game'

class AppRouter
  include GameHelper
  include OptionsGeneralGame
  include OptionsSettingGame
  include OptionsRollOutcome

  def initialize
    @main_ui = UserInterface.new
    @temp_prompt_selection = "0"
    @temp_prompt_response = "0"
    @held_selection_count = 0
  end

  def active_round_refresh
    @main_ui.page_title = "Game active: "
    @main_ui.scoreboard = "Scores: "
    @main_ui.dice_results[0] = "Dice Held: " 
    @main_ui.dice_results[1] = "\nDice Free: " 
    populate_game_details
  end

  def populate_game_details
    # Scoreboard Values
    for i in 0..@game.number_of_players-1 do
      @main_ui.scoreboard << "#{@game.get_game_value("player_name", i)}: #{@game.get_game_value("player_score", i)} "
      if @game.players[i] == @game.active_player
        @main_ui.scoreboard << "+ [#{@game.get_game_value("pot", 0)}] " 
        @main_ui.page_title << "#{@game.get_game_value("player_name", i)}'s turn"
      end
    end
    # Dice Result Values
    @main_ui.dice_results[0] << @game.get_game_value("dice_set_held", nil)
    @main_ui.dice_results[1] << @game.get_game_value("dice_set_free", nil)
  end

  def route_prompt_select
    prompt_activity = @main_ui.prompt_selection.split[0] if @main_ui.prompt_selection
    case prompt_activity
      when nil, "exit_to_menu" then start_app
      when "tutorial" then puts "Goes to tutorial page"
      # when "new_game", "reset_game" then new_game_setup_0 # Comment out for testing to skip setup
      when "new_game" then start_game_test # Uncomment for test cases to skip setup
      when "start_game" then start_game
      when "start_new_game" then restart_game
      when "roll_dice" then roll_free_dice
      when "chain_roll_dice" then chain_roll_dice
      when "hold:" then hold_value_selected
      when "free:" then free_value_selected
      when "confirm_holds" then confirm_holds
      when "pass_turn" then pass_turn
      when "steal_turn" then steal_turn
      when "new_round" then initiate_round("new")
      when "bust_round" then initiate_round("bust")
      when "exit_app" then exit
    end
    @temp_prompt_selection = @main_ui.prompt_selection
  end
    
  def route_prompt_ask
    case @main_ui.prompt_response
      when nil
      when "3".."6" 
        @game.number_of_players = @main_ui.prompt_response.to_i
        new_game_setup_1
      else
        @game.set_player(@main_ui.prompt_response)
        @main_ui.player_list << @main_ui.prompt_response
        new_game_setup_2 if @game.players.length == @game.number_of_players
      end
    @temp_prompt_response = @main_ui.prompt_response
  end

  def run
    loop do
      # Don't allow for repeat prompts unless it is to chain roll
      unless @temp_prompt_selection == @main_ui.prompt_selection && @temp_prompt_selection != "chain_roll_dice"
        route_prompt_select
      end
      unless @temp_prompt_response == @main_ui.prompt_response
        route_prompt_ask
      end
      @main_ui.populate_ui
    end
  end
end


app = AppRouter.new
app.run