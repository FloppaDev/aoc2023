
#
# Doesn't work :)
#

input = File.read("input.txt")

has_number = false;
number_start = 0
number_digits = 0
number = 0

numbers = [] of Int32
offsets = [] of Int32
width = 0

i = 0

input.each_line do |line|
    width = line.size

    line.each_codepoint do |char| 
        if char >= 48 && char <= 57
            digit = char - 48

            if has_number
                number_digits += 1
            else
                number_start = i
                has_number = true
                number_digits = 1
            end

            number += digit * (10 ** number_digits)
        else
            if has_number
                numbers.push(number)           
                offsets.push(number_start)           
                has_number = false
                number = 0
            end
        end

        i += 1
    end
end

def check_cell(offset, neighbour, width, input)
    x = neighbour[0]
    y = neighbour[1]

    left = (offset % width == 0) && x == -1
    right = ((offset + 1) % width == 0) && x == 1
    top = (offset < width) && y == 1
    bottom = (offset > (input.size - width)) && y == -1

    if left || right || top || bottom
        return false
    end

    index = offset + x - (y * width)
    cell = input[index]

    cp = cell.ord

    return !((cp >= 48 && cp <= 57) || cell == ".")
end

sum = 0
total = 0
i = 0

neighbours = [
    [-1, 1],
    [0, 1],
    [1, 1],
    [1, 0],
    [1, -1],
    [0, -1],
    [-1, -1],
    [0, -1],
]

while i < numbers.size
    number = numbers[i]
    offset = offsets[i]
    size = "#{number}".size

    s = 0

    while s < size
        symbol = false;
        c = 0

        while c < 8
            neighbour = neighbours[c]

            if check_cell(offset + s, neighbour, width, input)
                sum += number
                symbol = true
                break
            end

            c += 1
        end

        if symbol
            break
        end

        s += 1
    end

    i += 1
end

puts sum
