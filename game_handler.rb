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
    MsgHandler.log(msg: 'begin', values: board.board_size)
    x = starting_pos('x')
    y = starting_pos('y')
    thing = [x,y]
    run_game
  end

  def starting_pos(axis)
    valid = false
    input = 0
    while valid == false
      MsgHandler.log(msg: "#{axis}_input")
      input = gets.chomp
      if ('0'..'9').cover?(input)
        valid = board.movement_valid?(input.to_i) ? true : false
      else
        MsgHandler.log(msg: 'invalid_keypress', values: input)
      end
    end
    input
  end

  def end_game
    @game_running = false
    MsgHandler.log(msg: 'over')
  end

  def run_game
    while game_running
      refresh
      MsgHandler.log(msg: 'inputs')
      board.print_board
      inputs = handle_input
      inputs.each_char { |input| check_input(input) }
    end
  end

  def refresh
    system `echo 'clear'`
  end

  def check_input(input)
    input == 'q' ? end_game : player.move(input)
  end

  def handle_input
    MsgHandler.log(msg: 'prompt')
    gets.chomp
  end
end

GameHandler.new.begin_game
