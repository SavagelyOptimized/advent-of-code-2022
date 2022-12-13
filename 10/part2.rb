cycle = 0
x = 1
sprite = (x-1..x+1)

screen = (1..6).map { ["."] * 40 }

def print_screen(rows)
  puts rows.map { |r| r.join('') }
end

ARGF.each_line.map { |line| line.chomp.split }
  .each do |command, value|
    if command == "noop"
      cycle += 1

      row = cycle / 40
      col = (cycle % 40) - 1

      if sprite.include? col
        screen[row][col] = "#"
      end
    elsif command == "addx"
      (1..2).each do
        row = cycle / 40
        col = cycle % 40

        if sprite.include? col
          screen[row][col] = "#"
        end

        cycle += 1
      end

      x += value.to_i
      sprite = (x-1..x+1)
    end
end

print_screen screen
