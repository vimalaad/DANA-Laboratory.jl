module EMLequil
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/reactors/tank_basic.jl")
	using EMLtank_basic
	using EMLstreams
	using EMLtypes
	using EMLvol_tank
	include("equil/equil_vap.jl")
	include("equil/equil_liq.jl")
end