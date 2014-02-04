module EMLPIDs
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/types.jl")
	using EMLtypes
	include("PIDs/MParameters.jl")
	include("PIDs/MOptions.jl")
	include("PIDs/MPorts.jl")
	include("PIDs/MInternal_Variables.jl")
	include("PIDs/PID.jl")
end