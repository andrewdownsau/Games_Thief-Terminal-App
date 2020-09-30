# gems
require 'tty-prompt'
require 'terminal-table'
require 'colorize'

# files
require_relative 'game_helper'
require_relative 'prompt'

class UserInterface
  include GameHelper

  def initialize
    @in_game = false
    @scoreboard
    @instruction =  INSTRUCTION_MENU
    @dice_results
    @prompt = Prompt.new
    @footer = "Debugging Area"
  end

  def frame(sections_arr)
    system("clear")
    app_frame = Terminal::Table.new do |table|
      table.rows = sections_arr
      table.style = {:all_separators => true}
    end
    puts app_frame
  end
  
  def heading
    heading_str =  "╭━━┳╮╭╮╱╭━╮╭━━╮╱╱╱╭╮╱╱╱╱╱╱╱╱╭━━╮\n"
    heading_str << "╰╮╭┫╰╋╋━┫━┫╰╮╭┻┳━━╋╋━┳┳━╮╭╮╱┃╭━╋━╮╭━━┳━╮\n"
    heading_str << "╱┃┃┃┃┃┃┻┫╭╯╱┃┃┻┫┃┃┃┃┃┃┃╋╰┫╰╮┃╰╮┃╋╰┫┃┃┃┻┫\n"
    heading_str << "╱╰╯╰┻┻┻━┻╯╱╱╰┻━┻┻┻┻┻┻━┻━━┻━╯╰━━┻━━┻┻┻┻━╯\n"
  end

  def prompt
    @prompt.route_out_game unless @in_game
    PROMPT.select(@prompt.header) do |menu|
      for i in 0..@prompt.options.length-1 do
        menu.choice({ 
          name: @prompt.options[i].colorize(@prompt.colorizes[i]), 
          value: @prompt.values[i] 
        })
      end
    end
  end

  def run
    sections_arr = [[heading]]
    sections_arr << [@scoreboard] if @in_game
    sections_arr << [@instruction]
    sections_arr << [@dice_results] if @in_game
    sections_arr << [@footer]
    frame(sections_arr)
    prompt
  end
end

app = UserInterface.new
app.run