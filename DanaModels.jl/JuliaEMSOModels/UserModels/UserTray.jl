module EMLUserTray
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/streams.jl")
	using EMLstreams
	using EMLtypes
	include("UserTray/User_trayBasic.jl")
	include("UserTray/User_tray.jl")
end