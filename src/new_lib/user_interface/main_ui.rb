
require 'tty-prompt'
require 'terminal-table'

class UserInterface
  def initialize
    @in_game = false
    @scoreboard
    @instruction =  INSTRUCTION_MENU
    @dice_results
    @prompt
    @footer
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

  def run
    sections_arr = [[heading]]
    sections_arr << [heading]
    frame(sections_arr)
  end
end

app = UserInterface.new
app.run