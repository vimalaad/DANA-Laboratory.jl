module EMLcstr
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/streams.jl")
	using EMLstreams
	using EMLtypes
	include("cstr/cstr_basic.jl")
	include("cstr/cstr_yield.jl")
	include("cstr/cstr.jl")
end