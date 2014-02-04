module EMLsplitter
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/streams.jl")
	using EMLstreams
	using EMLtypes
	include("splitter/splitter_n.jl")
	include("splitter/splitter.jl")
end