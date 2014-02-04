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
#*--------------------------------------------------------------------
#* Author: Gerson Balbueno Bicca 
#* $Id$
#*--------------------------------------------------------------------
type Physical_Properties
	Physical_Properties()=begin
		new(
			Properties_In_Out ((Symbol=>Any)[
				:Brief=>"Properties at Inlet Stream",
				:Symbol=>"_{in}"
			]),
			Properties_Average ((Symbol=>Any)[
				:Brief=>"Properties at Average Temperature",
				:Symbol=>"_{avg}"
			]),
			Properties_In_Out ((Symbol=>Any)[
				:Brief=>"Properties at Outlet Stream",
				:Symbol=>"_{out}"
			]),
			Properties_Wall ((Symbol=>Any)[
				:Brief=>"Properties at Wall Temperature",
				:Symbol=>"_{wall}"
			]),
			[:Inlet,:Average,:Outlet,:Wall,]
		)
	end
	Inlet::Properties_In_Out 
	Average::Properties_Average 
	Outlet::Properties_In_Out 
	Wall::Properties_Wall 
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Physical_Properties
function atributes(in::Physical_Properties,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="to be documented"
	fields[:Info]="to be documented"
	drive!(fields,_)
	return fields
end
Physical_Properties(_::Dict{Symbol,Any})=begin
	newModel=Physical_Properties()
	newModel.attributes=atributes(newModel,_)
	newModel
end
