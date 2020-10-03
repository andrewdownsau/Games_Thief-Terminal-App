
class UserInterface
  include GameHelper

  attr_accessor :instruction, :prompt, :prompt_selection, :prompt_response, :player_list, :scoreboard, :dice_results, :page_title

  def initialize
    @scoreboard
    @instruction
    @player_list = []
    @dice_results = []
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

  def select_prompt
    @prompt_selection = PROMPT.select(@prompt[:header]) do |menu|
      for i in 0..@prompt[:options].length-1 do
        menu.choice({ 
          name: @prompt[:options][i].colorize(@prompt[:colors][i]), 
          value: @prompt[:values][i] 
        })
      end
    end
  end

  def ask_range_prompt
    @prompt_response = PROMPT.ask(@prompt[:header]) do |question|
      question.in @prompt[:input_expected]
      question.messages[:range?] = @prompt[:error_message]
    end
  end

  def ask_text_prompt
    @prompt_response = PROMPT.ask(@prompt[:header]) do |question|
      question.required true
      question.validate /\A\w+\Z/
      question.modify  :capitalize
    end
  end

  def set_prompt
    case @prompt[:type]
    when "select" then select_prompt
    when "ask_range" then ask_range_prompt
    when "ask_text" then ask_text_prompt
    end
  end

  def populate_ui
    sections_arr = [[heading]]
    sections_arr << [@page_title]
    sections_arr << [@scoreboard] if @scoreboard
    sections_arr << [@instruction]
    sections_arr << [@player_list] unless @player_list == [] || @scoreboard
    sections_arr << [@dice_results[0] + @dice_results[1]] unless @dice_results == []
    set_frame_ui(sections_arr)
    set_prompt
  end
end

