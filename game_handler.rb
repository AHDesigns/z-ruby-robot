require_relative 'player'
require_relative 'board'
require_relative 'msg_handler'
require_relative 'input_handler'
require_relative 'starter'

# responsible for managing the game state
class GameHandler
  attr_reader :game_running, :player, :board, :starter
  def initialize
    @game_running = true
    map_size = Starter.map_size(5)
    player_start = Starter.chose_starting_location(map_size)
    @board = Board.new(map_size: map_size)
    @player = Player.new(
      position: player_start,
      map_size: map_size,
      board: board
    )
  end

  def run_game
    refresh
    while game_running
      MsgHandler.log(msg: 'inputs')
      player.update
      board.update
      InputHandler.update.each { |c| player_input(c) }
      # refresh # add this later
    end
  end

  private

  def player_input(args)
    puts player.inspect
    obj = args[:handler]
    action = args[:action]
    value = args[:value]
    puts Kernel.const_get(obj).inspect
    Kernel.const_get(obj).send(action, value)
  end

  def refresh
    system `echo 'clear'`
  end

  def quit
    @game_running = false
    MsgHandler.log(msg: 'over')
  end

end

GameHandler.new.run_game
