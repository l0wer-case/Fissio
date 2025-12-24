# -------------------------------
# File: stefanboltzmann.jl
# Project: Reactor Sandbox
# Created: 2025-12-18
# -------------------------------

ENV["JULIA_PYTHONCALL_EXE"] = "/usr/bin/python3"

using PythonCall, ArgParse, CSV, DataFrames

include("../../src/utils.jl")
include("../../src/thermalcalc.jl")

using .Utils
using .ThermalCalc

mutable struct Parameters
	area::Real
    emissivity::Real
    temperature_init::Real
end

function build_plot(df::DataFrame)
	plt = pyimport("matplotlib.pyplot")
    
    fig, ax = plt.subplots()
    
    ax.plot(df.K, df.W, marker="o", ls="-", ms=5, color="tab:red", label="Power (W)")
    
    ax.set_yscale("log")
    
    ax.set_title("Stefan-Boltzmann Law (Log Scale)")
    ax.set_xlabel("Temperature (K)")
    ax.set_ylabel("Power (W) - Log Scale")
    ax.grid(true, which="both", ls="--")
    ax.legend()


    plt.tight_layout()
    
    plt.show()
end

function init()

    args = parse_commandline()
    
    results = DataFrame(K = Int[], W = Float64[])
    
	data = Parameters(2, 0.9, 250)

    for t in 250:50:800
		data.temperature_init = t
        power = stefan_boltzmann(data.area, data.emissivity, data.temperature_init)
		push!(results, (K = data.temperature_init, W = power))

        if args["realtime-output"]
			println(">>> T = $t K | Power = $(round(power, digits=2)) W")
        end
    end

    output_path = args["output"]
    CSV.write(output_path, results)
    println("Results saved to $output_path")

	if args["build-graph"]
        build_plot(results)
    end
    
end

init()
