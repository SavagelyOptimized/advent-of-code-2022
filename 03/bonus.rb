groups = []
current_group = []

ARGF.each_line.map do |line|
  current_group.push(line.scan(/\w/))

  if ARGF.lineno % 3 == 0 or ARGF.eof? then
    groups.push(current_group)
    current_group = []
  end
end

def priority(item)
  if /[A-Z]/.match(item) then
    item.ord - 'A'.ord + 27
  else
    item.ord - 'a'.ord + 1
  end
end

badges = groups.map do |group|
  group[0].find { |c| group[1].include?(c) && group[2].include?(c) }
end

priorities = badges.map { |b| priority(b) }

puts priorities.reduce(:+)
