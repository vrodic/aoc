# frozen_string_literal: true

def play(game)
  min_cubes = Hash(String, Int32).new(0)

  game.split(';').each do |set|
    set.split(',').each do |cube|
      number, color = cube.strip.split(' ')
      min_cubes[color] = [min_cubes[color], number.to_i].max
    end
  end

  min_cubes.values.reduce{|acc, i| acc*i}
end

sum = File.open("input2-1.txt").each_line.map { |line| play(line.split(':').last) }.sum
puts sum
