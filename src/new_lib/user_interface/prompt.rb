class Prompt
  include GameHelper
  attr_reader :array, :header, :options, :values, :colorizes

  def initialize
    @array = []
    @header
    @options = []
    @values = []
    @colorizes = []
    @selection = nil
  end

  def set_prompt_parameters
    @header = @array[0]
    @options = @array[1]
    @values = @array[2]
    @colorizes = @array[3]
  end

  def route_out_game
    case @selection
    when nil
      @array = PROMPT_MENU
    end
    set_prompt_parameters
  end
end