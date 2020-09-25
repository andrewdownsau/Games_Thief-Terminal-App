class GameBoard
  def initialize(game)
    @game = game
  end

  def scoreboard
    print "Scoreboard: "
    @game.players.each do |player|
      print "#{player}: #{@game.scores[player]} "
    end
  end

  def main_game_loop
    loop do
      scoreboard
      gets.chomp
    end
  end

end