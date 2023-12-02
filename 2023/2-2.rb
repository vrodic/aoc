# frozen_string_literal: true

def play(sets)
  min_cubes = Hash.new(0)

  sets.each do |set|    
    set.split(',').each do |cube|      
      number, color = cube.split(' ')      
      min_cubes[color] = [min_cubes[color], number.to_i].max
    end
  end

  min_cubes.values.reduce(:*)
end

sum = File.readlines('input2-1.txt', chomp: true).map do |line|
  play(line.split(':').last.split(';'))
end.sum
puts sum
