# stores the map and renders it
class Board
  attr_reader :board_size, :board

  def initialize(args)
    @board_size = args[:map_size] || 5
    @board = create_board(board_size)
  end

  def update
    print_board
  end

  def print_board
    board.each { |row| puts row * '.' }
  end

  def remove_player(player)
    board[player[0]][player[1]] = '_'
  end

  def add_player(player, player_icon)
    board[player[0]][player[1]] = player_icon
  end

  private

  def create_board(board_size)
    Array.new(board_size) { Array.new(board_size, '_') }
  end
end
