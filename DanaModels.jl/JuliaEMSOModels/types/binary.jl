export binary
typealias Danabinary DanaIntegerParametric
type _binary
	function _binary(_::Dict{Symbol,Any})
		fields::Dict{Symbol,Any}=(Symbol=>Any)[]
		fields[:Brief]="Binary variables"
		fields[:Default]=1
		fields[:Lower]=0
		fields[:Upper]=1
		drive!(fields,_)
		new(fields)
	end
	value::Dict{Symbol,Any}
end
typealias binary DanaIntegerParametric{_binary}