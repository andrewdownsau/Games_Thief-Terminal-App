# files
require_relative 'player'
require_relative 'round'
require_relative 'die'

class Game
  attr_accessor :number_of_players, :players, :active_player, :active_round, :active_player_index

  def initialize
    @players = []
    @number_of_players = 0
    @active_player = nil
    @active_player_index = 0
    @active_round
  end
  
  def randomize_players
    @players = @players.shuffle
  end

  def set_player(player_name)
    @players << Player.new(player_name)
  end

  def start_round
    @active_player_index += 1
    if @active_player == nil || @active_player_index == @number_of_players
      @active_player_index = 0 
    end
    @active_player = @players[@active_player_index]
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
    when "free_dice_length"
      @active_round.free_dice_set.length
    when "free_die_value"
      @active_round.free_dice_set.map{|die| die.value}[index] + " "
    when "held_die_value"
      @active_round.held_dice_set.map{|die| die.value}[index] + " "
    when "valid_dice_values"
      @active_round.valid_dice_set
    when "valid_dice_number"
      @active_round.valid_dice_number
    when "dice_value_scores"
      @active_round.dice_value_scores
    end
  end

  def set_game_value(value, amount, index)
    case value
    when "valid_dice_number"
      @active_round.valid_dice_number = amount
    when "hold_dice"
      @active_round.held_dice_set << @active_round.free_dice_set[index]
      p @active_round.held_dice_set
      gets
      @active_round.free_dice_set.delete_at(index)
    end
  end

  def game_method(method)
    case method
    when "roll"
      @active_round.roll
    end
  end
end