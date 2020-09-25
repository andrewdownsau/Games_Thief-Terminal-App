
class Game
  attr_reader :playernumber, :players


  def initialize(playernumber, players)
    @playernumber = playernumber
    @players = players
  end

  def self.user_setting_number
    system("clear")
    playernumber = 0 # to ensure that number is only valid from user input
    loop do
      puts "Please input the number of players (type a '3', '4', '5' or '6')"
      print "Number of players: "
      input = gets.chomp
      playernumber = input.to_i if input.length == 1
      if playernumber.between?(3, 6)
        puts "New game will have #{playernumber} players"
        break
      else
        system("clear")
        puts "Invalid input entered."
      end
    end
    playernumber
  end

  def self.game_user_setting_names(playernumber)
    system("clear")
    players = []
    index = 0
    while index < playernumber
      puts "\nPlayer list:"
      player_num = 0
      while player_num < players.length
        puts "#{players[player_num]}"
        player_num += 1
      end
      puts "\nPlease input name of player #{index+1}."
      puts "Player name must be between 3-15 characters long."
      puts "Player names cannot be repeated."
      print "\nPlayer #{index+1}: "
      input = gets.chomp
      if input.length.between?(3, 15) && players.include?(input) == false
        puts "Are you happy with the name #{input}?"
        print "(y/n): "
        confirm = gets.chomp
        system("clear")
        if confirm == 'y'
          puts "Welcome #{input}!"
          players << input
          index += 1
        else
          puts "Please re-enter name."
        end
      else
        system("clear")
        puts "Invalid input entered."
      end
    end
    players
  end

  def self.create_new_game
    playernumber = user_setting_number
    players = game_user_setting_names(playernumber)
    puts "Thanks for entering all that info :)"
    # PROMPT.select("Is everyone ready to get this game started?") do |menu|
    #   menu.choice({ name: 'Start New Game', value: '1' })
    #   menu.choice({ name: 'Reset Settings', value: '2' })
    #   menu.choice({ name: 'Exit to Menu', value: '3' })
    # end
  end

end