module EMLHeatExchangerSimplified_cost
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/heat_exchangers/Heatex.jl")
	using EMLHeatex
	using EMLHEX_Engine
	using EMLstreams
	using EMLtypes
	include("HeatExchangerSimplified_cost/HeatExchanger_LMTD_cost.jl")
	include("HeatExchangerSimplified_cost/Shell_and_tubes_LMTD_cost.jl")
	include("HeatExchangerSimplified_cost/HeatExchanger_NTU_cost.jl")
	include("HeatExchangerSimplified_cost/Shell_and_tubes_NTU_cost.jl")
end