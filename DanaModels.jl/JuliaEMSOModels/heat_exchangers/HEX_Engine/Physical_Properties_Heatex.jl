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
type Physical_Properties_Heatex
	Physical_Properties_Heatex()=begin
		new(
			molweight ((Symbol=>Any)[
				:Brief=>"Average Mol Weight",
				:Default=>75,
				:Lower=>1,
				:Upper=>1e8
			]),
			cp_mol ((Symbol=>Any)[
				:Brief=>"Average Molar Heat Capacity",
				:Upper=>1e10
			]),
			Properties_In_Out ((Symbol=>Any)[
				:Brief=>"Properties at Inlet Stream",
				:Symbol=>"_{in}"
			]),
			Properties_In_Out ((Symbol=>Any)[
				:Brief=>"Properties at Outlet Stream",
				:Symbol=>"_{out}"
			]),
			[:Mw,:Cp,:Inlet,:Outlet,]
		)
	end
	Mw::molweight 
	Cp::cp_mol 
	Inlet::Properties_In_Out 
	Outlet::Properties_In_Out 
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Physical_Properties_Heatex
function atributes(in::Physical_Properties_Heatex,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="to be documented"
	fields[:Info]="to be documented"
	drive!(fields,_)
	return fields
end
Physical_Properties_Heatex(_::Dict{Symbol,Any})=begin
	newModel=Physical_Properties_Heatex()
	newModel.attributes=atributes(newModel,_)
	newModel
end
