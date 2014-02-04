module EMLcolumn_cost
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/stage_separators/column.jl")
	using EMLcolumn
	using EMLsplitter
	using EMLtank
	using EMLpump
	using EMLcondenser
	using EMLstreams
	using EMLtypes
	using EMLtray
	using EMLreboiler
	include("column_cost/Distillation_kettle_cond_cost.jl")
	include("column_cost/Distillation_thermosyphon_subcooling_cost.jl")
	include("column_cost/Distillation_thermosyphon_cond_cost.jl")
	include("column_cost/Distillation_kettle_subcooling_cost.jl")
end