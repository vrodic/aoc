# frozen_string_literal: true

sum = 0

File.readlines('input4-1.txt').each do |line|
  _card, numbers = line.split(':')
  winners, picks = numbers.split('|')
  winners = winners.split(' ')
  card_score = 0
  picks.split(' ').each do |pick|
    next unless winners.include?(pick)

    card_score = if card_score.zero?
                   1
                 else
                   card_score * 2
                 end
  end
  sum += card_score
end

puts sum
