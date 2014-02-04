module EMLflash_cost
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/stage_separators/flash.jl")
	using EMLflash
	using EMLstreams
	using EMLtypes
	include("flash_cost/flash_cost.jl")
end