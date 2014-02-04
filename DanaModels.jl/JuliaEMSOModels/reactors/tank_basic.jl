module EMLtank_basic
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/streams.jl")
	using EMLstreams
	using EMLtypes
	require("DanaModels.jl/JuliaEMSOModels/reactors/vol_tank.jl")
	using EMLvol_tank
	include("tank_basic/tank_basic.jl")
	include("tank_basic/tank_vap.jl")
	include("tank_basic/tank_liq.jl")
	include("tank_basic/tank_liqvap.jl")
end