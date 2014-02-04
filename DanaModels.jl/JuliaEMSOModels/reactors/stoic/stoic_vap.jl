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
#* Model of a stoichiometric reactor
#*----------------------------------------------------------------------
#*
#*   Description:
#*       Modeling of a reactor based on a stoichiometric approach.
#*
#*   Assumptions:
#*		* single- and two-phases involved
#*		* steady-state
#*
#*	Specify:
#*		* inlet stream
#*		* extent of reactions or
#*		* conversion of a key component
#*
#*----------------------------------------------------------------------
#* Author: Rodolfo Rodrigues
#* $Id$
#*--------------------------------------------------------------------
#---------------------------------------------------------------------
#*	only vapour-phase
#*--------------------------------------------------------------------
type stoic_vap
	stoic_vap()=begin
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
			vapour_stream((Symbol=>Any)[
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
	_P1::tank_vap
	NReac::DanaInteger 
	stoic::Array{DanaReal }
	Outlet::vapour_stream
	rate::Array{reaction_mol }
	conv::Array{DanaReal }
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export stoic_vap
function setEquationFlow(in::stoic_vap)
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
function atributes(in::stoic_vap,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Brief]="Basic model for a vapour-phase stoichiometric CSTR"
	fields[:Info]="
== Assumptions ==
* only vapour-phase
* steady-state
"
	drive!(fields,_)
	return fields
end
stoic_vap(_::Dict{Symbol,Any})=begin
	newModel=stoic_vap()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(stoic_vap)
