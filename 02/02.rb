rounds = []

symbols = {
  "A" => :rock,
  "B" => :paper,
  "C" => :scissors,
  "X" => :rock,
  "Y" => :paper,
  "Z" => :scissors
}

ARGF.each_line do |line|
  rounds.push line.split.map { |play| symbols[play] }
end

shape_scores = {:rock => 1, :paper => 2, :scissors => 3}
outcome_scores = {:loss => 0, :draw => 3, :win => 6}
wins = {:rock => :scissors, :paper => :rock, :scissors => :paper}

score = rounds.map do |elf, me|
  if elf == me then
    shape_scores[me] + outcome_scores[:draw]
  elsif wins[me] == elf then
    shape_scores[me] + outcome_scores[:win]
  else
    shape_scores[me] + outcome_scores[:loss]
  end
end

puts score.reduce(:+)
