# handles player actions
class Robot
  DIRECTION = {
    0.0  => '>',
    0.5  => 'v',
    1.0  => '<',
    1.5  => '^'
  }.freeze

  attr_reader :degrees, :board
  def initialize
    @degrees = 0.5 * rand(3)
  end

  def define_board(board)
    @board = board
  end

  def direction
    DIRECTION[@degrees]
  end

  def move(keypress)
    case keypress
    when 'f'
      move_vector
    when 'l'
      turn_left
    when 'r'
      turn_right
    else
      'invalid move'
    end
  end

  private

  def move_vector
    vector = [
      Math.sin(Math::PI * @degrees).round(1),
      Math.cos(Math::PI * @degrees).round(1)
    ]
    @board.player_move_along(vector)
  end

  def turn_right
    @degrees += 0.5
    @degrees = 0 if @degrees == 2
  end

  def turn_left
    @degrees -= 0.5
    @degrees = 1.5 if @degrees == -0.5
  end
end

# stores the map and all players on it, calculates moves
class Board
  attr_reader :player_info, :board_size
  def initialize(board_size, player_info)
    @board_size = board_size
    @player = [rand(board_size), rand(board_size)]
    @board = Array.new(board_size) { Array.new(board_size, '_') }
    @player_info = player_info
  end

  def make_board
    @board[@player[0]][@player[1]] = player_info.direction
    @board
  end

  def print_board
    make_board.each { |row| puts row * '.' }
  end

  def player_move_along(vector)
    # reset board
    ignore = false
    @board[@player[0]][@player[1]] = '_'
    @player[0] += vector[0]
    @player[1] += vector[1]
    @player[0] > (@board_size -1) && ignore = true
    @player[1] > (@board_size -1) && ignore = true
    @player[0] < 0 && ignore = true
    @player[1] < 0 && ignore = true
    if ignore == true
      puts '                  invalid move'
      @player[0] -= vector[0]
      @player[1] -= vector[1]
    end
  end
end

# piss off
class MsgHandler
  class << self
    def begin
      'begin game'
    end

    def over
      'game over'
    end

    def inputs
      'q to quit'
    end

    def prompt
      'input a command'
    end
  end
end

# responsible for managing the game state
class GameHandler
  attr_reader :game_running, :player, :board
  def initialize
    @game_running = true
    @player = Robot.new
    @board = Board.new(5, player)
    @player.define_board(@board)
  end

  def begin_game
    puts MsgHandler.begin
    puts MsgHandler.inputs
    run_game
    puts MsgHandler.over
  end

  def run_game
    while game_running
      board.print_board
      inputs = handle_input
      inputs.each_char { |input| check_input(input) }
    end
  end

  def check_input(input)
    if input == 'q'
      @game_running = false
    else
      player.move(input)
    end
  end

  def handle_input
    puts MsgHandler.prompt
    gets.chomp
  end
end

GameHandler.new.begin_game
