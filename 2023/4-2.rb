# frozen_string_literal: true

cards = Hash[File.readlines('input4-1.txt').collect do |line|
  card, numbers = line.split(':')
  card_id = card.split(' ')[1]
  winners, picks = numbers.split('|')  
  winners = winners.split(' ')  
  wins = picks.split(' ').count { |pick| winners.include?(pick) }
  [card_id.to_i, { copies: 1, wins: }]
end]

cards.each do |id, card|  
  1.upto(card[:wins]) do |i|
    cc = cards[id + i]
    next if cc.nil?

    cc[:copies] += card[:copies]
  end
end

puts cards.each_value.map{|card| card[:copies]}.sum
