module EMLDoublePipe
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/heat_exchangers/HEX_Engine.jl")
	using EMLHEX_Engine
	using EMLstreams
	using EMLtypes
	include("DoublePipe/DoublePipe_Geometry.jl")
	include("DoublePipe/DoublePipe_Basic.jl")
	include("DoublePipe/DoublePipe_NTU.jl")
	include("DoublePipe/DoublePipe_LMTD.jl")
end