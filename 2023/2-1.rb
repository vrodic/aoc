# frozen_string_literal: true

availiable_cubes = {
  "red": 12,
  "green": 13,
  "blue": 14
}

def play(sets, availiable_cubes)
  sets.each do |game|
    cubes = game.split(',')
    cubes.each do |cube|
      number, color = cube.strip.split(' ')

      return false if number.to_i > availiable_cubes[color.to_sym]
    end
  end

  true
end

sum = 0
File.readlines('input2-1.txt', chomp: true).each do |line|
  els = line.split(':')
  id = els[0].sub('Game ', '').to_i
  sets = els[1].split(';')
  sum += id if play(sets, availiable_cubes)
end
puts sum
