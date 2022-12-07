function move3000!(boxes, count, from, to)
    for i in 1:count
        pushfirst!(boxes[to], popfirst!(boxes[from]))
    end
end

function move3001!(boxes, count, from, to)
    chunk = boxes[from][1:count]
    boxes[from] = boxes[from][count+1:end]
    boxes[to] = vcat(chunk, boxes[to])
end

function solve(move, boxes, commands)
    for (count, from, to) in commands
        move(boxes, count, from, to)
    end

    len = length(boxes)
    result = []
    for i in 1:len
        push!(result, boxes[i][1])
    end
    return join(result)
end

function main()
    boxes = Dict()
    line = nothing
    while line != ""
        line = readline(stdin)
        target = nothing
        for (i, c) in enumerate(line)
            index = i - 1
            if c == '['
                target = index ÷ 4 + 1
            elseif c == ']'
                target = nothing
            elseif c != ' ' && target !== nothing
                push!(get!(boxes, target, []), c)
            end
        end
    end

    command_regex = r"^move (?<count>[0-9]+) from (?<from>[0-9]+) to (?<to>[0-9]+)$"
    commands = []
    while !eof(stdin)
        line = readline(stdin)
        matched = match(command_regex, line)
        count = parse(Int, matched[:count])
        from = parse(Int, matched[:from])
        to = parse(Int, matched[:to])
        push!(commands, (count, from, to))
    end

    println("Part 1: ", solve(move3000!, deepcopy(boxes), commands))
    println("Part 2: ", solve(move3001!, deepcopy(boxes), commands))
end

main()