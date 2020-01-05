
module Stars
    include("Input.jl")
   #  include("BaseFinder.jl")

    struct StarInfo
        sector :: Int64
        rel :: Main.Stars.Input.Pos
        norm :: Main.Stars.Input.Pos
        orig :: Main.Stars.Input.Pos
    end

    function isless(si1::StarInfo, si2::StarInfo)
        if si1.sector != si2.sector
            return si1.sector < si2.sector
        end
        if si1.norm.x != si2.norm.x
            return si1.norm.x < si2.norm.x
        end
        if si1.norm.y != si2.norm.y
            return si1.norm.y < si2.norm.y
        end
        if si1.rel.x != si2.rel.x
            return si1.rel.x < si2.rel.x
        end
        if si1.rel.y != si2.rel.y
            return si1.rel.y < si2.rel.y
        end
        if si1.orig.x != si2.orig.x
            return si1.orig.x < si2.orig.x
        end
        if si1.orig.y != si2.orig.y
            return si1.orig.y < si2.orig.y
        end
        return false
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