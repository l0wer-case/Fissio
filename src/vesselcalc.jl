# -------------------------------
# File: vessel.jl
# Project: Reactor Sandbox
# Created: 2025-10-19
# -------------------------------

module VesselCalc 

	include("utils.jl")
	using .Utils

	"""
	"""
	function spherical_part_volume(height::Real, radius::Real)
    	if(height <=0 || radius <= 0)
			parameter_error()
        else 
    		return ((pi * height) / 6) * (3 * radius^2 + height^2 )
    	end
    end

	"""
	"""
	function cylinder_part_volume(height::Real, radius::Real)
    	if(height <= 0 || radius <= 0)
			parameter_error()
        else 
    		diameter = radius * 2
        	return ((pi * diameter^2) / 4) * height
        end
    end

	"""
	"""
	function spherical_part_thickness(pressure::Real, safety_coefficient::Real, radius::Real, weld_strength_coefficient::Real, material_strength::Real)
    	if(pressure <= 0 || safety_coefficient <= 0 || radius <= 0 || weld_strength_coefficient <= 0 || material_strength <= 0)
			parameter_error()
        else 
    		return (pressure * safety_coefficient * radius) / (2 * weld_strength_coefficient * material_strength)
    	end
    end

	"""
	"""
	function cylinder_part_thickness(pressure::Real, safety_coefficient::Real, radius::Real, weld_strength_coefficient::Real, material_strength::Real)
    	if(pressure <= 0 || safety_coefficient <= 0 || radius <= 0 || weld_strength_coefficient <= 0 || material_strength <= 0)
			parameter_error()
    	else 
			return (pressure * safety_coefficient * radius) / (material_strength * weld_strength_coefficient)
    	end
	end

end
