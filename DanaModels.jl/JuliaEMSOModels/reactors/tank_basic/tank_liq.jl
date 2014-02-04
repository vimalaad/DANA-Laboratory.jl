#---------------------------------------------------------------------
#*	only liquid phase
#*--------------------------------------------------------------------
type tank_liq
	tank_liq()=begin
		new(
			tank_basic(),
			[
				:(_P1.Outletm.v = 0),
				:(_P1.Outletm.h = _P1.PP.LiquidEnthalpy(_P1.Outletm.T,_P1.Outletm.P,_P1.Outletm.z)),
				:(_P1.Tank.V = _P1.Mt*_P1.PP.LiquidVolume(_P1.Outletm.T,_P1.Outletm.P,_P1.Outletm.z)),
				:(E = _P1.Mt*_P1.Outletm.h - _P1.Outletm.P*_P1.Tank.V),
			],
			[
				"Vapourisation fraction","Liquid Enthalpy","Volume constraint","Total internal energy",
			],
		)
	end
	_P1::tank_basic
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	attributes::Dict{Symbol,Any}
end
export tank_liq
function setEquationFlow(in::tank_liq)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
end
function atributes(in::tank_liq,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Brief]="Model of a generic liquid-phase tank"
	drive!(fields,_)
	return fields
end
tank_liq(_::Dict{Symbol,Any})=begin
	newModel=tank_liq()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(tank_liq)
