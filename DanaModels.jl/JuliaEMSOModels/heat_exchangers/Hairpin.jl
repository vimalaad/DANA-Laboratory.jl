module EMLHairpin
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/heat_exchangers/HEX_Engine.jl")
	using EMLHEX_Engine
	using EMLstreams
	using EMLtypes
	include("Hairpin/Hairpin_Basic.jl")
	include("Hairpin/Hairpin_NTU.jl")
	include("Hairpin/Hairpin_LMTD.jl")
end