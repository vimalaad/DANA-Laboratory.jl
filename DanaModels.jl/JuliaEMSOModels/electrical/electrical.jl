module EMLelectrical
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/types.jl")
	using EMLtypes
	include("electrical/wire.jl")
	include("electrical/Resistor.jl")
	include("electrical/Capacitor.jl")
	include("electrical/Indutor.jl")
	include("electrical/Supply.jl")
end