function torange(s)
    return map(x -> parse(Int, x), split(s, '-'))
end

function rangein(smaller, larger)
    return larger[1] <= smaller[1] && larger[2] >= smaller[2]
end

function overlap(first, second)
    return first[1] <= second[1] <= first[2]
end

function solve(ranges, selector)
    count = 0
    for (first, second) in ranges
        if selector(first, second) || selector(second, first)
            count += 1
        end
    end
    return count
end

function main()
    ranges = []
    while !eof(stdin)
        line = split(strip(readline(stdin)), ',')
        push!(ranges, map(torange, line))
    end

    println("Part1: ", solve(ranges, rangein))
    println("Part2: ", solve(ranges, overlap))
end

main()