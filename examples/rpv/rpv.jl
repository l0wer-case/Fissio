# -------------------------------
# File: rpv.jl
# Created: 2025-28-12
# -------------------------------

using DataFrames, CSV

include("../../src/utils.jl")
include("../../src/vesselcalc.jl")

using Utils
using vesselCalc

struct Parameters

end

function init()
    args = parse_commandline()
end

init()