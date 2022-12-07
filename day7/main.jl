mutable struct DirInfo
    filesize::Int
    subdirs::Vector{String}
end

const Tree = Dict{String, DirInfo}

function newtree()
    tree::Tree = Dict{String, DirInfo}()
    tree["/"] = DirInfo(0, [])
    return tree
end

function push_file!(tree::Tree, current_dir::Vector{String}, filesize::Int)
    current_dir = copy(current_dir)
    while true
        path = current_path(current_dir)
        tree[path].filesize += filesize
        if isempty(current_dir)
            break
        else
            pop!(current_dir)
        end
    end
end

function push_dir!(tree::Tree, current_dir::Vector{String}, subdir::String)
    path = current_path(current_dir)
    new_dir = current_path(vcat(current_dir, [subdir]))
    tree[new_dir] = DirInfo(0, [])
    push!(tree[path].subdirs, subdir)
end

function current_path(current_dir)
    return string("/", join(current_dir, "/"))
end

function buildtree()
    tree = newtree()
    current_dir::Vector{String} = []

    command_regex = r"^\$ (?<cd>cd) (?<target>[a-zA-Z/\.]+)|(?<ls>ls)"
    for line in eachline(stdin)
        line = strip(line)
        if line[1] == '$'
            matched = match(command_regex, line)
            if matched[:cd] == "cd"
                if matched[:target] == "/"
                    current_dir = []
                elseif matched[:target] == ".."
                    pop!(current_dir)
                else
                    push!(current_dir, matched[:target])
                end
            end 
        else
            if string(line[1:3]) == "dir"
                push_dir!(tree, current_dir, string(line[5:end]))
            else
                push_file!(tree, current_dir, parse(Int, split(line, ' ')[1]))
            end
        end
    end

    return tree
end

function part1(tree)
    sizes = 0
    threshold = 100000
    for (_, info) in tree
        if info.filesize > threshold
            continue
        end
        sizes += info.filesize
    end
    return sizes
end

function part2(tree)
    total_disc_space = 70000000
    disc_space_target = 30000000
    disc_space_taken = tree["/"].filesize
    disc_space_available = total_disc_space - disc_space_taken
    disc_space_deficit = disc_space_target - disc_space_available

    for size in (map(v -> v.filesize, values(tree)) |> sort)
        if size >= disc_space_deficit
            return size
        end
    end
end

function main()
    tree = buildtree()
    println("Part 1: ", part1(tree))
    println("Part 2: ", part2(tree))
end

main()