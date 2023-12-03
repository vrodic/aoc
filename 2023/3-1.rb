# frozen_string_literal: true

def digit?(char)
  code = char.ord
  # 48 is ASCII code of 0
  # 57 is ASCII code of 9
  code >= 48 && code <= 57
end

def symbol?(char)
  !digit?(char) && char != '.' && char != "\n"
end

lines = File.readlines('input3-1.txt')

def mark_symbol_area(lines)
  symbol_area = {}

  lines.each_with_index do |line, x|
    puts line
    y = 0
    line.each_char do |char|
      if symbol?(char)
        symbol_area["#{x - 1},#{y}"] = true
        symbol_area["#{x - 1},#{y - 1}"] = true
        symbol_area["#{x - 1},#{y + 1}"] = true

        symbol_area["#{x},#{y - 1}"] = true
        symbol_area["#{x},#{y + 1}"] = true

        symbol_area["#{x + 1},#{y}"] = true
        symbol_area["#{x + 1},#{y - 1}"] = true
        symbol_area["#{x + 1},#{y + 1}"] = true
      end      

      y += 1
    end
  end

  symbol_area
end


sum = 0
symbol_area = mark_symbol_area(lines)
lines.each_with_index do |line, x|
  # puts line
  number_str = ''
  y = 0
  number_close = false
  line.each_char do |char|
    if digit?(char)
      number_str += char
      number_close = true if !number_close && symbol_area["#{x},#{y}"]
    elsif number_str != ''
      sum += number_str.to_i if number_close

      puts number_str if number_close
      number_str = ''
      number_close = false
      # puts number_str
    end
    # puts "#{x}-#{y}"

    y += 1
  end
  puts "-----"
end

puts sum
