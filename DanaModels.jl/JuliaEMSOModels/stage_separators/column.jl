module EMLcolumn
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/stage_separators/tray.jl")
	using EMLtray
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
	include("column/Section_Column.jl")
	include("column/Distillation_kettle_cond.jl")
	include("column/Distillation_thermosyphon_subcooling.jl")
	include("column/Distillation_thermosyphon_cond.jl")
	include("column/Distillation_kettle_subcooling.jl")
	include("column/Rectifier.jl")
	include("column/Rectifier_subcooling.jl")
	include("column/Refluxed_Stripping.jl")
	include("column/Refluxed_Stripping_subcooling.jl")
	include("column/Refluxed_Absorption.jl")
	include("column/Refluxed_Absorption_subcooling.jl")
	include("column/Reboiled_Stripping_kettle.jl")
	include("column/Reboiled_Stripping_thermosyphon.jl")
	include("column/Reboiled_Absorption_kettle.jl")
	include("column/Reboiled_Absorption_thermosyphon.jl")
	include("column/ReactiveDistillation.jl")
	include("column/Packed_Section_Column.jl")
	include("column/PackedDistillation_kettle_cond.jl")
end