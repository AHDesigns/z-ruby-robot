# stores the map and all players on it, calculates moves
class Board
  attr_reader :board_size, :player, :player_info

  def initialize(args)
    args = defaults.merge(args)
    @board_size = args[:board_size]
    @player = args[:player_start]
    @board = create_board(board_size)
    @player_info = args[:player_class_ref]
  end

  def defaults
    {
      board_size: 5,
      player_start: [rand(board_size), rand(board_size)]
    }
  end

  def create_board(board_size)
    Array.new(board_size) { Array.new(board_size, '_') }
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
