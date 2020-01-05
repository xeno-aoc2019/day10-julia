include("Input.jl")
include("BaseFinder.jl")
include("Stars.jl")

function swipe(base, stars)
    sats = Stars.satellite_info(base, stars)
    sats2 = sort(sats, lt=Stars.isless)
    println("Base: ", base)
    println("Stars: ", sats2)
end

function main()
    stars = Input.read_stars();
    baseInfo = BaseFinder.find_best_base(stars)
    println(stars)
    println("Base: ", baseInfo.base, " satelites: ", baseInfo.satellite_count)
    swipe(baseInfo.base, stars);
end

main()

