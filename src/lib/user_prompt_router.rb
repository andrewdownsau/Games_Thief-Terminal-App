# This class recieves a prompt selection and
# routes the required methods to return the
# pot, instructions, results and further prompt array

class UserPromptRouter

  attr_reader :return_arr

  def initialize(user_selection, user, previous_arr)
    @user_selection = user_selection
    @user = user
    @previous_arr = previous_arr
    @return_arr = []
  end

  def roll_prompt_router(dice)
    roll_calc = RollCalculator.new
    @return_arr << "\n[#{@user}] Dice cast, please select at least one value/set to hold to pot\n\n"
    @return_arr << roll_calc.roll_outcome
    roll_calc.calculate_roll
    user_prompt_arr = ["Valid dice values/sets to hold:"]
    user_prompt_arr << roll_calc.return_hash[:valid].map(&:to_s)
    user_prompt_value_arr = []
    user_prompt_color_arr = []
    roll_calc.return_hash[:valid].each_index do |index|
      user_prompt_value_arr << "hold " + index.to_s
      user_prompt_color_arr << {background: :none}
    end
    user_prompt_arr << user_prompt_value_arr
    user_prompt_arr << user_prompt_color_arr
    @return_arr << user_prompt_arr
    @return_arr << 0 # Pot value, will need to use previous but need to work on it
  end

  def hold_release_prompt_router(held_value, action_string)
    held_index = held_value.split(" ")[1]
    pot_calc = PotCalculator.new
    if held_value == @previous_arr[2][2].last
      @previous_arr[0] = "\n[#{@user}] Confirmed selection\n\n"
    else
      if action_string == "hold"
        @previous_arr[0] = "\n[#{@user}] Held value[#{held_index}] to add to pot, hold more/less and confirm\n\n"
        @previous_arr[2][3][held_index.to_i] = {background: :yellow}
        pot_calc.pot_calculation(@previous_arr[3],@previous_arr[2][1][held_index.to_i],"add")
        @previous_arr[2][2][held_index.to_i] = "release #{held_index}"
      else
        @previous_arr[0] = "\n[#{@user}] Release value[#{held_index}], hold more/less and confirm\n\n"
        @previous_arr[2][3][held_index.to_i] = {background: :none}
        pot_calc.pot_calculation(@previous_arr[3],@previous_arr[2][1][held_index.to_i],"subtract")
        @previous_arr[2][2][held_index.to_i] = "hold #{held_index}"
      end
      @previous_arr[3] = pot_calc.pot
    end
    @return_arr = @previous_arr
  end

  def bust_prompt_router
    @previous_arr[0] = "\n[#{@user}] New turn, please roll all 5 dice\n\n"
    @return_arr = @previous_arr
  end

  def resolve_prompt
    case @user_selection.split(" ")[0]
    when 'roll'
      # roll_prompt_router(5) # Dice value currently not used but will deal with later
      rolloutcome = RollOutcomesRouter.new
      rolloutcome.route_outcome
      @return_arr = rolloutcome.rolloutcome_array
    when "hold"
      hold_release_prompt_router(@user_selection, "hold")
    when "release"
      hold_release_prompt_router(@user_selection, "release")
    when 'bust'

    else
      puts "no method here yet"
      gets.chomp
    end
  end
end