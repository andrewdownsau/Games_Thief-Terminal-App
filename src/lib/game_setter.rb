#files
require_relative 'game_helper'

class GameSetter
  attr_reader :playernumber, :players

  include GameHelper

  def initialize
    @index = 0
    @player_number = 1
    @players = []
    @exit = false
  end

  def instruction_input_prompt
    puts ""
    if @player_number == 1
      puts "Please input the number of players."
      puts "Games can only accept groups between 3-6 players"
      print "Number of players: "
    else
      puts "Please input name of player #{@index+1}."
      puts "Player name must be between 3-15 characters long."
      puts "Player names cannot be repeated."
      print "\nPlayer #{@index+1}: "
    end
  end

  def input_validation
    input = gets.chomp
    if input == 'q' || input == 'Q'
      @exit = true
    elsif @player_number == 1 && (input.length !=  1 || input.to_i.between?(3, 6) == false)
      return nil
    elsif @player_number != 1 && (input.length.between?(3, 15) == false || players.include?(input))
      return nil
    else
      return input
    end
  end

  def name_confirmation(name)
    puts "Are you happy with the name #{name}?"
    print "(y/n): "
    confirm = gets.chomp
    system("clear")
    if confirm == 'y'
      puts "Welcome #{name}!"
      @players << name
      @index += 1
    else
      puts "Please re-enter name."
    end
  end

  def input_response(input)
    if input
      if @player_number == 1
        @player_number = input.to_i
        system("clear")
      else
        name_confirmation(input)
      end
      puts "New game will have #@player_number players"
    else
      system("clear")
      puts "Invalid input entered."
    end
  end

  def player_list_display
    puts "\nPlayer list:"
      player_num = 0
      while player_num < @players.length
        puts " - #{@players[player_num]}"
        player_num += 1
      end
  end

  def confirm_game_selection
    puts "\nPlayer names have been entered"
    selection = PROMPT.select('Would you like to proceed to the game?') do |menu|
      menu.choice({ name: 'Start Game', value: '1' })
      menu.choice({ name: 'Reset settings', value: '2' })
      menu.choice({ name: 'Exit to menu', value: '3' })
    end
    system("clear")
    case selection
    when '1' then @exit = true
    when '2' then initialize
    when '3' then @exit = true
    end
  end

  def settings_user_input
    loop do
      player_list_display if @player_number != 1
      if @player_number > @players.length
        puts "\nTo exit to the menu at any point simply type 'q' or 'Q' and return"
        instruction_input_prompt
        input = input_validation
        break if @exit
        input_response(input)
      else 
        confirm_game_selection
        break if @exit
      end
    end
    return @players
  end

end