# used for logging messages
class MsgHandler
  class << self
    def begin
      'begin game'
    end

    def over
      'game over'
    end

    def inputs
      'q to quit'
    end

    def prompt
      'input a command'
    end
  end
end
