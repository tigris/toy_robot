class ToyRobot
  # Directions can simply be an array where turning left/right is the same as
  # going down/up the array index.
  DIRECTIONS = %w(north east south west).freeze

  # Places the robot at the given X/Y location, facing in the given direction.
  #
  # @param [Integer] X coordinate for robot, [0-4]
  # @param [Integer] Y coordinate for robot, [0-4]
  # @param [String,Symbol] Direction robot is facing, `'north', `:east`, `'SOUTH'` or `:west`
  # @return [String] Current status of robot.
  def place x, y, f
    if valid_position?(x, y) and valid_direction?(f)
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
      when direction.to_s.match(/^l(?:eft)$/i);  -1
      when direction.to_s.match(/^r(?:ight)$/i); +1
      else;                                      nil
    end
    # The modulus is to make sure we stay within the 0-4 array boundary
    @f = (@f + direction) % DIRECTIONS.size if direction
    report
  end

  # Advances the robot 1 place in the direction it is facing.
  #
  # @return [String] Current status of robot.
  def move
    return unless placed?
    axis = case direction
      when 'east', 'west';   :x
      when 'north', 'south'; :y
    end
    amount = case direction
      when 'north', 'east'; +1
      when 'south', 'west'; -1
    end
    # We know place() will already ignore invalid placements
    place(@x + (axis == :x ? amount : 0), @y + (axis == :y ? amount : 0), direction)
  end

  # Reports the current location of the robot.
  #
  # @return [String] The location in X,Y,DIRECTION notation.
  def report
    return nil unless placed?
    [ @x, @y, direction.upcase ].join(',')
  end

private
  def direction
    DIRECTIONS[@f]
  end

  def placed?
    @x && @y && @f
  end

  def valid_position? x, y
    x >= 0 and x <= 4 and y >= 0 and y <= 4
  end

  def valid_direction? f
    DIRECTIONS.include?(f.to_s.downcase)
  end
end
