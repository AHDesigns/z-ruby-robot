require_relative 'msg_handler'

#
class Starter
  attr_reader :game_setup, :map_size
  def initialize
    @game_setup = false
    @map_size = 5
  end

  def update
    game_setup || chose_starting_location
  end

  def chose_starting_location
    MsgHandler.log(msg: 'begin', values: map_size)
    x = starting_pos('x')
    y = starting_pos('y')
    @game_setup = true
    [x, y]
  end

  def starting_pos(axis)
    valid = false
    input = 0
    while valid == false
      MsgHandler.log(msg: "#{axis}_input")
      input = gets.chomp
      valid = validation(meth: 'valid_number', input: input) && validation(meth: 'validate_start_location', input: input.to_i)
    end
    input
  end

  def validation(args)
    if send(args[:meth], args[:input])
      true
    else
      invalid_message(args[:input])
      false
    end
  end

  def valid_number(input)
    ('0'..'9').cover?(input)
  end

  def validate_start_location(value)
    value < 0 || value >= map_size ? false : true
  end

  def invalid_message(input)
    MsgHandler.log(msg: 'invalid_keypress', values: input)
  end
end
