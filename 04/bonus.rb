ranges = ARGF.each_line
  .map { |str| str.split(',') }
  .map { |a, b|
    a_start, a_end = a.split('-').map { |x| Integer(x) }
    b_start, b_end = b.split('-').map { |x| Integer(x) }

    [Range.new(a_start, a_end), Range.new(b_start, b_end)]
  }

disjoint = ranges.select do |a, b|
  b.last < a.first || b.first > a.last
end

p ranges.length - disjoint.length
