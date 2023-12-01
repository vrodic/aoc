def is_digit?(s)
    code = s.ord
    # 48 is ASCII code of 0
    # 57 is ASCII code of 9
    48 <= code && code <= 57
  end

sum = 0
l = 0
File.readlines('input.txt', chomp: true).each do |line|    
    l += 1
    firstDigit = nil
    lastDigit = nil
    ffirst = false
    line.split('').each do |c|         
        if is_digit?(c) 
            if !ffirst 
                firstDigit = c
                ffirst=true
                next
            end
            lastDigit =c
        end    
    end
    lastDigit = firstDigit if !lastDigit 
    puts "#{l} #{firstDigit}-#{lastDigit}"
    
    line_sum = (firstDigit+lastDigit).to_i
    puts line_sum
    sum += line_sum
end
print sum