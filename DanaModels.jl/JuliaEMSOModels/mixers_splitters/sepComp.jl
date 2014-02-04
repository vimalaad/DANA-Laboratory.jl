module EMLsepComp
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/streams.jl")
	using EMLstreams
	using EMLtypes
	include("sepComp/sepComp_n.jl")
	include("sepComp/sepComp.jl")
end