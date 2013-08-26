class Board
  def initialize x, y
    @max_x = x
    @max_y = y
  end

  def can_place? x, y
    x >= 0 and x < @max_x and y >= 0 and y < @max_y
  end
end
