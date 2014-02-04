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
#* Model of an equilibrium reactor
#*----------------------------------------------------------------------
#*
#*   Description:
#*       Thermodynamic equilibrium modeling of a reactor based on 
#*	equilibrium constants approach.
#*
#*   Assumptions:
#*		* single-phases involved
#*       * thermodynamic equilibrium
#*		* steady-state
#*
#*	Specify:
#*		* inlet stream
#*		* stoichiometric matrix
#*		* equilibrium temperature
#*
#*----------------------------------------------------------------------
#* Author: Rodolfo Rodrigues
#* $Id$
#*--------------------------------------------------------------------
#---------------------------------------------------------------------
#*	only vapour phase
#*--------------------------------------------------------------------
type equil_vap
	equil_vap()=begin
		new(
			tank_vap(),
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
				:Brief=>"Gibbs free-energy of formation",
				:Protected=>true
			]),(NComp)),
			fill(DanaReal ((Symbol=>Any)[
				:Brief=>"Equillibrium constant",
				:Lower=>0,
				:Default=>1.5,
				:Protected=>true
			]),(NReac)),
			fill(DanaReal ((Symbol=>Any)[
				:Brief=>"Activity",
				:Symbol=>"\\hat{a}",
				:Lower=>0,
				:Default=>0.2,
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
				:(sumt(G*stoic(:,[1:NReac])) = -Rg*Outlet.T*ln(K([1:NReac]))),
				:(K([1:NReac]) = prod(activ^stoic(:,[1:NReac]))),
				:(Outlet.F*Outlet.z([1:_P1._P1.NComp]) = (_P1._P1.Inlet.F*_P1._P1.Inlet.z([1:_P1._P1.NComp]) + sumt(stoic([1:_P1._P1.NComp],:)*extent))),
				:(Outlet.F*Outlet.z([1:_P1._P1.NComp]) = _P1._P1.Outletm.F*_P1._P1.Outletm.z([1:_P1._P1.NComp])*(1 - conv([1:_P1._P1.NComp]))),
				:(conv([1:_P1._P1.NComp]) = 1),
				:(conv([1:_P1._P1.NComp]) = 0),
				:(activ = _P1._P1.PP.VapourFugacityCoefficient(Outlet.T,Outlet.P,Outlet.z)*Outlet.P*Outlet.z/fs),
			],
			[
				"Outlet stream","Mechanical equilibrium","Energy balance","Steady-state","Gibbs free-energy of formation","Gibbs free energy of reaction","Equilibrium constant","Outlet molar fraction","Molar conversion","Molar conversion","Molar conversion","Activity",
			],
			[:NReac,:stoic,:Rg,:fs,:To,],
			[:Outlet,:G,:K,:activ,:rate,:extent,:conv,]
		)
	end
	_P1::tank_vap
	NReac::DanaInteger 
	stoic::Array{DanaReal }
	Rg::DanaReal 
	fs::Array{pressure }
	To::temperature 
	Outlet::vapour_stream
	G::Array{energy_mol }
	K::Array{DanaReal }
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
export equil_vap
function setEquationFlow(in::equil_vap)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	#	"Gibbs free-energy of formation without Cp correction"
	#	G = PP.IdealGasGibbsOfFormationAt25C()*Outlet.T/To
	#		+ PP.IdealGasEnthalpyOfFormationAt25C()*(1 - Outlet.T/To);
	addEquation(6)
	#		K(j) = exp(-sumt(G*stoic(:,j))/(Rg*Outlet.T));
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
function atributes(in::equil_vap,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/cstr"
	fields[:Brief]="Model of a generic vapour-phase equilibrium CSTR"
	fields[:Info]="
== Assumptions ==
* only vapour-phase
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
equil_vap(_::Dict{Symbol,Any})=begin
	newModel=equil_vap()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(equil_vap)
