
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
        if (pos.x < 0 && pos.y == 0) return 10; end       # west
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

    function rotational_sectors(stars:: Array{StarInfo})

        if stars == []
            return []
        end

        current :: Array{Array{Tuple{Int64,Int64,Int64}}} = []
        next :: Array{StarInfo} = []
        sector :: Array{StarInfo} = []

        sector_id = 0
        last_vec = (0,0)
        for star in stars
            if star.norm == last_vec
                push!(next, star)
            else
                if star.sector != sector_id
#                     sector2 = sort(scaled(sector))
#                     if (sector_id in [5, 6, 7, 8, 9])
#                         sector2 = reverse(sector2)
#                     end
                    sector2 = sort_by_direction(sector_id, sector)
                    push!(current,sector2)
                    sector_id = star.sector
                    sector = []
                end
                push!(sector, star)
                last_vec = star.norm
            end
        end
        vcat(current, rotational_sectors(next))
    end

    function sort_by_direction(sector_id::Int64, sector::Array{StarInfo})
            sector2 = sort(scaled(sector))
            if (sector_id in [5, 6, 7, 8, 9])
                return reverse(sector2)
            end
            return sector2
    end

    function scale(star::StarInfo, xes::Set{Int64})
        ax = abs(star.norm.x)
        y = star.norm.y
        for x in xes
            if ax != x
                y = y * x
            end
        end
        (star.sector, y, star.orig.x * 100 + star.orig.y)
    end

    function scaled(sector::Array{StarInfo})
        xes = Set(map((si::StarInfo) -> abs(si.norm.x), sector))
        stars = map((si::StarInfo) -> scale(si, xes), sector)
        println("Set: ", xes,":", sector, " " ,map((si::StarInfo) -> abs(si.norm.x), sector)," => ", stars)
        stars
    end
end

