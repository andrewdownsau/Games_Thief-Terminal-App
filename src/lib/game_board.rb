#files
require_relative 'game_helper'

class GameBoard
  include GameHelper

  def initialize(game)
    @game = game
    @scoreboard = "Scoreboard: "
    @instruction = "New turn, please roll all 5 dice\n\n"
    @result = "No result to display, please select action"
    @user_prompt = [
      "Please select:", 
      ["Roll 5 dice","Exit game"], 
      ['roll', 'exit'],
      [{background: :none}, {background: :none}]
    ]
    @prompt_response = []
    @current_pot = 0
  end

  def set_scoreboard
    system("clear")
    @scoreboard = "Scoreboard: "
    @game.players.each do |player|
      @scoreboard << "#{player}: #{@game.scores[player]} "
      if player == @game.active_player
        @scoreboard << "+ [#{@current_pot}] "
      end
    end
    @scoreboard
  end

  def set_user_prompt
    puts ""
    PROMPT.select(@user_prompt[0]) do |menu|
      for i in 0..@user_prompt[1].length-1 do
        menu.choice({ name: @user_prompt[1][i].colorize(@user_prompt[3][i]), value: @user_prompt[2][i] })
      end
    end
  end

  def reset_from_prompt_response(prompt_response)
    @instruction = prompt_response[0]
    @result = prompt_response[1]
    @user_prompt = prompt_response[2]
    @current_pot = prompt_response[3]
    @game.move_to_next_player if prompt_response[4] #player's turn ended
    # p @prompt_response
    # gets
  end

  def main_game_loop
    loop do
      puts set_scoreboard
      print "\n[#{@game.active_player}] "
      puts @instruction
      puts @result
      user_selection = set_user_prompt
      user_prompt_router = UserPromptRouter.new(user_selection, @game.active_player,@prompt_response)
      user_prompt_router.resolve_prompt
      @prompt_response = user_prompt_router.return_arr
      reset_from_prompt_response(@prompt_response)
    end
  end

end