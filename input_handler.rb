require_relative 'msg_handler'

# handles player controls
class InputHandler
  class << self
    def update
      inputs.chars.map { |keypress| input_handle(keypress) }
    end

    private

    LIST = {
      'f' => { handler: :player, action: :forward, value: 1 },
      'l' => { handler: :player, action: :turn, value: :left },
      'r' => { handler: :player, action: :turn, value: :right },
      'q' => { handler: :game, action: :quit, value: true }
    }.freeze

    def inputs
      MsgHandler.log(msg: 'prompt')
      gets.chomp
    end

    # player.send(input[:action], input[:value])
    def input_handle(keypress)
      # puts keypress.inspect
      # puts LIST[keypress]
      # LIST[keypress] if LIST.keys.include?([keypress])
      # MsgHandler.log(msg: 'invalid_keypress', values: keypress)
      LIST[keypress]
    end
  end
end
