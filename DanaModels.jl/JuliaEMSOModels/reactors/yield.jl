module EMLyield
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/reactors/tank_basic.jl")
	using EMLtank_basic
	using EMLstreams
	using EMLtypes
	using EMLvol_tank
	include("yield/yield_vap.jl")
	include("yield/yield_liq.jl")
end