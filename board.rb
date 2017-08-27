require_relative 'msg_handler'

# stores the map and all players on it, calculates moves
class Board
  attr_reader :board_size, :player_class_ref, :board, :player
  attr_writer :player

  def initialize(args)
    args = defaults.merge(args)
    @board_size = args[:board_size]
    @player = args[:player_start] || player_random_start
    @board = create_board(board_size)
    @player_class_ref = args[:player_class_ref] # curious if this can go at some point
  end

  def print_board
    board[player[0]][player[1]] = player_class_ref.direction
    board.each { |row| puts row * '.' }
  end

  def player_move_along(vector)
    # reset board
    board[player[0]][player[1]] = '_' # must be a neater way
    self.player = calc_player_movement(vector) || player
  end

  def calc_player_movement(vector)
    new_pos = player.zip(vector).map { |x| x.reduce(:+) }
    if new_pos.all? { |x| movement_valid?(x) }
      new_pos
    else
      MsgHandler.log(msg: 'invalid', values: new_pos)
      false
    end
  end

  def movement_valid?(value)
    value < 0 || value >= board_size ? false : true
  end

  private

  def defaults
    {
      board_size: 9
    }
  end

  def player_random_start
    [rand(board_size), rand(board_size)]
  end

  def create_board(board_size)
    Array.new(board_size) { Array.new(board_size, '_') }
  end
end
