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

lines = File.readlines('input3-1.txt')

def mark_gear_area(lines)
  gear_area = {}

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
gears = Hash.new { |h, k| h[k] = [] }

lines.each_with_index do |line, y|
  number_str = ''
  x = 0
  gear_id = nil
  line.each_char do |char|
    if digit?(char)
      number_str += char
      gear_id ||= gear_area["#{x},#{y}"]
    elsif number_str != ''
      gears[gear_id] << number_str.to_i if gear_id

      number_str = ''
      gear_id = nil
    end

    x += 1
  end
end

sum = gears.values.map do |values|
  values.reduce(:*) if values.length == 2
end.compact.sum
puts sum
