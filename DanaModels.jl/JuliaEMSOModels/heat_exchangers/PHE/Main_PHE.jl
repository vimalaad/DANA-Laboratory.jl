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
#* $Id: PHE.mso 250 2007-04-27 16:32:02Z bicca $
#*------------------------------------------------------------------
type Main_PHE
	Main_PHE()=begin
		new(
			PHE_HeatTransfer ((Symbol=>Any)[
				:Brief=>"PHE Heat Transfer",
				:Symbol=>" "
			]),
			PHE_PressureDrop ((Symbol=>Any)[
				:Brief=>"PHE Pressure Drop",
				:Symbol=>" "
			]),
			Physical_Properties ((Symbol=>Any)[
				:Brief=>"PHE Properties",
				:Symbol=>" "
			]),
			[:HeatTransfer,:PressureDrop,:Properties,]
		)
	end
	HeatTransfer::PHE_HeatTransfer 
	PressureDrop::PHE_PressureDrop 
	Properties::Physical_Properties 
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Main_PHE
function atributes(in::Main_PHE,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="to be documented"
	fields[:Info]="to be documented"
	drive!(fields,_)
	return fields
end
Main_PHE(_::Dict{Symbol,Any})=begin
	newModel=Main_PHE()
	newModel.attributes=atributes(newModel,_)
	newModel
end
