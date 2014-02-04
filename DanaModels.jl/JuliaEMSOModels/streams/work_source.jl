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
type work_source
	work_source()=begin
		new(
			work_stream ((Symbol=>Any)[
				:Brief=>"Outlet work stream",
				:PosX=>1,
				:PosY=>0.46,
				:Symbol=>"_{out}"
			]),
			[:OutletWork,]
		)
	end
	OutletWork::work_stream 
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export work_source
function atributes(in::work_source,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/work_source"
	fields[:Brief]="Work stream source"
	drive!(fields,_)
	return fields
end
work_source(_::Dict{Symbol,Any})=begin
	newModel=work_source()
	newModel.attributes=atributes(newModel,_)
	newModel
end
