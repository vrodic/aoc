# frozen_string_literal: true

def digit?(char)
  code = char.ord
  # 48 is ASCII code of 0
  # 57 is ASCII code of 9
  code >= 48 && code <= 57
end

def gear?(char)
  char == '*'
end
file_name = "input3-1.txt"
lines = File.open(file_name).each_line.map {|line| line}

def mark_gear_area(lines)
  gear_area = Hash(String, Int32).new

  id = 0
  lines.each_with_index do |line, y|
    line.each_char.with_index do |char, x|
      next unless gear?(char)

      id += 1

      [-1, 0, 1].each do |dx|
        [-1, 0, 1].each { |dy| gear_area["#{x + dx},#{y + dy}"] = id }
      end
    end
  end

  gear_area
end

gear_area = mark_gear_area(lines)
gears = Hash(Int32, Array(Int32)).new

# for some reason lines is empty after first load in crystal
File.open(file_name).each_line.with_index do |line, y|
  number_str = ""
  gear_id = nil

  line.each_char.with_index do |char, x|    
    if digit?(char)
      number_str += char
      if gear_area.has_key?("#{x},#{y}")
        gear_id ||= gear_area["#{x},#{y}"]
      end
    elsif number_str != ""
      if gear_id
        if !gears.has_key?(gear_id)
          gears[gear_id] = Array(Int32).new
        end
        gears[gear_id] << number_str.to_i         
      end      

      number_str = ""
      gear_id = nil
    end
  end

  #crystal does not include the newline character chars of a line
  if number_str != ""
    if gear_id
      if !gears.has_key?(gear_id)
        gears[gear_id] = Array(Int32).new
      end
      gears[gear_id] << number_str.to_i         
    end

    number_str = ""
    gear_id = nil
  end
end

# for large input files, we should make sure the sum counter is 64bit
# it's 32bit by default and crystal overflows it
sum : Int64 = 0

gears.values.each do |values|
  sum += values.reduce{|acc, i| acc*i} if values.size == 2
end
puts sum
