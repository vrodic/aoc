# frozen_string_literal: true

def play(sets)
  min_cubes = {
    "red"=> 0,
    "green"=> 0,
    "blue"=> 0
  }

  sets.each do |game|
    cubes = game.split(',')
    cubes.each do |cube|
      nr_color = cube.strip.split(' ')      
      number = nr_color[0].to_i      
      color = nr_color[1]
      
      min_cubes[color] = number if min_cubes[color] < number
    end
  end

  min_cubes.map { |_key, value| value }.reduce{|acc, i| acc*i}
end

sum = 0
File.each_line("input2-1.txt") do |line|
  els = line.split(':')
  sets = els[1].split(';')
  sum += play(sets)
end
puts sum