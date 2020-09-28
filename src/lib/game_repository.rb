class GameRepository
  
  def initialize
    @games = []
  end

  def start_new_game
    system("clear")
    # game_setter_instance = GameSetter.new
    # game_players = game_setter_instance.settings_user_input
    game_players = ["Tom", "Dick", "Harry"]
    new_game = Game.new(game_players) if game_players
    game_board = GameBoard.new(new_game)

    game_board.main_game_loop

    # puts "Thanks for entering all that info :)"
    # pp game_players
    # gets.chomp
  end

end