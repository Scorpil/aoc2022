@enum Figure ROCK PAPER SCISSORS
@enum RoundResult WIN LOSE DRAW

decodeFigure = Dict(
    "A" => ROCK::Figure,
    "B" => PAPER::Figure,
    "C" => SCISSORS::Figure,
    "X" => ROCK::Figure,
    "Y" => PAPER::Figure,
    "Z" => SCISSORS::Figure,
)

decodeResult = Dict(
    "X" => LOSE::RoundResult,
    "Y" => DRAW::RoundResult,
    "Z" => WIN::RoundResult,
)

figureScore = Dict(
    ROCK::Figure => 1,
    PAPER::Figure => 2,
    SCISSORS::Figure => 3,
)

roundScore = Dict(
    WIN::RoundResult => 6,
    DRAW::RoundResult => 3,
    LOSE::RoundResult => 0,
)

winFigure = Dict(
    ROCK::Figure => PAPER::Figure,
    PAPER::Figure => SCISSORS::Figure,
    SCISSORS::Figure => ROCK::Figure,
)

loseFigure = Dict(
    ROCK::Figure => SCISSORS::Figure,
    PAPER::Figure => ROCK::Figure,
    SCISSORS::Figure => PAPER::Figure,
)

function getResult(their, my)
    if their == my
        return DRAW::RoundResult
    end

    if (their == winFigure[my])
        return LOSE::RoundResult
    end

    return WIN::RoundResult
end

function getMyFigure(theirFigure, result)
    if result == DRAW::RoundResult
        return theirFigure
    end

    if result == WIN::RoundResult
        return winFigure[theirFigure]
    end

    if result == LOSE::RoundResult
        return loseFigure[theirFigure]
    end
end

function getScore(getRoundScorePart1, getRoundScorePart2)
    total_score_round1 = 0
    total_score_round2 = 0
    while !eof(stdin)
        line = readline(stdin)
        figures = split(strip(line), " ")
        total_score_round1 += getRoundScorePart1(figures)
        total_score_round2 += getRoundScorePart2(figures)
    end

    return total_score_round1, total_score_round2
end

function roundScorePart1(figures)
    theirFigure, myFigure = map(figureAsChar -> decodeFigure[figureAsChar], figures)
    result = getResult(theirFigure, myFigure)
    return roundScore[result] + figureScore[myFigure]
end

function roundScorePart2(figures)
    theirFigureAsChar, resultAsChar = figures
    theirFigure = decodeFigure[theirFigureAsChar]
    result = decodeResult[resultAsChar]

    myFigure = getMyFigure(theirFigure, result)
    return roundScore[result] + figureScore[myFigure]
end

function main()
    total_score_round1, total_score_round2 = getScore(roundScorePart1, roundScorePart2)
    println("Part 1: ", total_score_round1)
    println("Part 2: ", total_score_round2)
end

main()