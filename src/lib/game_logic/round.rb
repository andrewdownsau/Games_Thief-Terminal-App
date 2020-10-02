class Round
  attr_accessor :pot_total, :dice_set, :valid_dice_options

  def initialize
    @pot_total = 0
    @dice_set = []
    5.times {@dice_set << Die.new}
    @dice_value_arr
    @valid_dice_options = { prompt: [], die: [], score: [], dice_number: 0 }
    @free_dice_number = 5
  end

  def check_straight
    # Checks for straight output [1, 2, 3, 4 ,5]
    sorted_roll = @dice_value_arr.sort
    sorted_roll.each_with_index do |roll,index|
      return nil unless roll == (index+1).to_s
    end
    @valid_dice_options[:die] = [@dice_set]
    @valid_dice_options[:score] << 2500
    @valid_dice_options[:dice_number] = 5
    @dice_value_arr = []
  end

  def check_set
    # Checks for set of 3, 4 or 5 values
    valid_set_prompt = []
    valid_set_die = []
    valid_set_score = 100
    val_counter = 0
    @dice_value_arr.each do |val| 
      val_counter = @dice_value_arr.count(val)
      if val_counter > 2
        val_counter.times {valid_set_prompt << val.to_i}
        valid_set_die << @dice_set.select{|die| die.value == val}
        valid_set_score *= val.to_i * 2**(val_counter-3)
        valid_set_score *= 10 if val == "1" 
        @dice_value_arr.delete(val)
        break
      end
    end
    unless valid_set_prompt == []
      @valid_dice_options[:prompt] << valid_set_prompt.to_s
      # @valid_dice_options[:die] << valid_set_die 
      for i in 0..valid_set_die.length do
        @valid_dice_options[:die] << valid_set_die[i] if valid_set_die[i]
      end
      @valid_dice_options[:score] << valid_set_score
      @valid_dice_options[:dice_number] += val_counter
    end
  end

  def check_1_5
    # Check for values 1 and 5
    @dice_value_arr.cycle(2) do |val| 
      val_counter = @dice_value_arr.count(val)
      val_score = 50
      val_score *= 2 if val == "1"
      if val == "1" || val == "5"
        val_counter.times { 
          @valid_dice_options[:prompt] << val 
          @valid_dice_options[:score] << val_score
          @valid_dice_options[:dice_number] += 1
        }
        val_selection_arr = @dice_set.select{|die| die.value == val}
        for i in 0..val_selection_arr.length-1 do
          @valid_dice_options[:die] << val_selection_arr[i] if val_selection_arr[i].held_status == "free"
        end
        @dice_value_arr.delete(val)
      end
    end
  end

  def set_valid_dice_options
    @free_dice_number = 0
    @dice_set.map{|die| @free_dice_number += 1 if die.held_status == "free" }
    check_straight
    check_set
    check_1_5

    if @valid_dice_options[:dice_number] == @free_dice_number
      @pot_total += @valid_dice_options[:score].inject(0, :+)
    end
  end

  def update_pot(index, amount)
    @pot_total += @valid_dice_options[:score][index] if amount == "held"
    @pot_total -= @valid_dice_options[:score][index] if amount == "free"
  end

  def roll
    @dice_value_arr = @dice_set.map{|die| die.value = rand(1..6).to_s if die.held_status == "free"}
    @dice_value_arr.delete(nil)
    # @dice_value_arr = @dice_set.each_with_index.map{|die,i| die.value = (i+1).to_s }
    # @dice_value_arr = @dice_set.each_with_index.map{|die,i| i < 3 ? die.value = 1.to_s : die.value = 2.to_s }
    @valid_dice_options = { prompt: [], die: [], score: [], dice_number: 0 }
    p @dice_value_arr
    gets
    set_valid_dice_options
    p @valid_dice_options
    gets
  end
end