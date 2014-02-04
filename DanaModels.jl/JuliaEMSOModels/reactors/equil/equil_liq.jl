#---------------------------------------------------------------------
#*	only liquid-phase
#*--------------------------------------------------------------------
type equil_liq
	equil_liq()=begin
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
			DanaReal ((Symbol=>Any)[
				:Brief=>"Universal gas constant",
				:Unit=>"J/mol/K",
				:Default=>8.314,
				:Hidden=>true
			]),
			pressure ((Symbol=>Any)[
				:Brief=>"Standard pressure",
				:Default=>1,
				:DisplayUnit=>"bar",
				:Hidden=>true
			]),
			temperature ((Symbol=>Any)[
				:Brief=>"Reference temperature",
				:Default=>298.15,
				:Hidden=>true
			]),
			liquid_stream((Symbol=>Any)[
				:Brief=>"Outlet stream",
				:PosX=>1,
				:PosY=>1,
				:Symbol=>"_{out}"
			]),
			fill(enth_mol ((Symbol=>Any)[
				:Brief=>"Gibbs free-energy of formation",
				:Protected=>true
			]),(NReac)),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Equillibrium constant",
				:Protected=>true
			]),(NReac)),
			fill(DanaReal ((Symbol=>Any)[
				:Brief=>"Activity",
				:Symbol=>"\\hat{a}",
				:Protected=>true
			]),(NComp)),
			fill(reaction_mol ((Symbol=>Any)[
				:Brief=>"Overall component rate of reaction"
			]),(NComp)),
			fill(flow_mol ((Symbol=>Any)[
				:Brief=>"Extent of reaction",
				:Symbol=>"\\xi"
			]),(NReac)),
			fill(DanaReal ((Symbol=>Any)[
				:Brief=>"Fractional conversion of component",
				:Symbol=>"X",
				:Default=>0
			]),(NComp)),
			[
				:(Outlet.F*Outlet.z = _P1._P1.Outletm.F*_P1._P1.Outletm.z + rate*_P1._P1.Tank.V),
				:(Outlet.P = _P1._P1.Outletm.P),
				:(Outlet.F*Outlet.h = _P1._P1.Outletm.F*_P1._P1.Outletm.h),
				:(Outlet.F = _P1._P1.Inlet.F + sum(sumt(stoic*extent))),
				:(G = _P1._P1.PP.IdealGasGibbsOfFormation(Outlet.T)),
				:(sumt(G*stoic) = -Rg*Outlet.T*ln(K)),
				:(K([1:NReac]) = prod(activ^stoic(:,[1:NReac]))),
				:(Outlet.F*Outlet.z([1:_P1._P1.NComp]) = (_P1._P1.Inlet.F*_P1._P1.Inlet.z([1:_P1._P1.NComp]) + sumt(stoic([1:_P1._P1.NComp],:)*extent))),
				:(Outlet.F*Outlet.z([1:_P1._P1.NComp]) = _P1._P1.Outletm.F*_P1._P1.Outletm.z([1:_P1._P1.NComp])*(1 - conv([1:_P1._P1.NComp]))),
				:(conv([1:_P1._P1.NComp]) = 1),
				:(conv([1:_P1._P1.NComp]) = 0),
				:(activ = _P1._P1.PP.LiquidFugacityCoefficient(Outlet.T,Outlet.P,Outlet.z)*Outlet.z *exp(_P1._P1.PP.LiquidVolume(Outlet.T,Outlet.P,Outlet.z)*(Outlet.P - Ps)/Rg/Outlet.T)),
			],
			[
				"Outlet stream","Mechanical equilibrium","Energy balance","Steady-state","Gibbs free-energy of formation","Gibbs free energy of reaction","Equilibrium constant","Outlet molar fraction","Molar conversion","Molar conversion","Molar conversion","Activity",
			],
			[:NReac,:stoic,:Rg,:Ps,:To,],
			[:Outlet,:G,:K,:activ,:rate,:extent,:conv,]
		)
	end
	_P1::tank_liq
	NReac::DanaInteger 
	stoic::Array{DanaReal }
	Rg::DanaReal 
	Ps::pressure 
	To::temperature 
	Outlet::liquid_stream
	G::Array{enth_mol }
	K::Array{fraction }
	activ::Array{DanaReal }
	rate::Array{reaction_mol }
	extent::Array{flow_mol }
	conv::Array{DanaReal }
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export equil_liq
function setEquationFlow(in::equil_liq)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	#	"Gibbs free-energy of formation without Cp correction"
	#	G = PP.IdealGasGibbsOfFormationAt25C()*Outlet.T/To
	#		+ PP.IdealGasEnthalpyOfFormationAt25C()*(1 - Outlet.T/To);
	addEquation(6)
	#	K = exp(-sumt(G*stoic)/(Rg*Outlet.T));
	addEquation(7)
	addEquation(8)
	if (Outletm.z(i) > 1e-16) 
		addEquation(9)
	else
		if (Outlet.z(i) > 0) 
			addEquation(10)
			# ?
			
		else
			addEquation(11)
			# ?
			
		end
	end
	addEquation(12)
end
function atributes(in::equil_liq,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/cstr"
	fields[:Brief]="Model of a generic liquid-phase equilibrium CSTR"
	fields[:Info]="
== Assumptions ==
* only liquid-phase
* thermodynamic equilibrium
* steady-state

== Specify ==
* inlet stream
* stoichiometric matrix
* equilibrium temperature
"
	drive!(fields,_)
	return fields
end
equil_liq(_::Dict{Symbol,Any})=begin
	newModel=equil_liq()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(equil_liq)
