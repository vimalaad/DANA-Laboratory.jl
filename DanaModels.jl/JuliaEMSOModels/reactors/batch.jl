module EMLbatch
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/streams.jl")
	using EMLstreams
	using EMLtypes
	include("batch/batch_basic.jl")
	include("batch/batch_isothermic.jl")
end