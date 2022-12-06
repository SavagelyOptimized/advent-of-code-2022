stacks = {}

ARGF.each_line do |line|
  if /[\[\]]/ =~ line then
    (1..line.length-1).step(4) do |i|
      unless line[i] == ' ' then
        if stacks[i/4].nil? then
          stacks[i/4] = []
        end
        (stacks[i/4]).unshift(line[i])
      end
    end
  elsif /move (?<quantity>\d+) from (?<source>\d+) to (?<dest>\d+)/ =~ line then
    quantity = Integer($~[:quantity])
    source = Integer($~[:source])-1
    dest = Integer($~[:dest])-1

    crates = stacks[source].pop(quantity)
    stacks[dest].push *crates
  end
end

top_crates = (0..stacks.keys.length-1).map { |i| stacks[i].last }.join('')
p top_crates
