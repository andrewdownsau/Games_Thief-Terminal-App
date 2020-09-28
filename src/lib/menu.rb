# gems
require 'terminal-table'
require 'tty-prompt'
#files
require_relative 'game_setter'
require_relative 'game_helper'
require_relative 'game'
require_relative 'game_board'
require_relative 'game_repository'
require_relative 'roll_calculator'

class Menu

  include GameHelper

  def initialize
    @game_repository = GameRepository.new
  end

  def selection
    puts "Welcome to my Theif Terminal Game!"
    PROMPT.select('Please select from the following:') do |menu|
      menu.choice({ name: 'Tutorial', value: '1' })
      menu.choice({ name: 'New Game', value: '2' })
      menu.choice({ name: 'Exit game', value: '3' })
    end
  end

  def router
    loop do
      system("clear")
      case selection
      when '1' then puts "Tutorial Selected"
      when '2' then puts @game_repository.start_new_game
      when '3' then exit
      end
    end
  end
end

app = Menu.new
app.router