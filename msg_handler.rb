# used for logging messages
class MsgHandler
  class << self
    def log(args)
      if args[:values]
        puts send(
          args[:msg],
          args[:values] || nil
        )
      else
        puts send(args[:msg])
      end
    end

    private

    def begin
      'Welcome!'
    end

    def over
      'game over'
    end

    def inputs
      "controls:\n f: forward \n r: turn right \n l: turn left \n q: to quit \n "
    end

    def prompt
      "\ninput a command"
    end

    def invalid(new_pos)
      'invalid move to: ' + new_pos.inspect.to_s
    end

    def invalid_keypress(keypress)
      keypress + " is not a valid input, please use\n\n" + inputs
    end
  end
end
