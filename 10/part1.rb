cycle = 0
total = 1
interesting_total = 0

interesting_cycles = [20, 60, 100, 140, 180, 220]

ARGF.each_line.map { |line| line.chomp.split }
  .each do |command, value|
    if command == "noop"
      cycle += 1
      if interesting_cycles.include? cycle
        interesting_total += total * cycle
      end
    elsif command == "addx"
      cycle += 1

      if interesting_cycles.include? cycle
        interesting_total += total * cycle
      end

      cycle += 1

      if interesting_cycles.include? cycle
        interesting_total += total * cycle
      end

      total += value.to_i
    end
end

p interesting_total
