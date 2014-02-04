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
type work_stream
	work_stream()=begin
		new(
			power((Symbol=>Any)[
				:Brief=>"work"
			]),
			[:Work,]
		)
	end
	Work::power
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export work_stream
function atributes(in::work_stream,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="General Work Stream"
	drive!(fields,_)
	return fields
end
work_stream(_::Dict{Symbol,Any})=begin
	newModel=work_stream()
	newModel.attributes=atributes(newModel,_)
	newModel
end
