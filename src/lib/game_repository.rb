class GameRepository
  
  def initialize
    @games = []
  end

  def create_new_game
    system("clear")
    game_setter_instance = GameSetter.new
    game_setter_instance.settings_user_input

    # @games << Game.new(
    #   @games.length + 1,
    #   game_player_number,
    #   game_players
    # )
    # puts "Thanks for entering all that info :)"
  end

end