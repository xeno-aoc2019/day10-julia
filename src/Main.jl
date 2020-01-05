include("Input.jl")
include("BaseFinder.jl")


function main()
    stars = Input.read_stars();
    baseInfo = BaseFinder.find_best_base(stars)
    println(stars)
    println("Base: ", baseInfo.base, " satelites: ", baseInfo.satellite_count)
end

main()

