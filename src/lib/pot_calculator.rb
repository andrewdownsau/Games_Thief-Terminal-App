class PotCalculator
  attr_reader :pot

  def initialize
    @pot = 0
    @return_base = 1
  end

  def pot_calculation(previous_pot, string_value, operator)
    @return_base = 10 if string_value.include?("1")

    unless string_value[0] == "["
      @pot += string_value[0].to_i * 10 * @return_base if operator == "add"
      @pot -= string_value[0].to_i * 10 * @return_base if operator == "subtract"
    else
      set_multiplier = (string_value.length-7)/2
      @pot += string_value[1].to_i * 100 * set_multiplier * @return_base if operator == "add"
      @pot -= string_value[1].to_i * 100 * set_multiplier * @return_base if operator == "subtract"
    end

    @pot += previous_pot
  end
end