def are_all_unique(chars)
  chars.length == chars.uniq.length
end

def find_marker_in(input)
  i = 3
  candidate = input[0..i]
  while i < input.length && !are_all_unique(candidate) do
    candidate.shift
    i += 1
    candidate.push input[i]
  end
  puts i+1
end

ARGF.each_line do |line|
  find_marker_in line.split('')
end
