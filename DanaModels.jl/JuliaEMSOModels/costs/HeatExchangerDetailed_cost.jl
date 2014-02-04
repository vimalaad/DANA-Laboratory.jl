module EMLHeatExchangerDetailed_cost
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/heat_exchangers/HeatExchangerDetailed.jl")
	using EMLHeatExchangerDetailed
	using EMLHEX_Engine
	using EMLstreams
	using EMLtypes
	include("HeatExchangerDetailed_cost/ShellandTubes_NTU_cost.jl")
	include("HeatExchangerDetailed_cost/ShellandTubes_LMTD_cost.jl")
end