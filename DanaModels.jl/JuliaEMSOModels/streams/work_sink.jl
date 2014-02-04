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
type work_sink
	work_sink()=begin
		new(
			work_stream ((Symbol=>Any)[
				:Brief=>"Inlet work stream",
				:PosX=>0,
				:PosY=>0.46,
				:Symbol=>"_{in}"
			]),
			[:InletWork,]
		)
	end
	InletWork::work_stream 
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export work_sink
function atributes(in::work_sink,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/work_sink"
	fields[:Brief]="Work stream sink"
	drive!(fields,_)
	return fields
end
work_sink(_::Dict{Symbol,Any})=begin
	newModel=work_sink()
	newModel.attributes=atributes(newModel,_)
	newModel
end
