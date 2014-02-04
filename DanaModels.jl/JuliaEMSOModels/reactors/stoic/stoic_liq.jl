#---------------------------------------------------------------------
#*	only liquid-phase
#*--------------------------------------------------------------------
type stoic_liq
	stoic_liq()=begin
		new(
			tank_liq(),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of reactions",
				:Default=>1
			]),
			fill(DanaReal ((Symbol=>Any)[
				:Brief=>"Stoichiometric matrix",
				:Symbol=>"\\nu"
			]),(NComp,NReac)),
			liquid_stream((Symbol=>Any)[
				:Brief=>"Outlet stream",
				:PosX=>1,
				:PosY=>1,
				:Symbol=>"_{out}"
			]),
			fill(reaction_mol ((Symbol=>Any)[
				:Brief=>"Overall component rate of reaction"
			]),(NComp)),
			fill(DanaReal ((Symbol=>Any)[
				:Brief=>"Fractional conversion of component",
				:Symbol=>"X",
				:Default=>0
			]),(NComp)),
			[
				:(Outlet.F*Outlet.z = _P1._P1.Outletm.F*_P1._P1.Outletm.z + rate*_P1._P1.Tank.V),
				:(Outlet.P = _P1._P1.Outletm.P),
				:(Outlet.F*Outlet.h = _P1._P1.Outletm.F*_P1._P1.Outletm.h),
				:(Outlet.F = _P1._P1.Outletm.F),
				:(Outlet.F*Outlet.z([1:_P1._P1.NComp]) = _P1._P1.Outletm.F*_P1._P1.Outletm.z([1:_P1._P1.NComp])*(1 - conv([1:_P1._P1.NComp]))),
				:(conv([1:_P1._P1.NComp]) = 1),
				:(conv([1:_P1._P1.NComp]) = 0),
			],
			[
				"Outlet stream","Mechanical equilibrium","Energy balance","Steady-state","Molar conversion","Molar conversion","Molar conversion",
			],
			[:NReac,:stoic,],
			[:Outlet,:rate,:conv,]
		)
	end
	_P1::tank_liq
	NReac::DanaInteger 
	stoic::Array{DanaReal }
	Outlet::liquid_stream
	rate::Array{reaction_mol }
	conv::Array{DanaReal }
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export stoic_liq
function setEquationFlow(in::stoic_liq)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	if (Outletm.z(i) > 1e-16) 
		addEquation(5)
	else
		if (Outlet.z(i) > 0) 
			addEquation(6)
			# ?
			
		else
			addEquation(7)
			# ?
			
		end
	end
end
function atributes(in::stoic_liq,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Brief]="Basic model for a liquid-phase stoichiometric CSTR"
	fields[:Info]="
== Assumptions ==
* only liquid-phase
* steady-state
"
	drive!(fields,_)
	return fields
end
stoic_liq(_::Dict{Symbol,Any})=begin
	newModel=stoic_liq()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(stoic_liq)
