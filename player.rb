require_relative 'msg_handler'

# handles player actions
class Player
  DIRECTION = {
    0.0  => '>',
    0.5  => 'v',
    1.0  => '<',
    1.5  => '^'
  }.freeze

  attr_reader :rotation_in_radians, :board
  def initialize
    @rotation_in_radians = 0.5 * rand(3)
  end

  def define_board(board)
    @board = board
  end

  def direction
    DIRECTION[@rotation_in_radians]
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
      MsgHandler.log(msg: 'invalid_keypress', values: keypress)
    end
  end

  private

  def move_vector
    vector = [
      turn('sin'),
      turn('cos')
    ]
    @board.player_move_along(vector)
  end

  def turn(msg)
    Math.send(msg, Math::PI * @rotation_in_radians).to_i
  end

  def turn_right
    @rotation_in_radians += 0.5
    @rotation_in_radians = 0.0 if @rotation_in_radians == 2
  end

  def turn_left
    @rotation_in_radians -= 0.5
    @rotation_in_radians = 1.5 if @rotation_in_radians == -0.5
  end
end
