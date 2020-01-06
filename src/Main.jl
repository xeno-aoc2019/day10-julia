include("Input.jl")
include("BaseFinder.jl")
include("Stars.jl")

function swipe(base, stars)
    sats = Stars.satellite_info(base, stars)
    sats2 = sort(sats, lt = Stars.isless)
    println("Base: ", base)
    println("Stars: ", sats2)
    s1 = Stars.rotational_sectors(sats2)
    println("Grouped: ", s1)
    s2 = collect(Iterators.flatten(s1))
    println("Grouped2: ", s2)
    println("Answer: ", s2[200])

end

function main()
    stars = Input.read_stars();
    baseInfo = BaseFinder.find_best_base(stars)
    println(stars)
    println("Base: ", baseInfo.base, " satelites: ", baseInfo.satellite_count)
    swipe(baseInfo.base, stars);
end

main()

