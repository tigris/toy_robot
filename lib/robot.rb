class Robot
  # Directions can simply be an array where turning left/right is the same as
  # going down/up the array index.
  DIRECTIONS = %w(north east south west).freeze

  # Creates a new robot
  #
  # @param [Board] The board this robot will be placed on
  # @return [Robot]
  def initialize board
    @board = board
  end

  # Places the robot at the given X/Y location, facing in the given direction.
  #
  # @param [Integer] X coordinate for robot, [0-4]
  # @param [Integer] Y coordinate for robot, [0-4]
  # @param [String,Symbol] Direction robot is facing, `'north', `:east`, `'SOUTH'` or `:west`
  # @return [String] Current status of robot.
  def place x, y, f
    if @board.can_place?(x, y) and valid_direction?(f)
      @x = x
      @y = y
      @f = DIRECTIONS.index(f.to_s.downcase)
    end
    report
  end

  # Turns the robot 90 degress in the given direction.
  #
  # @param [String,Symbol] Direction to turn, `:left` or `'RIGHT'`
  # @return [String] Current status of robot.
  def turn direction
    return unless placed?
    direction = case
      when direction.to_s.match(/^l(?:eft)?$/i);  -1
      when direction.to_s.match(/^r(?:ight)?$/i); +1
      else;                                       nil
    end
    # The modulus is to make sure we stay within the 0-4 array boundary
    @f = (@f + direction) % DIRECTIONS.size if direction
    report
  end

  # Based on current robot position/direction, what would be the coordinates
  # for the next position if we were to move()
  #
  # @return [Array<Integer>] The x and y coordinates
  def next_position
    return unless placed?
    axis = case direction
      when 'east', 'west';   :x
      when 'north', 'south'; :y
    end
    amount = case direction
      when 'north', 'east'; +1
      when 'south', 'west'; -1
    end
    [@x + (axis == :x ? amount : 0), @y + (axis == :y ? amount : 0)]
  end

  # Advances the robot 1 place in the direction it is facing.
  #
  # @return [String] Current status of robot.
  def move
    return unless placed?
    # We know place() will already ignore invalid placements, so just advance
    # the robot and let it fail silently if those positions are not on the board
    place(*next_position, direction)
  end

  # Reports the current location of the robot.
  #
  # @return [String] The location in X,Y,DIRECTION notation.
  def report
    return nil unless placed?
    [ @x, @y, direction.upcase ].join(',')
  end

  # Place an object directly in front of the robots current position on the
  # board
  #
  # @return [Boolean]
  def place_object
    @board.place_object *next_position
  end

  # Print a map of the current robot on it's board, with objects marked as an
  # X, empty spaces as a 0 and the robot marked as an R.
  #
  # @return [String]
  def map
    lines = @board.report.split("\n")
    lines[lines.size - 1 - @y][@x] = 'R'
    lines.join("\n")
  end

private
  def direction
    DIRECTIONS[@f]
  end

  def placed?
    @x && @y && @f
  end

  def valid_direction? f
    DIRECTIONS.include?(f.to_s.downcase)
  end
end
