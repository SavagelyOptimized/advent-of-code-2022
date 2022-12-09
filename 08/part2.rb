forest = []
ARGF.each_line do |line|
  forest.push line.chomp.split('').map { |t| t.to_i }
end

height = forest.length
width = forest[0].length

scores = []

(1..height-2).each do |i|
  row = forest[i]

  (1..width-2).each do |j|
    tree_h = forest[i][j]

    left = 1 + (forest[i][0..(j-1)].reverse.find_index { |h| h >= tree_h } || j-1)
    right = 1 + (forest[i][j+1..width-1].find_index { |h| h >= tree_h } || width-1-j-1)
    top = 1 + (forest[0..i-1].map { |row| row[j] }.reverse.find_index { |h| h >= tree_h } || i-1)
    bottom = 1 + (forest[i+1..height-1].map { |row| row[j] }.find_index { |h| h >= tree_h } || height-1-i-1)

    scores.push left * right * top * bottom
  end
end

p scores.max
