module EMLHeatExchangerDetailed
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/heat_exchangers/HEX_Engine.jl")
	using EMLHEX_Engine
	using EMLstreams
	using EMLtypes
	include("HeatExchangerDetailed/ShellandTubesBasic.jl")
	include("HeatExchangerDetailed/ShellandTubes_NTU.jl")
	include("HeatExchangerDetailed/ShellandTubes_LMTD.jl")
end