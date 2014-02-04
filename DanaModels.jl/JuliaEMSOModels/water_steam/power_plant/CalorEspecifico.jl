export CalorEspecifico
typealias DanaCalorEspecifico DanaRealParametric
type _CalorEspecifico
	function _CalorEspecifico(_::Dict{Symbol,Any})
		fields::Dict{Symbol,Any}=(Symbol=>Any)[]
		fields[:Default]=1e-3
		fields[:Lower]=0
		fields[:Upper]=1
		fields[:Unit]="MJ/kg/K"
		drive!(fields,_)
		new(fields)
	end
	value::Dict{Symbol,Any}
end
typealias CalorEspecifico DanaRealParametric{_CalorEspecifico}