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
#* $Id: HairpinIncr.mso								$
#*------------------------------------------------------------------
type Main_Hairpin
	Main_Hairpin()=begin
		new(
			Hairpin_HeatTransfer ((Symbol=>Any)[
				:Brief=>"Double Pipe Heat Transfer"
			]),
			Hairpin_PressureDrop ((Symbol=>Any)[
				:Brief=>"Double Pipe Pressure Drop"
			]),
			Physical_Properties ((Symbol=>Any)[
				:Brief=>"Double Pipe Properties"
			]),
			[:HeatTransfer,:PressureDrop,:Properties,]
		)
	end
	HeatTransfer::Hairpin_HeatTransfer 
	PressureDrop::Hairpin_PressureDrop 
	Properties::Physical_Properties 
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Main_Hairpin
function atributes(in::Main_Hairpin,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="to be documented"
	fields[:Info]="to be documented"
	drive!(fields,_)
	return fields
end
Main_Hairpin(_::Dict{Symbol,Any})=begin
	newModel=Main_Hairpin()
	newModel.attributes=atributes(newModel,_)
	newModel
end
