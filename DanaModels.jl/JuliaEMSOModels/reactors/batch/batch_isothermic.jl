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
#* Author: Paula B. Staudt and Rafael P. Soares
#* $Id$
#*------------------------------------------------------------------
type batch_isothermic
	batch_isothermic()=begin
		new(
			batch_basic(),
			[
				:(T = _P1.Inlet.T),
				:(P = _P1.Inlet.P),
			],
			[
				"Isotermic","Isobaric",
			],
		)
	end
	_P1::batch_basic
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	attributes::Dict{Symbol,Any}
end
export batch_isothermic
function setEquationFlow(in::batch_isothermic)
	addEquation(1)
	addEquation(2)
end
function atributes(in::batch_isothermic,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/batch"
	fields[:Brief]="Model of a isothermal batch reactor"
	fields[:Info]="
Assumptions
* isothermic
"
	drive!(fields,_)
	return fields
end
batch_isothermic(_::Dict{Symbol,Any})=begin
	newModel=batch_isothermic()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(batch_isothermic)
