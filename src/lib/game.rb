class Game
  attr_reader :id, :players, :active_player, :scores, :pot, :last_roll_values, :game_choices_log

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
    @game_choices_log = [[]]
  end
end