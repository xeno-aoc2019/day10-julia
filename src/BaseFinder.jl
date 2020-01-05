
module BaseFinder
    include("Input.jl")

    struct BaseInfo
        base :: Main.Input.Pos
        satellite_count :: Int64
    end

    function directions_around(base :: Main.Input.Pos, all_stars :: Array{Main.Input.Pos})
        satellites = Main.Input.Pos[]
        for star in all_stars
            if star != base
                dir = Main.Input.Pos(star.x - base.x, base.y - star.y)
                fact = gcd(dir.x, dir.y)
                norm_dir = Main.Input.Pos(dir.x / fact, dir.y / fact)
                push!(satellites, norm_dir)
            end
        end
        Set(satellites)
    end

    function find_best_base(stars)
        count = 0;
        base = Main.Input.Pos(0,0);
        for star in stars
            surroundings = directions_around(star,stars)
            if length(surroundings) > count
                count = length(surroundings)
                base = star
            end
        end
        BaseInfo(base, count)
    end

end