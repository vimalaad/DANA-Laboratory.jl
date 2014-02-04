module EMLtray
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/streams.jl")
	using EMLstreams
	using EMLtypes
	include("tray/trayBasic.jl")
	include("tray/tray.jl")
	include("tray/trayReact.jl")
	include("tray/packedStage.jl")
	include("tray/interface.jl")
	include("tray/trayRateBasic.jl")
	include("tray/trayRate.jl")
end