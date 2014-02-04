#---------------------------------------------------------------------
#* EMSO Model Library (EML) Copyright (C) 2004 - 2007 ALSOC.
#*
#* This LIBRARY is free software; you can distribute it and/or modify
#* it under the therms of the ALSOC FREE LICENSE as available at
#* http://www.enq.ufrgs.br/alsoc.
#*
#* EMSO Copyright (C) 2004 - 2007 ALSOC, original code
#* from http://www.rps.eng.br Copyright (C) 2002-2004.
#* All rights reserved.
#*
#* EMSO is distributed under the therms of the ALSOC LICENSE as
#* available at http://www.enq.ufrgs.br/alsoc.
#*
#*----------------------------------------------------------------------
#* Model of a Gibbs reactor
#*----------------------------------------------------------------------
#*
#*   Description:
#*       Thermodynamic equilibrium modeling of a reactor using Gibbs
#*	free energy minimization approach.
#*
#*   Assumptions:
#*		* single-phases involved
#*       * thermodynamic equilibrium
#*		* steady-state
#*
#*	Specify:
#*		* inlet stream
#*		* number of elements related to components
#*		* matrix of elements by components
#*		* equilibrium temperature
#*
#*----------------------------------------------------------------------
#* Author: Rodolfo Rodrigues
#* $Id$
#*--------------------------------------------------------------------
#---------------------------------------------------------------------
#*	only vapour phase
#*--------------------------------------------------------------------
type gibbs_vap
	gibbs_vap()=begin
		new(
			tank_vap(),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of elements",
				:Default=>1
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Universal gas constant",
				:Unit=>"J/mol/K",
				:Default=>8.314,
				:Hidden=>true
			]),
			fill(DanaReal ((Symbol=>Any)[
				:Brief=>"Number of elements per component"
			]),(NElem,NComp)),
			fill(pressure ((Symbol=>Any)[
				:Brief=>"Fugacity in standard state",
				:Default=>1,
				:DisplayUnit=>"atm",
				:Hidden=>true
			]),(NComp)),
			temperature ((Symbol=>Any)[
				:Brief=>"Reference temperature",
				:Default=>298.15,
				:Hidden=>true
			]),
			vapour_stream((Symbol=>Any)[
				:Brief=>"Outlet stream",
				:PosX=>1,
				:PosY=>1,
				:Symbol=>"_{out}"
			]),
			fill(energy_mol ((Symbol=>Any)[
				:Brief=>"Gibbs free-energy change of formation",
				:Protected=>true
			]),(NComp)),
			fill(energy_mol ((Symbol=>Any)[
				:Brief=>"Lagrangian multiplier",
				:Symbol=>"\\lambda",
				:Hidden=>true
			]),(NElem)),
			fill(DanaReal ((Symbol=>Any)[
				:Brief=>"Activity",
				:Symbol=>"\\hat{a}",
				:Lower=>0,
				:Protected=>true
			]),(NComp)),
			fill(reaction_mol ((Symbol=>Any)[
				:Brief=>"Overall component rate of reaction"
			]),(NComp)),
			fill(DanaReal ((Symbol=>Any)[
				:Brief=>"Fractional conversion of component",
				:Symbol=>"X",
				:Default=>0
			]),(NComp)),
			fill(flow_mol ((Symbol=>Any)[
				:Brief=>"Component molar flow rate",
				:Hidden=>true
			]),(NComp)),
			[
				:(Outlet.F*Outlet.z = _P1._P1.Outletm.F*_P1._P1.Outletm.z + rate*_P1._P1.Tank.V),
				:(Outlet.P = _P1._P1.Outletm.P),
				:(Outlet.F = sum(Fi)),
				:(Fi = Outlet.F*Outlet.z),
				:(Outlet.F*Outlet.h = _P1._P1.Outletm.F*_P1._P1.Outletm.h),
				:(sumt(Fi*na) = sumt(_P1._P1.Outletm.F*_P1._P1.Outletm.z*na)),
				:(G = _P1._P1.PP.IdealGasGibbsOfFormation(Outlet.T)),
				:(G([1:_P1._P1.NComp]) + sumt(lambda*na(:,[1:_P1._P1.NComp])) = -Rg*Outlet.T*ln(activ([1:_P1._P1.NComp]))),
				:(Fi([1:_P1._P1.NComp]) = _P1._P1.Outletm.F*_P1._P1.Outletm.z([1:_P1._P1.NComp])*(1 - conv([1:_P1._P1.NComp]))),
				:(conv([1:_P1._P1.NComp]) = 1),
				:(conv([1:_P1._P1.NComp]) = 0),
				:(activ = _P1._P1.PP.VapourFugacityCoefficient(Outlet.T,Outlet.P,Outlet.z) *Outlet.P*Outlet.z/fs),
			],
			[
				"Outlet stream","Mechanical equilibrium","Steady-state","Component molar flow rate","Energy balance","Element balance","Gibbs free-energy of formation","Lagrangian multiplier","Molar conversion","Molar conversion","Molar conversion","Activity",
			],
			[:NElem,:Rg,:na,:fs,:To,],
			[:Outlet,:G,:lambda,:activ,:rate,:conv,:Fi,]
		)
	end
	_P1::tank_vap
	NElem::DanaInteger 
	Rg::DanaReal 
	na::Array{DanaReal }
	fs::Array{pressure }
	To::temperature 
	Outlet::vapour_stream
	G::Array{energy_mol }
	lambda::Array{energy_mol }
	activ::Array{DanaReal }
	rate::Array{reaction_mol }
	conv::Array{DanaReal }
	Fi::Array{flow_mol }
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export gibbs_vap
function setEquationFlow(in::gibbs_vap)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
	addEquation(7)
	#	"Gibbs free-energy of formation without Cp correction"
	#	G = PP.IdealGasGibbsOfFormationAt25C()*Outlet.T/To
	#		+ PP.IdealGasEnthalpyOfFormationAt25C()*(1 - Outlet.T/To);
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
function atributes(in::gibbs_vap,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/cstr"
	fields[:Brief]="Model of a generic vapour-phase Gibbs CSTR"
	fields[:Info]="
== Assumptions ==
* thermodynamic equilibrium
* steady-state

== Specify ==
* inlet stream
* number of elements related to components
* matrix of elements by components
* equilibrium temperature
"
	drive!(fields,_)
	return fields
end
gibbs_vap(_::Dict{Symbol,Any})=begin
	newModel=gibbs_vap()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(gibbs_vap)
