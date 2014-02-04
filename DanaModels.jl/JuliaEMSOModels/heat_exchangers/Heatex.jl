module EMLHeatex
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/heat_exchangers/HEX_Engine.jl")
	using EMLHEX_Engine
	using EMLstreams
	using EMLtypes
	include("Heatex/Heatex_Basic.jl")
	include("Heatex/Heatex_LMTD.jl")
	include("Heatex/Heatex_NTU.jl")
end