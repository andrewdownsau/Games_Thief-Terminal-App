class RollOutcomesRouter
  attr_reader :rolloutcome_array

  def initialize
    @rolloutcome_array = []
    @instruction
    @result
    @user_prompt = []
    @player_end = false
    @pot = 0
  end

  def assign_bust_array
    @instruction = "New turn, please roll all 5 dice\n\n"
    @result = "No result to display, please select action"
    @user_prompt = [
      "Please select:", 
      ["Roll 5 dice","Exit game"], 
      ['roll', 'exit'],
      [{background: :none}, {background: :none}]
    ]
    @pot = 0
    @player_end = true
  end

  def route_outcome
    roll_calc = RollCalculator.new
    roll_calc.calculate_roll
    roll_hash_output = roll_calc.return_hash
    # p roll_hash_output
    # gets

    #Outcome 1 - no valid values
    if roll_hash_output[:valid] == []
      assign_bust_array
    end

    @rolloutcome_array << @instruction
    @rolloutcome_array << @result
    @rolloutcome_array << @user_prompt
    @rolloutcome_array << @pot
    @rolloutcome_array << @player_end
  end
end