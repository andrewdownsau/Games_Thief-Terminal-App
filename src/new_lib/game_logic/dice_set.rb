class DiceSet
  def initialize
    @dice_set = []
    @free_dice = 5
  end

  def roll(number_of_dice)
    for i in 1..number_of_dice do
      @dice_set << Die.new(rand(1..6))
    end
  end
end