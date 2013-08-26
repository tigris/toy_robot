class Board
  # Creates a board object
  #
  # @param [Integer] Maximum number of squares on the X axis
  # @param [Integer] Maximum number of squares on the Y axis
  # @return [Board]
  def initialize x, y
    @max_x = x
    @max_y = y
  end

  # Determine if an object of any kind can be placed at the given coordinates
  #
  # @param [Integer] X coordinate
  # @param [Integer] Y coordinate
  # @return [Boolean]
  def can_place? x, y
    x >= 0 and x < @max_x and y >= 0 and y < @max_y
  end
end
