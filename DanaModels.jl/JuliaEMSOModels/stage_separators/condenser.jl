module EMLcondenser
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/streams.jl")
	using EMLstreams
	using EMLtypes
	include("condenser/condenser.jl")
	include("condenser/condenserSteady.jl")
	include("condenser/condenserReact.jl")
end