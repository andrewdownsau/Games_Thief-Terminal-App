class Round
  attr_accessor :pot_total, :dice_set

  def initialize
    @pot_total = 0
    @dice_set = DiceSet.new
  end
end