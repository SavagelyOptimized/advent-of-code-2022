all = []
current = []

ARGF.each_line do |line|
  unless line.strip.empty? then
    current.push Integer(line)
  end

  if ARGF.eof? or line.strip.empty? then
    all.push current
    current = []
  end
end

totals = all.map { |items| items.reduce(:+) }

puts totals.max(3).reduce(:+)
