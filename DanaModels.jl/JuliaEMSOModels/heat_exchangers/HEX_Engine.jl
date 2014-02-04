module EMLHEX_Engine
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/streams.jl")
	using EMLstreams
	using EMLtypes
	include("HEX_Engine/Properties_Average.jl")
	include("HEX_Engine/Properties_In_Out.jl")
	include("HEX_Engine/Properties_Wall.jl")
	include("HEX_Engine/Physical_Properties.jl")
	include("HEX_Engine/Physical_Properties_Heatex.jl")
	include("HEX_Engine/Tube_Pdrop.jl")
	include("HEX_Engine/Tube_Heat_Transfer.jl")
	include("HEX_Engine/Shell_Pdrop.jl")
	include("HEX_Engine/Shell_Heat_Transfer.jl")
	include("HEX_Engine/Baffles_Main.jl")
	include("HEX_Engine/Clearances_Main.jl")
	include("HEX_Engine/NTU_Basic.jl")
	include("HEX_Engine/LMTD_Basic.jl")
	include("HEX_Engine/Details_Main.jl")
	include("HEX_Engine/Tube_Side_Main.jl")
	include("HEX_Engine/Shell_Side_Main.jl")
	include("HEX_Engine/DoublePipe_HeatTransfer.jl")
	include("HEX_Engine/DoublePipe_PressureDrop.jl")
	include("HEX_Engine/Main_DoublePipe.jl")
end