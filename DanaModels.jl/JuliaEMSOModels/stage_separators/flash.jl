module EMLflash
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/streams.jl")
	using EMLstreams
	using EMLtypes
	include("flash/flash.jl")
	include("flash/flash_steady.jl")
	include("flash/bubble_steady.jl")
	include("flash/dew_steady.jl")
	include("flash/flash_steady_full.jl")
	include("flash/flash_steady_bd.jl")
	include("flash/FlashPHSteady.jl")
	include("flash/FlashPHSteadyA.jl")
end