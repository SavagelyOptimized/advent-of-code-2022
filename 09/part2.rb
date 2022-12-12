
Point = Struct.new(:x, :y) do
  def to_s
    "#{x},#{y}"
  end

  def +(p)
    Point.new(x+p.x, y+p.y)
  end

  def -(p)
    Point.new(x-p.x, y-p.y)
  end

  def copy
    Point.new(x,y)
  end

  def not_touching?(p)
    diff = self - p
    diff.x.abs > 1 || diff.y.abs > 1
  end

  def unit
    x_sign = x >= 0 ? 1 : -1
    y_sign = y >= 0 ? 1 : -1
    Point.new(x_sign * [x.abs,1].min, y_sign * [y.abs,1].min)
  end
end

num_knots = 10
knots = [Point.new(0,0)] * num_knots
history = []

delta = {
  "L" => Point.new(-1,0),
  "R" => Point.new(1,0),
  "U" => Point.new(0,1),
  "D" => Point.new(0,-1)
}

ARGF.each_line.map { |line| line.chomp.split }
  .map { |move, size_s| [move, size_s.to_i] }
  .each do |move, size|
    (1..size).each do
      knots[0] = knots[0] + delta[move]

      (1..num_knots-1).each do |i|
        diff = knots[i-1] - knots[i]

        if knots[i-1].not_touching? knots[i]
          knots[i] = knots[i] + diff.unit
        end
      end

      history.push knots.last
    end
end

p history.uniq.length
