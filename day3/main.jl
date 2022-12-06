function score(char)
    if islowercase(char)
        return Int(char) - 96
    else    
        return Int(char) - 64 + 26
    end
end

function find_common(a, b, c = nothing)
    # Find a single common elements between a, b and c (optional)
    for el_a in a
        for el_b in b
            if el_a == el_b
                if c === nothing
                    return el_a
                else
                    for el_c in c
                        if el_a == el_c
                            return el_a
                        end
                    end
                end
            end
        end
    end
    return nothing
end

function solve_part1(lines)
    total = 0
    for line in lines
        mid_index = length(line) ÷ 2

        first_half = line[1:mid_index]
        second_half = line[mid_index+1:end]
        common = find_common(first_half, second_half)
        total += score(common)
    end
    return total
end

function solve_part2(lines)
    total = 0
    for group in eachcol(reshape(lines, (3, length(lines) ÷ 3)))
        common = find_common(group[1], group[2], group[3])
        total += score(common)
    end
    return total
end

function main()
    lines = []
    while !eof(stdin)
        line = strip(readline(stdin))
        push!(lines, line)
    end

    println("Part 1: ", solve_part1(lines))
    println("Part 2: ", solve_part2(lines))
end

main()