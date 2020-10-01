class Round
  attr_accessor :pot_total, :rolled_dice_set, :held_dice_set, :free_dice_set, :dice_value_scores, :valid_dice_set, :valid_dice_number

  def initialize
    @pot_total = 0
    @free_dice_set = []
    @rolled_dice_set = []
    5.times {@free_dice_set << Die.new}
    @held_dice_set = []
    @valid_dice_set = []
    @dice_value_arr = []
    @dice_value_scores = []
    @valid_dice_number = 0
  end

  def check_straight
    # Checks for straight output [1, 2, 3, 4 ,5]
    sorted_roll = @dice_value_arr.sort
    sorted_roll.each_with_index do |roll,index|
      return nil unless roll == index+1
    end
    @valid_dice_set = "[1, 2, 3, 4 ,5]"
    @rolled_dice_set = @free_dice_set
    @dice_value_scores << 2500
    @valid_dice_number = 5
    @dice_value_arr = []
  end

  def check_set
    # Checks for set of 3, 4 or 5 values
    set = []
    @dice_value_arr.each do |val| 
      val_counter = @dice_value_arr.count(val)
      if val_counter > 2
        @valid_dice_number += val_counter
        base_multiplier = 100
        base_multiplier = 1000 if val == "1"
        @dice_value_scores << val.to_i * base_multiplier * 2**(val_counter-3)
        val_counter.times {set << val.to_i}
        @rolled_dice_set << @free_dice_set.map{|die| die if die.value == val}
        @dice_value_arr.delete(val)
        break
      end
    end
    @valid_dice_set << set.to_s unless set == []
  end

  def check_1_5
    # Check for values 1 and 5
    @dice_value_arr.each do |val| 
      if val == "1" || val == "5"
        @valid_dice_number += 1
        base_multiplier = 10
        base_multiplier = 100 if val == "1"
        @dice_value_scores << val.to_i * base_multiplier
        @valid_dice_set << val
        @rolled_dice_set << @free_dice_set.map{|die| die if die.value == val}
      end
    end
    @dice_value_arr.each do |val| 
      unless val == "1" || val == "5"
        @rolled_dice_set << @free_dice_set.map{|die| die if die.value == val}
      end
    end
    @dice_value_scores.each { |a| @pot_total+=a } if @valid_dice_number == 5
  end

  def roll
    @dice_value_arr = @free_dice_set.map{|die| die.value = rand(1..6).to_s}.sort
    @free_dice_set = @free_dice_set.sort_by{ |die| die.value }
    check_straight
    check_set
    check_1_5
    p @rolled_dice_set
    gets
  end
end