module EMLHairpinIncr
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/streams.jl")
	using EMLstreams
	using EMLtypes
	include("HairpinIncr/Properties_Average.jl")
	include("HairpinIncr/Properties_In_Out.jl")
	include("HairpinIncr/Properties_Wall.jl")
	include("HairpinIncr/Physical_Properties.jl")
	include("HairpinIncr/Details_Main.jl")
	include("HairpinIncr/Hairpin_HeatTransfer.jl")
	include("HairpinIncr/Hairpin_PressureDrop.jl")
	include("HairpinIncr/Main_Hairpin.jl")
	include("HairpinIncr/Results_Hairpin.jl")
	include("HairpinIncr/Summary_Hairpin.jl")
	include("HairpinIncr/HairpinIncr_basic.jl")
	include("HairpinIncr/UpperPipe_basic.jl")
	include("HairpinIncr/LowerPipe_basic.jl")
	include("HairpinIncr/HairpinIncr.jl")
end