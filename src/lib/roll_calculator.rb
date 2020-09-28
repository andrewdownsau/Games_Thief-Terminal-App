class RollCalculator
  attr_reader :return_hash, :roll_outcome

  def initialize
    @roll_arr = []
    5.times { @roll_arr.push(rand(1..6)) }
    @roll_outcome = "Roll results: "
    for i in 0..4 do
      @roll_outcome << "#{@roll_arr[i]} "
    end 
    puts "\n\n"
    @return_hash = {valid: [], invalid: []}
  end

  def check_straight
    # Checks for straight output [1, 2, 3, 4 ,5]
    sorted_roll = @roll_arr.sort
    sorted_roll.each_with_index do |roll,index|
      return nil unless roll == index+1
    end
    @roll_arr = []
    @return_hash = {valid: [1,2,3,4,5], invalid: []}
  end

  def check_set
    # Checks for set of 3, 4 or 5 values
    set = []
    @roll_arr.each do |val| 
      if @roll_arr.count(val) > 2
        @roll_arr.count(val).times { set << val }
        @roll_arr.delete(val)
        break
      end
    end
    @return_hash[:valid] << set unless set == []
  end

  def check_1_5
    # Check for values 1 and 5
    @roll_arr.each do |val| 
      if val == 5 || val == 1
        @return_hash[:valid] << val 
      else
        @return_hash[:invalid] << val
      end
    end
    @return_hash[:valid] << "Confirm Holds"
  end

  def calculate_roll
    # input array: [3, 4, 3, 5, 3]
    # return hash: {valid: [[3,3,3],5], invalid: 4}
    check_straight
    check_set
    check_1_5
  end
end