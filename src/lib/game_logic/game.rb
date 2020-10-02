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
    when "free_dice_number"
      @active_round.dice_set.count(:held_status == "free")
      @output_string = 0
      @active_round.dice_set.map{|die| @output_string += 1 if die.held_status == "free" }
    end
    @output_string
  end

  def get_game_array(arr)
    case arr
    when "valid_dice_options_prompts"
      @active_round.valid_dice_options[:prompt]
    end
  end

  def set_game_value(value, amount, index)
    case value
    when "hold_free_dice"
      prompt_selction = @active_round.valid_dice_options[:die][index]
      @active_round.dice_set.map do |die|
        if prompt_selction.kind_of?(Array)
          for i in 0..prompt_selction.length do
            if die == prompt_selction[i]
              die.held_status = amount
            end
          end
        end
        if die == prompt_selction
          die.held_status = amount
          break
        end
      end
      @active_round.update_pot(index, amount)
      # puts @active_round.valid_dice_options
      # gets
    when "free_all_dice"
      @active_round.dice_set.map do |die|
        die.held_status = "free"
      end
    end
  end

  def game_method(method)
    case method
    when "roll"
      @active_round.roll
    end
  end
end