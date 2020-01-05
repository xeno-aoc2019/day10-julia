struct Pos
    x :: Int64
    y :: Int64
end


function read_stars()
    stars = Pos[];
    open("input.txt") do input
        y = 0
        for s in eachline(input)
            x = 0
            for c in s
                if c == '#'
                    star = Pos(x,y)
                    push!(stars, star)
                    # println(star)
                end
                x = x + 1
            end
            y = y + 1
        end
    end
    stars
end

stars = read_stars()
println(stars)