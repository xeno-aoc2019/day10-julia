
module Stars
    include("Input.jl")
   #  include("BaseFinder.jl")

    struct StarInfo
        sector :: Int64
        rel :: Main.Stars.Input.Pos
        norm :: Main.Stars.Input.Pos
        orig :: Main.Stars.Input.Pos
    end

    function satellite_info(base, stars)
        sats = StarInfo[]
        for star in stars
            if base != star
                rel = Main.Stars.Input.Pos(star.x - base.x, base.y - star.y)
                scale = gcd(rel.x,rel.y)
                norm = Main.Stars.Input.Pos(rel.x / scale, rel.y / scale)
                id = sector_id(norm)
                info = StarInfo(id, rel, norm, Main.Stars.Input.Pos(star.x, star.y))
                push!(sats, info)
            end
        end
        sats
    end

    function sector_id(pos::Main.Stars.Input.Pos)
        if (pos.x == 0 && pos.y == 0) return 0; end      # center
        if (pos.x == 0 && pos.y > 0) return 1; end       # north
        if (pos.x == 0 && pos.y < 0) return 7; end       # south
        if (pos.x > 0 && pos.y == 0) return 4; end       # east
        if (pos.x > 0 && pos.y > pos.x) return 2; end    # nne
        if (pos.x > 0 && pos.y > 0) return 3; end        # nee
        if (pos.x > 0 && pos.y < -pos.x) return 6; end   # sse
        if (pos.x > 0 && pos.y < 0) return 5; end        # see
        if (pos.x < 0 && pos.y < pos.x) return 8; end    # ssw
        if (pos.x < 0 && pos.y < 0) return 9; end        # sww
        if (pos.x < 0 && pos.y > -pos.x) return 12; end; # nnw
        if (pos.x < 0 && pos.y > 0) return 11; end;      # nww
        return 99; # ERROR, should not occur
    end

end