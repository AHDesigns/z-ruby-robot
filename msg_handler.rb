# used for logging messages
class MsgHandler
  class << self
    def log(args)
      if args[:values]
        puts send(
          args[:msg],
          args[:values]
        )
      else
        puts MSG[args[:msg]]
      end
    end

    private

    MSG = {
      'x_input' => 'X position',
      'y_input' => 'Y position:',
      'over' => 'game over',
      'prompt' => "\ninput a command",
      'inputs' => "controls:\n f: forward \n r: turn right \n l: turn left \n q: to quit \n "
    }.freeze

    def begin(board_size)
      "Welcome!
      \nBoard defaulted to size #{board_size}
      \nPlease chose player start between 0 and #{board_size}"
    end

    def invalid(new_pos)
      "invalid move to: #{new_pos.inspect}"
    end

    def invalid_keypress(keypress)
      "#{keypress} is not a valid input\n\n"
    end
  end
end
