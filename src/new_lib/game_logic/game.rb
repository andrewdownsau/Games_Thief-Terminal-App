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
    @output_string = ""
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
    @output_string = ""
    case value
    when "player_name"
      @output_string = @players.map{|player| player.name}[index]
    when "player_score"
      @output_string = @players.map{|player| player.score}[index]
    when "pot"
      @output_string = @active_round.pot_total
    when "dice_set_free"
      @active_round.dice_set.map{|die| @output_string << die.value + " " if die.held_status == "free" }
    when "dice_set_held"
      @active_round.dice_set.map{|die| @output_string << die.value + " " if die.held_status == "held" }
    when "valid_dice_options_dice_number"
      @output_string = @active_round.valid_dice_options[:dice_number]
    when "valid_dice_options"
      @active_round.valid_dice_options

    # when "valid_dice_values"
    #   @active_round.valid_dice_set
    # when "valid_dice_number"
    #   @active_round.valid_dice_number
    # when "dice_value_scores"
    #   @active_round.dice_value_scores
    end
    @output_string
  end

  # def set_game_value(value, amount, index)
  #   case value
  #   when "valid_dice_number"
  #     @active_round.valid_dice_number = amount
  #   when "hold_dice"
  #     @active_round.held_dice_set << @active_round.free_dice_set[index]
  #     p @active_round.held_dice_set
  #     gets
  #     @active_round.free_dice_set.delete_at(index)
  #   end
  # end

  # def set_game_value(value, amount, index)
  #   case value
  #   when "valid_dice_number"
  #     @active_round.valid_dice_number = amount
  #   when "hold_dice"
  #     @active_round.held_dice_set << @active_round.free_dice_set[index]
  #     p @active_round.held_dice_set
  #     gets
  #     @active_round.free_dice_set.delete_at(index)
  #   end
  # end

  def game_method(method)
    case method
    when "roll"
      @active_round.roll
    end
  end
end