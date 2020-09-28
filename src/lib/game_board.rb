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
      unless @user_prompt[1].length == 0
        for i in 0..@user_prompt[1].length-1 do
          menu.choice({ name: @user_prompt[1][i], value: @user_prompt[2][i] })
        end
      else
        puts "No valid values"
        gets.chomp
      end
    end
  end

  def reset_from_prompt_response(prompt_response)
    @instruction = prompt_response[0]
    @result = prompt_response[1]
    @user_prompt = prompt_response[2]
  end

  def main_game_loop
    loop do
      puts set_scoreboard
      puts @instruction
      puts @result
      user_selection = set_user_prompt
      user_prompt_router = UserPromptRouter.new(user_selection, @game.active_player)
      user_prompt_router.resolve_prompt
      reset_from_prompt_response(user_prompt_router.return_arr)
    end
  end

end