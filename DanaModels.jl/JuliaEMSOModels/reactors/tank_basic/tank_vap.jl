#---------------------------------------------------------------------
#*	only vapour phase
#*--------------------------------------------------------------------
type tank_vap
	tank_vap()=begin
		new(
			tank_basic(),
			[
				:(_P1.Outletm.v = 1),
				:(_P1.Outletm.h = _P1.PP.VapourEnthalpy(_P1.Outletm.T,_P1.Outletm.P,_P1.Outletm.z)),
				:(_P1.Tank.V = _P1.Mt*_P1.PP.VapourVolume(_P1.Outletm.T,_P1.Outletm.P,_P1.Outletm.z)),
				:(E = _P1.Mt*_P1.Outletm.h),
			],
			[
				"Vapourisation fraction","Vapour Enthalpy","Volume constraint","Total internal energy",
			],
		)
	end
	_P1::tank_basic
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	attributes::Dict{Symbol,Any}
end
export tank_vap
function setEquationFlow(in::tank_vap)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
end
function atributes(in::tank_vap,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Brief]="Model of a generic vapour-phase tank"
	drive!(fields,_)
	return fields
end
tank_vap(_::Dict{Symbol,Any})=begin
	newModel=tank_vap()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(tank_vap)
