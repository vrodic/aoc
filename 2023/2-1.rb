# frozen_string_literal: true

available_cubes = { 'red' => 12, 'green' => 13, 'blue' => 14 }

def play(game, available_cubes)
  game.split(';').all? do |set|
    set.split(',').all? do |cube|
      number, color = cube.strip.split
      number.to_i <= available_cubes[color]
    end
  end
end

sum = File.open('input2-1.txt').each_line.map do |line|
  id, game = line.split(':')
  id.sub('Game ', '').to_i if play(game, available_cubes)
end.compact.sum

puts sum
