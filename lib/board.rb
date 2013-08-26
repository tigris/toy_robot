class Board
  # Creates a board object
  #
  # @param [Integer] Maximum number of squares on the X axis
  # @param [Integer] Maximum number of squares on the Y axis
  # @return [Board]
  def initialize x, y
    @max_x   = x
    @max_y   = y
    @objects = []
  end

  # Determine if an object of any kind can be placed at the given coordinates
  #
  # @param [Integer] X coordinate
  # @param [Integer] Y coordinate
  # @return [Boolean]
  def can_place? x, y
    x >= 0 and x < @max_x and y >= 0 and y < @max_y and !object_at?(x, y)
  end

  # Place an object on the board at the given coordinates and remember the state
  #
  # @param [Integer] X coordinate
  # @param [Integer] Y coordinate
  # @return [Boolean]
  def place_object x, y
    if can_place?(x, y)
      @objects << [x, y]
      true
    end
  end

  # Print an ascii map of the current board, 0 for an empty space, X for an
  # object in that space.
  #
  # @return [String]
  def report
    ret = ''
    (0 .. @max_y - 1).to_a.reverse.each do |y|
      (0 .. @max_x - 1).each do |x|
        ret += object_at?(x, y) ? 'X' : '0'
      end
      ret += "\n"
    end
    ret.chomp
  end

  private

  def object_at? x, y
    @objects.any?{|o| o == [x, y] }
  end
end
