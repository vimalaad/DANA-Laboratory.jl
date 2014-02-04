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
#*----------------------------------------------------------------------
#* Author: Rafael de Pelegrini Soares
#* $Id$
#*--------------------------------------------------------------------
type wire
	wire()=begin
		new(
			current((Symbol=>Any)[
				:Lower=>-100
			]),
			voltage(),
			[:i,:V,]
		)
	end
	i::current
	V::voltage
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export wire
function atributes(in::wire,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Wire."
	fields[:Info]="This model holds a current and voltage."
	drive!(fields,_)
	return fields
end
wire(_::Dict{Symbol,Any})=begin
	newModel=wire()
	newModel.attributes=atributes(newModel,_)
	newModel
end
