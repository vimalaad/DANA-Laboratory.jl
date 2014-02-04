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
#* Author: Tiago Os򱨯rio
#* $Id$
#*-------------------------------------------------------------------
type MPorts
	MPorts()=begin
		new(
			control_signal ((Symbol=>Any)[
				:Brief=>"Previous scaled input signal",
				:Default=>0.5
			]),
			control_signal ((Symbol=>Any)[
				:Brief=>"Scaled output signal",
				:Default=>0.5
			]),
			control_signal ((Symbol=>Any)[
				:Brief=>"Scaled setPoint",
				:Default=>0.5
			]),
			[:input,:output,:setPoint,]
		)
	end
	input::control_signal 
	output::control_signal 
	setPoint::control_signal 
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export MPorts
function atributes(in::MPorts,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Model of Ports to be used with PIDs."
	drive!(fields,_)
	return fields
end
MPorts(_::Dict{Symbol,Any})=begin
	newModel=MPorts()
	newModel.attributes=atributes(newModel,_)
	newModel
end
