module EMLstoic
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/reactors/tank_basic.jl")
	using EMLtank_basic
	using EMLstreams
	using EMLtypes
	using EMLvol_tank
	include("stoic/stoic_vap.jl")
	include("stoic/stoic_liq.jl")
	include("stoic/stoic_extent_vap.jl")
	include("stoic/stoic_extent_liq.jl")
	include("stoic/stoic_conv_vap.jl")
	include("stoic/stoic_conv_liq.jl")
end