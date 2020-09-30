# gems
require 'tty-prompt'
require 'terminal-table'
require 'colorize'

# files
require_relative 'game_helper'
require_relative 'main_ui'

class AppRouter
  include GameHelper
  def initialize
    @main_ui = UserInterface.new
    @temp_prompt_selection = "0"
    @temp_prompt_response = "0"
    @number_of_players = 0
  end

  def start_app
    @main_ui.page_title = "Main Menu"
    @main_ui.instruction =  INSTRUCTION_MENU
    @main_ui.prompt = PROMPT_MENU
    @main_ui.player_list = []
  end

  def new_game_setup_0
    @main_ui.page_title = "Game Setup - Number of Players"
    @main_ui.instruction =  INSTRUCTION_SETUP_NUMBER
    @main_ui.prompt = PROMPT_SETUP_NUMBER
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

  def route_prompt
    unless @temp_prompt_selection == @main_ui.prompt_selection
      case @main_ui.prompt_selection
      when nil then start_app
      when "tutorial" then puts "Goes to tutorial page"
      when "new_game" then new_game_setup_0
      when "exit_app" then exit
      when "exit_to_menu" then start_app
      end
      @temp_prompt_selection = @main_ui.prompt_selection
    end
    
    unless @temp_prompt_response == @main_ui.prompt_response
      case @main_ui.prompt_response
      when nil
      when "3".."6" 
        @number_of_players = @main_ui.prompt_response.to_i
        new_game_setup_1
      else
        @main_ui.player_list << @main_ui.prompt_response
        new_game_setup_2 if @main_ui.player_list.length == @number_of_players
      end
      @temp_prompt_response = @main_ui.prompt_response
    end
  end

  def run
    loop do
      route_prompt
      @main_ui.populate_ui
    end
  end
end


app = AppRouter.new
app.run