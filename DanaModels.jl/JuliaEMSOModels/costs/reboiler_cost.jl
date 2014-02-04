module EMLreboiler_cost
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/stage_separators/reboiler.jl")
	using EMLreboiler
	using EMLstreams
	using EMLtypes
	include("reboiler_cost/reboiler_cost.jl")
end