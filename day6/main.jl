function solve(line, len)
    for (i, c) in enumerate(line)
        if i < len
            continue
        end
        chunk = Set(line[i-(len-1):i])
        if length(chunk) == len
            return i
            break
        end
    end
end

function main()
    line = readline(stdin)
    println("Part 1: ", solve(line, 4))
    println("Part 2: ", solve(line, 14))
end

main()