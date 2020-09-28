#files
require_relative 'game_helper'

class GameBoard
  include GameHelper

  def initialize(game)
    @game = game
  end

  def scoreboard
    print "Scoreboard: "
    @game.players.each do |player|
      print "#{player}: #{@game.scores[player]} "
    end
  end

  def turn_instruction
    print "\n\n[#{@game.active_player}] "
    case @game.game_choices_log.last[1]
    when "new_turn"
      print "This is a start of a new turn, please roll all 5 dice\n\n"
    else
      puts "Error, cannot distinguish activity insturction"
    end
  end

  def user_prompt
    case @game.game_choices_log.last[1]
    when "new_turn"
      PROMPT.select('Please select:') do |menu|
        menu.choice({ name: "Roll #{@game.rollable_dice} dice", value: 'roll' })
        menu.choice({ name: 'Exit game', value: '0' })
      end
    else
      puts "Error, cannot distinguish activity insturction"
    end
  end

  def roll_generator
    puts "Roll output: "
    roll_arr = []
    5.times { roll_arr.push(rand(1..6)) }
    p roll_arr
    roll_calc = RollCalculator.new(roll_arr)
    roll_calc.calculate_roll
  end

  def prompt_resolver
    case user_prompt
    when 'roll'
      roll_generator
    end
  end

  def main_game_loop
    loop do
      scoreboard
      turn_instruction
      prompt_resolver
      gets.chomp
      break
    end
  end

end