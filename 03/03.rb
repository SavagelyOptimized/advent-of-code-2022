packs = ARGF.each_line.map do |line|
  half_length = line.length / 2
  [line[0, half_length].scan(/\w/),
   line[half_length, line.length].scan(/\w/)]
end

priorities = packs.map do |left, right|
  item = left.find { |c| right.include? c }
  if /[A-Z]/.match(item) then
    item.ord - 'A'.ord + 27
  else
    item.ord - 'a'.ord + 1
  end
end

puts priorities.reduce(:+)
