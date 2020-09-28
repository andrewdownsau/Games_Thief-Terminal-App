#files
require_relative 'game_helper'

class GameBoard
  include GameHelper

  def initialize(game)
    @game = game
    @scoreboard = "Scoreboard: "
    @instruction = "\n[#{@game.active_player}] New turn, please roll all 5 dice\n\n"
    @result = "No result to display, please select action"
    @user_prompt = [
      "Please select:", 
      ["Roll #{@game.rollable_dice} dice","Exit game"], 
      ['roll', 'exit']
    ]
  end

  def set_scoreboard
    system("clear")
    @scoreboard = "Scoreboard: "
    @game.players.each do |player|
      @scoreboard << "#{player}: #{@game.scores[player]} "
    end
    @scoreboard
  end

  def set_user_prompt
    puts ""
    PROMPT.select(@user_prompt[0]) do |menu|
      for i in 0..@user_prompt[1].length do
        menu.choice({ name: @user_prompt[1][i], value: @user_prompt[2][i] })
      end
    end
  end

  def prompt_resolver
    case set_user_prompt
    when 'roll'
      roll_calc = RollCalculator.new
      @result = roll_calc.roll_outcome
      roll_calc.calculate_roll
      @instruction = "\n[#{@game.active_player}] Dice cast, please select at least one value/set to hold to pot\n\n"
    
      # generate_roll_selection_prompt(roll_calc)
    end
  end

  def generate_roll_selection_prompt(roll_calc)
    valid_arr =  roll_calc.return_hash[:valid]
    PROMPT.select('\nValid dice values/sets to hold:') do |menu|
      for i in 0..valid_arr.length-1 do
        menu.choice({ name: "#{valid_arr[i]}", value: "#{[i]}"})
      end
    end
  end

  def main_game_loop
    loop do
      puts set_scoreboard
      puts @instruction
      puts @result
      prompt_resolver
    end
  end

end