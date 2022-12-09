forest = []
ARGF.each_line do |line|
  forest.push line.chomp.split('').map { |t| t.to_i }
end

height = forest.length
width = forest[0].length

num_visible = 2 * height + 2 * width - 4

(1..height-2).each do |i|
  row = forest[i]

  (1..width-2).each do |j|
    tree_h = forest[i][j]

    left = forest[i][0..j-1].all? { |h| h < tree_h }
    right = forest[i][j+1..width-1].all? { |h| h < tree_h }
    top = forest[0..i-1].map { |row| row[j] }.all? { |h| h < tree_h }
    bottom = forest[i+1..height-1].map { |row| row[j] }.all? { |h| h < tree_h }

    if left || right || top || bottom
      num_visible += 1
    end
  end
end

p num_visible
