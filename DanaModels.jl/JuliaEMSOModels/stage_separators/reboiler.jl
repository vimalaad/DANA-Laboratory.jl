module EMLreboiler
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/streams.jl")
	using EMLstreams
	using EMLtypes
	include("reboiler/reboiler.jl")
	include("reboiler/reboilerSteady.jl")
	include("reboiler/reboilerSteady_fakeH.jl")
	include("reboiler/reboilerReact.jl")
end