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
type MInternal_Variables
	MInternal_Variables()=begin
		new(
			control_signal ((Symbol=>Any)[
				:Brief=>"Derivative term",
				:Default=>0
			]),
			control_signal ((Symbol=>Any)[
				:Brief=>"Derivative term filtered",
				:Default=>0.5
			]),
			control_signal ((Symbol=>Any)[
				:Brief=>"Error definition for proportional term"
			]),
			control_signal ((Symbol=>Any)[
				:Brief=>"Error definition for derivative term"
			]),
			control_signal ((Symbol=>Any)[
				:Brief=>"Error definition for integral term"
			]),
			control_signal ((Symbol=>Any)[
				:Brief=>"Filtered input"
			]),
			control_signal ((Symbol=>Any)[
				:Brief=>"Integral term",
				:Default=>0
			]),
			control_signal ((Symbol=>Any)[
				:Brief=>"Sum of proportional, integral and derivative terms"
			]),
			control_signal ((Symbol=>Any)[
				:Brief=>"Variable outp scaled between -1 and 1"
			]),
			control_signal ((Symbol=>Any)[
				:Brief=>"Proportional term",
				:Default=>0
			]),
			control_signal ((Symbol=>Any)[
				:Brief=>"Filtered setPoint",
				:Default=>0
			]),
			[:derivTerm,:dFilt,:error,:errorD,:errorI,:inputFilt,:intTerm,:outp,:outps,:propTerm,:setPointFilt,]
		)
	end
	derivTerm::control_signal 
	dFilt::control_signal 
	error::control_signal 
	errorD::control_signal 
	errorI::control_signal 
	inputFilt::control_signal 
	intTerm::control_signal 
	outp::control_signal 
	outps::control_signal 
	propTerm::control_signal 
	setPointFilt::control_signal 
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export MInternal_Variables
function atributes(in::MInternal_Variables,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Model of Internal Variables to be used with PIDs."
	drive!(fields,_)
	return fields
end
MInternal_Variables(_::Dict{Symbol,Any})=begin
	newModel=MInternal_Variables()
	newModel.attributes=atributes(newModel,_)
	newModel
end
