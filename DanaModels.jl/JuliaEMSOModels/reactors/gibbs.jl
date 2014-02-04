module EMLgibbs
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/reactors/tank_basic.jl")
	using EMLtank_basic
	using EMLstreams
	using EMLtypes
	using EMLvol_tank
	include("gibbs/gibbs_vap.jl")
	include("gibbs/gibbs_liq.jl")
end