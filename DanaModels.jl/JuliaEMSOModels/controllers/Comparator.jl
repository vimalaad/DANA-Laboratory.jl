module EMLComparator
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/types.jl")
	using EMLtypes
	include("Comparator/comparator.jl")
end