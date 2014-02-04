module EMLtank_cost
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/stage_separators/tank.jl")
	using EMLtank
	using EMLstreams
	using EMLtypes
	include("tank_cost/tank_cost.jl")
end