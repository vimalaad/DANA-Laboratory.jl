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
type energy_source
	energy_source()=begin
		new(
			energy_stream ((Symbol=>Any)[
				:Brief=>"Outlet energy stream",
				:PosX=>1,
				:PosY=>0.46,
				:Symbol=>"_{out}"
			]),
			[:OutletQ,]
		)
	end
	OutletQ::energy_stream 
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export energy_source
function atributes(in::energy_source,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/energy_source"
	fields[:Brief]="Enegry stream source"
	drive!(fields,_)
	return fields
end
energy_source(_::Dict{Symbol,Any})=begin
	newModel=energy_source()
	newModel.attributes=atributes(newModel,_)
	newModel
end
