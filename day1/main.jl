function getSums()
    sums = []
    sum = 0
    while !eof(stdin)
        line = readline(stdin)
        
        if line != ""
            sum += parse(Int64, line)
        end

        if line == "" || eof(stdin)
            push!(sums, sum)
            sum = 0
        end
    end
    sort!(sums, rev=true)
    return sums
end

function main()
    sums = getSums()
    println("Part 1: ", sums[1])
    println("Part 2: ", sums[1] + sums[2] + sums[3])
end

main()