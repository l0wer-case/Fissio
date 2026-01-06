# -------------------------------
# File: qualityindex.jl
# Created: 2025-27-12
# -------------------------------

using DataFrames, CSV 

include("../../src/utils.jl")
include("../../src/coolantcalc.jl")

using .Utils
using .CoolantCalc

struct Parameters

end

function init()
    args = parse_commandline()
    
end

init()