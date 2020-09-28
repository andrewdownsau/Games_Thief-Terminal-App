# This class recieves a prompt selection and
# routes the required methods to return the
# scores, instructions, results and further prompt array

class UserPromptRouter

  attr_reader :return_arr

  def initialize(user_selection, user)
    @user_selection = user_selection
    @user = user
    @return_arr = []
  end

  def roll_prompt_router(dice)
    roll_calc = RollCalculator.new
    @return_arr << "\n[#{@user}] Dice cast, please select at least one value/set to hold to pot\n\n"
    @return_arr << roll_calc.roll_outcome
    roll_calc.calculate_roll
    user_prompt_arr = ["Valid dice values/sets to hold:"]
    2.times { user_prompt_arr << roll_calc.return_hash[:valid] }
    @return_arr << user_prompt_arr
  end

  def resolve_prompt
    case @user_selection
    when 'roll'
      roll_prompt_router(5) # Dice value currently not used but will deal with later
      # generate_roll_selection_prompt(roll_calc)
    else
      puts "no method here yet"
      gets.chomp
    end
  end

  def generate_roll_selection_prompt(roll_calc)
    valid_arr =  roll_calc.return_hash[:valid]
    PROMPT.select('\nValid dice values/sets to hold:') do |menu|
      for i in 0..valid_arr.length-1 do
        menu.choice({ name: "#{valid_arr[i]}", value: "#{[i]}"})
      end
    end
  end
end