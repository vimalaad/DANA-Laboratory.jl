module EMLstreams
	using DanaTypes
	using NamesOfTypes
	require("DanaModels.jl/JuliaEMSOModels/types.jl")
	using EMLtypes
	include("streams/stream.jl")
	include("streams/liquid_stream.jl")
	include("streams/vapour_stream.jl")
	include("streams/streamPH.jl")
	include("streams/streamPHS.jl")
	include("streams/source.jl")
	include("streams/simple_source.jl")
	include("streams/sink.jl")
	include("streams/simple_sink.jl")
	include("streams/energy_stream.jl")
	include("streams/work_stream.jl")
	include("streams/work_source.jl")
	include("streams/work_sink.jl")
	include("streams/energy_source.jl")
	include("streams/energy_sink.jl")
	include("streams/sourceNoFlow.jl")
	include("streams/info_stream.jl")
end