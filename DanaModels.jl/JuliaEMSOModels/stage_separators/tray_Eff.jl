module EMLtray_Eff
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/streams.jl")
	using EMLstreams
	using EMLtypes
	require("DanaModels.jl/JuliaEMSOModels/stage_separators/tray.jl")
	using EMLtray
	include("tray_Eff/trayEffEmp.jl")
	include("tray_Eff/trayEffFund.jl")
end