# files
require_relative 'player'

class Game
  attr_accessor :number_of_players, :players, :active_player

  def initialize
    @players = []
    @number_of_players = 0
    @active_player
    @active_round
  end
  
  def randomize_players
    @players = @players.shuffle
    @active_player = @players.first
  end

  def set_player(player_name)
    @players << Player.new(player_name)
  end
end