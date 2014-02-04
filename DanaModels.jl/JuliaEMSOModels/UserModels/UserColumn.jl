module EMLUserColumn
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/UserModels/UserTray.jl")
	using EMLUserTray
	using EMLstreams
	using EMLtypes
	require("DanaModels.jl/JuliaEMSOModels/stage_separators/reboiler.jl")
	using EMLreboiler
	require("DanaModels.jl/JuliaEMSOModels/stage_separators/condenser.jl")
	using EMLcondenser
	require("DanaModels.jl/JuliaEMSOModels/mixers_splitters/splitter.jl")
	using EMLsplitter
	require("DanaModels.jl/JuliaEMSOModels/stage_separators/tank.jl")
	using EMLtank
	require("DanaModels.jl/JuliaEMSOModels/pressure_changers/pump.jl")
	using EMLpump
	include("UserColumn/User_Section_ColumnBasic.jl")
	include("UserColumn/User_Section_Column.jl")
	include("UserColumn/User_Distillation_kettle_cond.jl")
	include("UserColumn/User_Distillation_thermosyphon_subcooling.jl")
	include("UserColumn/User_Distillation_thermosyphon_cond.jl")
end