# frozen_string_literal: true

def digit?(char)
  code = char.ord
  # 48 is ASCII code of 0
  # 57 is ASCII code of 9
  code >= 48 && code <= 57
end

numbers = {
  "one": 1,
  "two": 2,
  "three": 3,
  "four": 4,
  "five": 5,
  "six": 6,
  "seven": 7,
  "eight": 8,
  "nine": 9
}

def replace_with_numbers(line, numbers)
  i = 0
  while i < line.size - 1
    numbers.each_key do |word|
      word_str = word.to_s
      if line[i..].start_with?(word_str)
        line = line.sub(word_str, numbers[word].to_s)
        next
      end
    end

    i += 1
  end

  line
end

sum = 0
l = 0

File.readlines("input1-1.txt", chomp: true).each do |line|
  line = replace_with_numbers(line, numbers)
  puts line

  first_digit = nil
  last_digit = nil

  line.each_char do |c|
    next unless digit?(c)

    unless first_digit
      first_digit = c
      next
    end
    last_digit = c
  end
  last_digit ||= first_digit

  l += 1
  puts "#{l} #{first_digit}-#{last_digit}"

  line_sum = (first_digit.to_s + last_digit.to_s).to_i
  puts line_sum
  sum += line_sum
end
puts sum
