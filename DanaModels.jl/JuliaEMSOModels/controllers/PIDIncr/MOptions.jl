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
type MOptions
	MOptions()=begin
		new(
			DanaReal ((Symbol=>Any)[
				:Brief=>"Controller action: (-1) Direct,(1) Reverse",
				:Default=>-1
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Controller option: (0) Automatic, (1) Manual",
				:Default=>0
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Controller option: (1) output clipped, (0) output unclipped",
				:Default=>1
			]),
			[:action,:autoMan,:clip,]
		)
	end
	action::DanaReal 
	autoMan::DanaReal 
	clip::DanaReal 
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export MOptions
function atributes(in::MOptions,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Model of Options to be used with incremental PIDs."
	drive!(fields,_)
	return fields
end
MOptions(_::Dict{Symbol,Any})=begin
	newModel=MOptions()
	newModel.attributes=atributes(newModel,_)
	newModel
end
