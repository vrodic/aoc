# frozen_string_literal: true

def play(sets)
  min_cubes = Hash(String, Int32).new(0)

  sets.each do |set|    
    set.split(',').each do |cube|      
      number, color = cube.strip.split(' ')      
      min_cubes[color] = [min_cubes[color], number.to_i].max
    end
  end

  min_cubes.values.reduce{|acc, i| acc*i}
end

sum = 0
File.each_line("input2-1.txt") do |line|
  sum += play(line.split(':').last.split(';'))
end
puts sum
