# responsible for handling movement of the robot
class Robot
  ROBOT_STATE = {
    '1' => '^',
    '2' => '>',
    '3' => 'v',
    '4' => '<'
  }

  def initialise()
    @direction = rand(4)
  end

  def get_direction
    @direction
  end

  def handle_input
    user_input = gets.chomp
    puts 'current position - unkown'
    puts 'current direction: ' + get_direction
    puts 'user enter command: ' + user_input
    puts 'new position - unkown'
    user_input
  end
end

# responsible for the size and limitations of the map
# as well as displaying it to the user with the location
# of the robot
class Board
  def initialize(board_size)
    @player = [rand(board_size), rand(board_size)]
    @board = Array.new(board_size) { Array.new(board_size, '_') }
    puts 'player loc = ' + @player.inspect
  end

  def player_location
    [@player[0]][@player[1]]
  end

  def make_board
    @board[@player[0]][@player[1]] = 'x'
    @board
  end

  def print_board
    make_board.each { |row|
      # row.each { |number| print number.inspect, ' ' } 
      puts row * '.'
    }
  end
end

# responsible for managing the games start and continuous state
class GameHandler
  def begin_game
    game_running = false

    game_board = Board.new(5)
    game_bot = Robot.new

    puts 'q to quit'

      game_board.print_board
    while game_running
      game_board.print_board
      if game_bot.handle_input == 'q' then game_running = false end
    end
  end
end

game = GameHandler.new
game.begin_game
