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
#* Model of basic streams
#*----------------------------------------------------------------------
#* Author: Paula B. Staudt and Rafael de P. Soares
#* $Id$
#*---------------------------------------------------------------------
type energy_stream
	energy_stream()=begin
		new(
			heat_rate((Symbol=>Any)[
				:Brief=>"Energy rate"
			]),
			[:Q,]
		)
	end
	Q::heat_rate
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export energy_stream
function atributes(in::energy_stream,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="General Energy Stream"
	fields[:Info]="This is the basic building block for the EML models.
	Every model should have input and output energy streams
	derived from this model."
	drive!(fields,_)
	return fields
end
energy_stream(_::Dict{Symbol,Any})=begin
	newModel=energy_stream()
	newModel.attributes=atributes(newModel,_)
	newModel
end
