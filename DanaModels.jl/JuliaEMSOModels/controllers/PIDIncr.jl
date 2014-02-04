module EMLPIDIncr
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/types.jl")
	using EMLtypes
	include("PIDIncr/MParameters.jl")
	include("PIDIncr/MOptions.jl")
	include("PIDIncr/MPorts.jl")
	include("PIDIncr/MInternal_Variables.jl")
	include("PIDIncr/PIDIncr.jl")
end