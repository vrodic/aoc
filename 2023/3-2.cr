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

lines = File.open("input3-1.txt").each_line.map {|line| line}

def mark_gear_area(lines)
  gear_area = Hash(String, Int32).new

  id = 0
  lines.each_with_index do |line, y|
    x = 0
    
    line.each_char do |char|
      if gear?(char)
        id += 1

        gear_area["#{x - 1},#{y}"] = id
        gear_area["#{x - 1},#{y - 1}"] = id
        gear_area["#{x - 1},#{y + 1}"] = id

        gear_area["#{x},#{y - 1}"] = id
        gear_area["#{x},#{y + 1}"] = id

        gear_area["#{x + 1},#{y}"] = id
        gear_area["#{x + 1},#{y - 1}"] = id
        gear_area["#{x + 1},#{y + 1}"] = id
      end

      x += 1
    end
  end

  gear_area
end

gear_area = mark_gear_area(lines)
gears = Hash(Int32, Array(Int32)).new

# for some reason lines is empty after first load in crystal
lines = File.open("input3-1.txt").each_line.map {|line| line}

lines.each_with_index do |line, y|
  number_str = ""
  x = 0
  gear_id = nil

  line.each_char do |char|    
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

    x += 1
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

sum = gears.values.map do |values|
  values.reduce{|acc, i| acc*i} if values.size == 2
end.compact.sum
puts sum
