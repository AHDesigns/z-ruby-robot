require_relative 'player'
require_relative 'board'
require_relative 'msg_handler'
require_relative 'starter'
# require_relative 'input_handler'

# responsible for managing the game state
class GameHandler
  attr_reader :game_running, :player, :board, :starter
  def initialize
    @game_running = true
    @starter = Starter.new
    @player = Player.new
    @board = Board.new(player_class_ref: player)
    @player.define_board(@board)
  end

  def end_game
    @game_running = false
    MsgHandler.log(msg: 'over')
  end

  def run_game
    persist_msg = ''
    while game_running
      starter.update
      MsgHandler.log(msg: 'inputs')
      board.update
      puts persist_msg
      inputs = handle_input
      inputs.each_char { |input| check_input(input) }
      refresh
    end

    end_game
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

GameHandler.new.run_game
