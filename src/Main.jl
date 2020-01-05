struct Pos
    x :: Int64
    y :: Int64
end

struct StarInfo
    rel :: Pos
    norm :: Pos
    orig :: Pos
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

function directions_around(base :: Pos, all_stars :: Array{Pos})
    satellites = Pos[]
    for star in all_stars
        if star != base
            dir = Pos(star.x - base.x, base.y - star.y)
            fact = gcd(dir.x, dir.y)
            norm_dir = Pos(dir.x / fact, dir.y / fact)
            push!(satellites, norm_dir)
        end
    end
    Set(satellites)
end

function find_best_base()
    stars = read_stars();
    count = 0;
    base = Pos(0,0);
    for star in stars
        surroundings = directions_around(star,stars)
        if length(surroundings) > count
            count = length(surroundings)
            base = star
        end
    end
    println(stars)
    println("Base: ", base, " satelites: ", count)
end

find_best_base()

