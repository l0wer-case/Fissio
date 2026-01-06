# -------------------------------
# File: utils.jl
# Created: 2025-11-16
# -------------------------------

module Utils

	using ArgParse

	export DEFAULT_OUTPUT, parse_commandline
	export parameter_error
	export nthroot

	const DEFAULT_OUTPUT = "./output"

	function parse_commandline()
    	s = ArgParseSettings()

    	@add_arg_table! s begin

        	"--output", "-o"
            	help = "Set the path for saving the calculation results"
            	arg_type = String
            	default = DEFAULT_OUTPUT
        
        	"--realtime-output", "-r"
            	help = "Display program execution results in the command line in real time"
            	action = :store_true 
            
        	"--build-plot", "-g"
            	help = "Render plot using Matplotlib (may not be available in some programs)"
            	action = :store_true
    	end

    	return parse_args(s)
	end

	parameter_error() = throw(ArgumentError("Parameters are within an unacceptable range"))
    
    function nthroot(x::Real, n::Integer)
    	if x >= 0
        	return x^(1/n)
    	else
        	if iseven(n)
            	throw(DomainError(x, "The even root of a negative number is undefined in real numbers"))
        	else
            	return -abs(x)^(1/n)
        	end
    	end
	end
	
end
