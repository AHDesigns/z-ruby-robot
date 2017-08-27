require_relative 'player'
require_relative 'board'
require_relative 'msg_handler'

# responsible for managing the game state
class GameHandler
  attr_reader :game_running, :player, :board
  def initialize
    @game_running = true
    @player = Player.new
    @board = Board.new(player_class_ref: player)
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
