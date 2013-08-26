require 'minitest/autorun'
require 'board'
require 'robot'

class TestRobotLibrary < MiniTest::Unit::TestCase
  def setup
    board  = Board.new 5, 5
    @robot = Robot.new board
  end

  def test_move_before_placement_ignored
    @robot.move
    assert_equal nil, @robot.report
  end

  def test_turn_before_placement_ignored
    @robot.turn :left
    assert_equal nil, @robot.report
  end

  def test_placement
    @robot.place 2, 2, :south
    assert_equal '2,2,SOUTH', @robot.report
  end

  def test_simple_movement
    @robot.place 2, 2, :south
    @robot.turn :left
    @robot.move
    assert_equal '3,2,EAST', @robot.report
  end

  def test_turn_with_string
    @robot.place 2, 2, :south
    @robot.turn 'l'
    assert_equal '2,2,EAST', @robot.report
  end

  def test_multiple_turns
    @robot.place 2, 2, :south
    @robot.turn :left
    @robot.turn :left
    @robot.turn :left
    @robot.move
    assert_equal '1,2,WEST', @robot.report
  end

  def test_move_off_board_south_ignored
    @robot.place 0, 0, :south
    @robot.move
    assert_equal '0,0,SOUTH', @robot.report
  end

  def test_move_off_board_north_ignored
    @robot.place 0, 4, :north
    @robot.move
    assert_equal '0,4,NORTH', @robot.report
  end

  def test_move_off_board_west_ignored
    @robot.place 0, 0, :west
    @robot.move
    assert_equal '0,0,WEST', @robot.report
  end

  def test_move_off_board_east_ignored
    @robot.place 4, 0, :east
    @robot.move
    assert_equal '4,0,EAST', @robot.report
  end

  def test_next_position
    @robot.place 0, 0, :east
    assert_equal [1, 0], @robot.next_position
  end
end
