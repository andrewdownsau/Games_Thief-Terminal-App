class Game
  attr_reader :id, :players, :active_player, :scores, :pot, :last_roll_values, :rollable_dice, :game_choices_log

  def initialize(players)
    @id = 1 #Change later when I can save games
    @players = players.shuffle
    @active_player = @players.first
    @scores = {}
    @players.each do |player|
      @scores[player] = 0
    end
    @pot = 0
    @last_roll_values = Array.new(5, [nil, false])
    @rollable_dice = 5;
    @game_choices_log = [[@active_player, "new_turn"]]
  end
end