# files
require_relative 'player'
require_relative 'round'
require_relative 'die'

class Game
  attr_accessor :number_of_players, :players, :active_player, :active_round

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

  def start_round
    @active_round = Round.new
  end

  def get_game_value(value, index)
    case value
    when "player_name"
      @players.map{|player| player.name}[index]
    when "player_score"
      @players.map{|player| player.score}[index]
    when "pot"
      @active_round.pot_total
    when "die_value"
      @active_round.free_dice_set.map{|die| die.value}[index] + " "
    end
  end

  def game_method(method)
    case method
    when "roll"
      @active_round.roll
    end
  end
end