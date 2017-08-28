require_relative 'msg_handler'

#
class Starter
  class << self
    def map_size(input)
      (3..10).cover?(input) ? input : 5
    end

    def chose_starting_location(map_size)
      x = starting_pos('x', map_size)
      y = starting_pos('y', map_size)
      [x, y]
    end

    def starting_pos(axis, map_size)
      valid = false
      input = 0
      while valid == false
        MsgHandler.log(msg: 'begin', values: map_size)
        MsgHandler.log(msg: "#{axis}_input")
        input = gets.chomp.to_i
        (0..map_size - 1).cover?(input) ? valid = true : invalid_message(input)
      end
      input
    end

    private

    def invalid_message(input)
      MsgHandler.log(msg: 'invalid_keypress', values: input)
    end
  end
end
