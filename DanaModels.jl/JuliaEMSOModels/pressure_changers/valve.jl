module EMLvalve
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/streams.jl")
	using EMLstreams
	using EMLtypes
	include("valve/valve.jl")
	include("valve/valve_simplified.jl")
end