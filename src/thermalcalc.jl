# -------------------------------
# File: thermalcalc.jl
# Project: Reactor Sandbox
# Created: 2025-11-19
# Version: 5
# -------------------------------

module ThermalCalc 

	include("utils.jl")
	using .Utils

	export STEFAN_BOLTZMANN, SOLAR_FLUX_CONST
	export stefan_boltzmann, view_factor_calc, equilibrium_temperature

	"""
	Stefan–Boltzmann constant (W / (m^2 * K^4))
	"""
	const STEFAN_BOLTZMANN = 5.670374419e-8

	"""
	Solar flux power constant (W/m^2)
	"""
	const SOLAR_FLUX_CONST = 1400.0

	"""
	"""
	function stefan_boltzmann(area::Real, emissivity::Real, temperature_init::Real)
    	if(area <= 0 || emissivity <= 0)
			parameter_error() 
        else 
    		return area * emissivity * STEFAN_BOLTZMANN * temperature_init^4
		end
    end

	"""
	"""
	function view_factor_calc(area::Real, external_flux_fraction::Real)
    	if(area <= 0 || external_flux_fraction <= 0)
            parameter_error()
        else 
    		return area * external_flux_fraction
        end
	end

	"""
	"""
	function equilibrium_temperature(use_view_factor_calc::Bool, external_flux_absorption::Real, emissivity::Real, external_flux_power::Real, view_factor::Real, area::Real, external_flux_fraction::Real)
		if use_view_factor_calc
            if(area <= 0 || external_flux_absorption <= 0 || emissivity <= 0 || external_flux_power < 0 || external_flux_fraction <= 0)
				parameter_error()
            else 
				view_factor_fn = view_factor_calc(area, external_flux_fraction)
				return Utils.nthroot(((external_flux_absorption / emissivity) * (external_flux_power / STEFAN_BOLTZMANN) * (view_factor_fn / area)), 4)
            end
		else
            if(external_flux_absorption <= 0 || emissivity <= 0 || external_flux_power <= 0 || view_factor <= 0 || area <= 0)
				parameter_error()
            else 
				return Utils.nthroot(((external_flux_absorption / emissivity) * (external_flux_power / STEFAN_BOLTZMANN) * (view_factor / area)), 4)
            end
		end
	end

	function fuel_rod_temperature_difference(thermal_flux::Real, radius::Real, thermal_conduction_coefficient::Real)
		if(thermal_flux <= 0 || radius <= 0 || thermal_conduction_coefficient <= 0)
			parameter_error()
        else
            return (thermal_flux * radius^2) / (4 * thermal_conduction_coefficient) 
        end
    end

end
