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
#* Model of an yield reactor
#*----------------------------------------------------------------------
#*
#*   Description:
#*       Modeling of a reactor based on an yield approach.
#*
#*   Assumptions:
#*		* single- and two-phases involved
#*       * steady-state
#*
#*	Specify:
#*		* inlet stream
#*		* component yield or
#*		* reaction yield
#*
#*----------------------------------------------------------------------
#* Author: Rodolfo Rodrigues
#* $Id$
#*--------------------------------------------------------------------
#---------------------------------------------------------------------
#*	only vapour phase
#*--------------------------------------------------------------------
type yield_vap
	yield_vap()=begin
		new(
			tank_vap(),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of reactions",
				:Default=>1
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Key component",
				:Lower=>1,
				:Default=>1
			]),
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
			fill(DanaReal ((Symbol=>Any)[
				:Brief=>"Molar component yield (global)",
				:Symbol=>"Y_G"
			]),(NComp)),
			fill(DanaReal ((Symbol=>Any)[
				:Brief=>"Molar reaction yield (instantaneous)",
				:Symbol=>"Y_I"
			]),(NComp)),
			[
				:(Outlet.F*Outlet.z = _P1._P1.Outletm.F*_P1._P1.Outletm.z + rate*_P1._P1.Tank.V),
				:(rate*_P1._P1.Tank.V = _P1._P1.Outletm.F*(yield/(1 + yield(KComp))*_P1._P1.Outletm.z(KComp) - _P1._P1.Outletm.z)),
				:(rate = yield_*rate(KComp)),
				:(Outlet.P = _P1._P1.Outletm.P),
				:(Outlet.F*Outlet.h = _P1._P1.Outletm.F*_P1._P1.Outletm.h),
				:(Outlet.F*Outlet.z([1:_P1._P1.NComp]) = _P1._P1.Outletm.F*_P1._P1.Outletm.z([1:_P1._P1.NComp])*(1 - conv([1:_P1._P1.NComp]))),
				:(conv([1:_P1._P1.NComp]) = 1),
				:(conv([1:_P1._P1.NComp]) = 0),
			],
			[
				"Outlet stream","Rate of reaction","Instantaneous yield","Mechanical equilibrium","Energy balance","Molar conversion","Molar conversion","Molar conversion",
			],
			[:NReac,:KComp,],
			[:Outlet,:rate,:conv,:yield,:yield_,]
		)
	end
	_P1::tank_vap
	NReac::DanaInteger 
	KComp::DanaInteger 
	Outlet::vapour_stream
	rate::Array{reaction_mol }
	conv::Array{DanaReal }
	yield::Array{DanaReal }
	yield_::Array{DanaReal }
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export yield_vap
function setEquationFlow(in::yield_vap)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	if (Outletm.z(i) > 1e-16) 
		addEquation(6)
	else
		if (Outlet.z(i) > 0) 
			addEquation(7)
			# ?
			
		else
			addEquation(8)
			# ?
			
		end
	end
end
function atributes(in::yield_vap,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/cstr"
	fields[:Brief]="Model of a generic vapour-phase yield CSTR"
	fields[:Info]="
== Assumptions ==
* only vapour-phase
* steady-state

== Specify ==
* inlet stream
* component yield or
* reaction yield
"
	drive!(fields,_)
	return fields
end
yield_vap(_::Dict{Symbol,Any})=begin
	newModel=yield_vap()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(yield_vap)
