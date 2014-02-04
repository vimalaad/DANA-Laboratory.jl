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
#*----------------------------------------------------------------------
#* Author: Gerson Balbueno Bicca 
#* $Id$
#*--------------------------------------------------------------------
type cooler
	cooler()=begin
		new(
			heater_basic(),
			energy_stream ((Symbol=>Any)[
				:Brief=>"Inlet Heat Stream",
				:PosX=>0.5,
				:PosY=>0,
				:Symbol=>"_{out}"
			]),
			[
				:(OutletQ.Q = -_P1.Duty),
			],
			[
				"Duty Specification",
			],
			[:OutletQ,]
		)
	end
	_P1::heater_basic
	OutletQ::energy_stream 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export cooler
function setEquationFlow(in::cooler)
	addEquation(1)
end
function atributes(in::cooler,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/cooler"
	fields[:Brief]="Cooler"
	fields[:Info]="Determines thermal and phase conditions of an outlet stream.

== Specify ==
* The Inlet stream
* Specify: 
**The outlet temperature and the outlet pressure or
** The outlet temperature and the inlet energy stream or
** The outlet pressure and the inlet energy stream
"
	drive!(fields,_)
	return fields
end
cooler(_::Dict{Symbol,Any})=begin
	newModel=cooler()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(cooler)
