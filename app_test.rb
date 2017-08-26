require 'minitest/autorun'
require_relative 'app.rb'

# Game Handler tests
class GameHandlerTest < Minitest::Test
  def setup
    @obj = GameHandler.new
  end

  def test_begin_game_is_called
    assert_equal true, @obj.begin_game
  end
end
