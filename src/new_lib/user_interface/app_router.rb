# gems
require 'tty-prompt'
require 'terminal-table'
require 'colorize'

# files
require_relative 'game_helper'
require_relative 'main_ui'
require_relative '../game_logic/game'

class AppRouter
  include GameHelper
  def initialize
    @main_ui = UserInterface.new
    @temp_prompt_selection = "0"
    @temp_prompt_response = "0"
  end

  def start_app
    @main_ui.page_title = "Main Menu"
    @main_ui.scoreboard = nil
    @main_ui.instruction =  INSTRUCTION_MENU
    @main_ui.dice_results = []
    @main_ui.prompt = PROMPT_MENU
    @main_ui.player_list = []
  end

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

  def initiate_round
    @main_ui.instruction =  INSTRUCTION_START_ROUND
    @main_ui.prompt = PROMPT_ROLL
    @game.start_round
    active_round_refresh
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

  def roll_holding_options
    @main_ui.prompt = {
      type: "select",
      header: "Hold at least one value/set and confirm :",
      options: ["Confirm Holds", "Exit to menu"],
      values: ["confirm_holds", "exit_to_menu"],
      colors: [nil, nil]
    }
    prompt_values = @game.get_game_value("valid_dice_values", nil)
    for i in (0..prompt_values.length-1).reverse_each do
      @main_ui.prompt[:options].unshift(prompt_values[i])
      @main_ui.prompt[:values].unshift("hold: " + i.to_s)
      @main_ui.prompt[:colors].unshift(nil)
    end
    puts @main_ui.prompt
    gets
  end
  
  def roll_prompt_result
    instruction_title = INSTRUCTION_ROLL_OUTCOME
    instruction_body = ""
    case @game.get_game_value("valid_dice_options_dice_number", nil)
    when 0
      instruction_body = INSTRUCTION_ROLL_OUTCOME1
      @main_ui.prompt = PROMPT_BUST
    when 5
      instruction_body = INSTRUCTION_ROLL_OUTCOME2
      @main_ui.prompt = PROMPT_CHAIN
    else
      instruction_body = INSTRUCTION_ROLL_OUTCOME3
      roll_holding_options
    end
    player_score_total = @game.get_game_value("pot", 0) + @game.get_game_value("player_score", @game.active_player_index)
    if player_score_total >= 10000
      instruction_body = INSTRUCTION_ROLL_OUTCOME4
      @main_ui.prompt = PROMPT_WIN
    end
    @main_ui.instruction = instruction_title + instruction_body
    active_round_refresh
  end

  def roll_free_dice
    @game.game_method("roll")
    roll_prompt_result
  end

  def hold_value_selected
    index = @main_ui.prompt_selection.split[1].to_i
    @main_ui.prompt[:colors][index] = {background: :green}
    @game.set_game_value("hold_dice", nil, index)
    puts "Managed to set hold value at index #{index}"
    puts @game.get_game_value("held_die_value", 0)
    gets
    active_round_refresh
  end

  def route_prompt_select
    prompt_activity = @main_ui.prompt_selection.split[0] if @main_ui.prompt_selection
    case prompt_activity
      when nil, "exit_to_menu" then start_app
      when "tutorial" then puts "Goes to tutorial page"
      # when "new_game", "reset_game" then new_game_setup_0
      when "new_game" then 
        @game = Game.new
        @game.set_player("Tom")
        @game.set_player("Dick")
        @game.set_player("Harry")
        @game.number_of_players = 3
        @game.randomize_players
        initiate_round
      when "start_game"
        @game.randomize_players
        initiate_round
      when "start_new_game"
        @new_game = Game.new
        @new_game.players = @game.players
        @new_game.number_of_players = @game.number_of_players
        @game = @new_game
        @game.randomize_players
        initiate_round
      when "roll_dice" then roll_free_dice
      when "chain_roll_dice"
        roll_free_dice
      when "hold:"
        hold_value_selected
      when "end_round" then initiate_round
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