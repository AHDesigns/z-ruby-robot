require_relative 'player'
require_relative 'board'
require_relative 'msg_handler'
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

  def end_game
    @game_running = false
    MsgHandler.log(msg: 'over')
  end

  def run_game
    refresh
    while game_running
      # MsgHandler.storedMsg
      MsgHandler.log(msg: 'inputs')
      player.update
      board.update
      inputs.each_char { |input| player_controls(input) }
      refresh
    end
  end

  def refresh
    system `echo 'clear'`
  end

  def inputs
    MsgHandler.log(msg: 'prompt')
    gets.chomp
  end

  MOVES = {
    # 'q' => send('end_game'),
    'f' => @player.send('move_forward'),
    'l' => @player.send('turn_left'),
    'r' => @player.send('turn_right')
  }.freeze

  def player_controls(keypress)
    MOVES[keypress]
  end

  # def player_controls2(keypress)
  #   case keypress
  #   when 'q'
  #     end_game
  #   when 'f'
  #     player.move_forward
  #   when 'l'
  #     player.turn_left
  #   when 'r'
  #     player.turn_right
  #   else
  #     MsgHandler.log(msg: 'invalid_keypress', values: keypress)
  #   end
  # end
end

GameHandler.new.run_game
