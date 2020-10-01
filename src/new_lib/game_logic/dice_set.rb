class DiceSet
  attr_reader :free_dice_set
  def initialize
    @free_dice_set = []
    5.times {@free_dice_set << Die.new}
    @held_dice_set = []
  end

  def roll
    @free_dice_set.map{|die| die.value = rand(1..6).to_s}
  end
end