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
type MParameters
	MParameters()=begin
		new(
			positive ((Symbol=>Any)[
				:Brief=>"Derivative term filter constant",
				:Default=>1
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Proportional term setPoint change filter"
			]),
			control_signal ((Symbol=>Any)[
				:Brief=>"Previous scaled bias",
				:Default=>0.5
			]),
			time_sec ((Symbol=>Any)[
				:Brief=>"Derivative time constant"
			]),
			time_sec ((Symbol=>Any)[
				:Brief=>"Integral time constant"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Controller gain",
				:Default=>0.5
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Derivative term SP change filter"
			]),
			time_sec ((Symbol=>Any)[
				:Brief=>"Input filter time constant"
			]),
			time_sec ((Symbol=>Any)[
				:Brief=>"Input filter time constant"
			]),
			[:alpha,:beta,:bias,:derivTime,:intTime,:gain,:gamma,:tau,:tauSet,]
		)
	end
	alpha::positive 
	beta::positive 
	bias::control_signal 
	derivTime::time_sec 
	intTime::time_sec 
	gain::positive 
	gamma::positive 
	tau::time_sec 
	tauSet::time_sec 
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export MParameters
function atributes(in::MParameters,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Model of Parameters to be used with PIDs."
	drive!(fields,_)
	return fields
end
MParameters(_::Dict{Symbol,Any})=begin
	newModel=MParameters()
	newModel.attributes=atributes(newModel,_)
	newModel
end
