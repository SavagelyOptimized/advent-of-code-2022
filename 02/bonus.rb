rounds = []

symbols = {
  "A" => :rock,
  "B" => :paper,
  "C" => :scissors,
  "X" => :loss,
  "Y" => :draw,
  "Z" => :win
}

ARGF.each_line do |line|
  rounds.push line.split.map { |play| symbols[play] }
end

shape_scores = {:rock => 1, :paper => 2, :scissors => 3}
outcome_scores = {:loss => 0, :draw => 3, :win => 6}

def play_for_result(elf, result)
  wins = {:rock => :scissors, :paper => :rock, :scissors => :paper}

  if result == :draw then
    elf
  elsif result == :loss then
    wins[elf]
  else
    wins.key(elf)
  end
end

score = rounds.map do |elf, result|
  my_play = play_for_result(elf, result)

  shape_scores[my_play] + outcome_scores[result]
end

puts score.reduce(:+)
