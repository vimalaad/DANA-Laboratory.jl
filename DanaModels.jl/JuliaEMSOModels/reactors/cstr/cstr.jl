#-------------------------------------------------------------------
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
#*--------------------------------------------------------------------
#* Model of cstr reactor
#*--------------------------------------------------------------------
#* Author: Paula B. Staudt
#* $Id$
#*--------------------------------------------------------------------
type cstr
	cstr()=begin
		new(
			cstr_basic(),
			fill(reaction_mol ((Symbol=>Any)[
				:Brief=>"Molar Reaction Rate"
			]),(NReac)),
			fill(heat_reaction ((Symbol=>Any)[
				:Brief=>"Heat Reaction"
			]),(NReac)),
			[
				:(diff(_P1.Outlet.z*M) = (_P1.Inlet.F*_P1.Inlet.z - _P1.Outlet.F*_P1.Outlet.z) + sumt(_P1.stoic*r)*_P1.Vr),
				:(diff(M*_P1.Outlet.h) = _P1.Inlet.F*_P1.Inlet.h - _P1.Outlet.F*_P1.Outlet.h +sum(Hr*sum(_P1.stoic*r))*_P1.Vr - q),
			],
			[
				"Component Molar Balance","Reactor Energy Balance",
			],
			[:r,:Hr,]
		)
	end
	_P1::cstr_basic
	r::Array{reaction_mol }
	Hr::Array{heat_reaction }
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export cstr
function setEquationFlow(in::cstr)
	addEquation(1)
	addEquation(2)
	#FIXME sum(sum())
	
end
function atributes(in::cstr,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/cstr"
	fields[:Brief]="Model of a generic CSTR"
	fields[:Info]="
Requires the information of:
* Reaction values
* Heat of reaction
"
	drive!(fields,_)
	return fields
end
cstr(_::Dict{Symbol,Any})=begin
	newModel=cstr()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(cstr)
