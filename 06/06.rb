def are_all_unique(chars)
  chars.length == chars.uniq.length
end

MARKER_LENGTH = 4
MESSAGE_LENGTH = 14

def find_signal_in(input, signal_length)
  i = signal_length - 1
  candidate = input[0..i]
  while i < input.length && !are_all_unique(candidate) do
    candidate.shift
    i += 1
    candidate.push input[i]
  end
  puts i+1
end

ARGF.each_line do |line|
  find_signal_in(line.split(''), MESSAGE_LENGTH)
end
