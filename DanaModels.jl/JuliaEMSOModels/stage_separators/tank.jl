module EMLtank
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/streams.jl")
	using EMLstreams
	using EMLtypes
	include("tank/tank.jl")
	include("tank/tank_cylindrical.jl")
	include("tank/tank_simplified.jl")
	include("tank/tank_feed.jl")
end