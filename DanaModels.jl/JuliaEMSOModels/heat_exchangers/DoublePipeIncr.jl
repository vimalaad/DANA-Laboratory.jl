module EMLDoublePipeIncr
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/streams.jl")
	using EMLstreams
	using EMLtypes
	include("DoublePipeIncr/Properties_Average.jl")
	include("DoublePipeIncr/Properties_In_Out.jl")
	include("DoublePipeIncr/Properties_Wall.jl")
	include("DoublePipeIncr/Physical_Properties.jl")
	include("DoublePipeIncr/Details_Main.jl")
	include("DoublePipeIncr/DoublePipe_HeatTransfer.jl")
	include("DoublePipeIncr/DoublePipe_PressureDrop.jl")
	include("DoublePipeIncr/Main_DoublePipe.jl")
	include("DoublePipeIncr/DoublePipeIncr.jl")
end