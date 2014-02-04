module EMLvol_tank
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/types.jl")
	using EMLtypes
	include("vol_tank/vol_tank.jl")
end