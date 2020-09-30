
class UserInterface
  include GameHelper

  attr_writer :instruction, :scoreboard, :dice_results, :prompt, :page_title
  attr_accessor :prompt_selection, :prompt_response, :player_list

  def initialize
    @scoreboard
    @instruction
    @player_list = []
    @dice_results
    @prompt
    @prompt_selection = nil
    @prompt_response = nil
    @page_title
  end

  def set_frame_ui(sections_arr)
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

  def instruction(added_strings_arr)
    
  end

  def set_prompt
    case @prompt[:type]
    when "select"
      @prompt_selection = PROMPT.select(@prompt[:header]) do |menu|
        for i in 0..@prompt[:options].length-1 do
          menu.choice({ 
            name: @prompt[:options][i].colorize(@prompt[:colors][i]), 
            value: @prompt[:values][i] 
          })
        end
      end
    when "ask_range"
      @prompt_response = PROMPT.ask(@prompt[:header]) do |question|
        question.in @prompt[:input_expected]
        question.messages[:range?] = @prompt[:error_message]
      end
    when "ask_text"
      @prompt_response = PROMPT.ask(@prompt[:header]) do |question|
        question.required true
        question.validate /\A\w+\Z/
        question.modify  :capitalize
      end
    end
  end

  def populate_ui
    sections_arr = [[heading]]
    sections_arr << [@page_title]
    sections_arr << [@scoreboard] if @scoreboard
    sections_arr << [@instruction]
    sections_arr << [@player_list] unless @player_list == []
    sections_arr << [@dice_results] if @dice_results
    set_frame_ui(sections_arr)
    set_prompt
  end
end

