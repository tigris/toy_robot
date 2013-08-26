require 'minitest/autorun'
require 'board'

class TestBoard < MiniTest::Unit::TestCase
  def test_can_place
    board = Board.new 1, 1
    assert !board.can_place?(0, 1)
    assert !board.can_place?(1, 0)
    assert board.can_place?(0, 0)
  end
end
