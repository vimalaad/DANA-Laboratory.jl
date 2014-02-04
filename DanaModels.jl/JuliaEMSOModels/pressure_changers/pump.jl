module EMLpump
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/streams.jl")
	using EMLstreams
	using EMLtypes
	include("pump/centrifugal_pump.jl")
	include("pump/pump.jl")
end