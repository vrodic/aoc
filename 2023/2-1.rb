availiable_cubes = {
    "red": 12,
    "green": 13,
    "blue": 14
}

def play(sets, availiable_cubes)
    min_cubes = {
        "red": 0,
        "green": 0,
        "blue": 0
    }
    
    sets.each do |game|
        cubes = game.split(",")
        cubes.each do |cube|
            nr_color = cube.split(" ")
            number = nr_color[0].to_i
            color = nr_color[1].to_sym            
            
            if number > availiable_cubes[color]
                return false
            end
        end
    end
    
    true
end
sum = 0
File.readlines("input2-1.txt", chomp: true).each do |line|
    els = line.split(":")
    id = els[0].sub("Game ", "").to_i
    sets = els[1].split(";")
    sum += id.to_i if play(sets, availiable_cubes)         
end
puts sum