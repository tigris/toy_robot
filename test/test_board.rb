require 'minitest/autorun'
require 'board'

class TestBoard < MiniTest::Unit::TestCase
  def test_can_place
    board = Board.new 1, 1
    assert !board.can_place?(0, 1)
    assert !board.can_place?(1, 0)
    assert board.can_place?(0, 0)
  end

  def test_place_object
    board = Board.new 2, 2
    assert board.place_object(0, 0)
    assert !board.place_object(2, 0)
  end

  def test_cant_place_where_object_exists
    board = Board.new 2, 2
    board.place_object 1, 0
    assert !board.can_place?(1, 0)
    assert board.can_place?(0, 1)
    assert board.can_place?(0, 0)
    assert board.can_place?(1, 1)
  end

  def test_report_no_objects
    board = Board.new 2, 2
    assert_equal "00\n00", board.report
  end

  def test_report_with_objects
    board = Board.new 3, 3
    board.place_object 0, 0
    board.place_object 1, 1
    assert_equal "000\n0X0\nX00", board.report
  end
end
