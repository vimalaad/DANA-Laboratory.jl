module EMLPHE
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/heat_exchangers/HEX_Engine.jl")
	using EMLHEX_Engine
	using EMLstreams
	using EMLtypes
	include("PHE/PHE_PressureDrop.jl")
	include("PHE/PHE_HeatTransfer.jl")
	include("PHE/Main_PHE.jl")
	include("PHE/Thermal_PHE.jl")
	include("PHE/PHE_Geometry.jl")
	include("PHE/PHE.jl")
end