# -------------------------------
# File: coolantcalc.jl
# Created: 2025-12-18 
# -------------------------------

module CoolantCalc

	include("utils.jl")
	using .Utils

	function quality_index(specific_heat_capacity::Real, density::Real, viscosity::Real)
		if(specific_heat_capacity <= 0 || density <= 0 || viscosity <= 0)
			parameter_error()
		else
			return (specific_heat_capacity^2.8 * density^2)/(viscosity^0.2)
		end
	end

end
