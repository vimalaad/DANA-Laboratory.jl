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
type DoublePipe_PressureDrop
	DoublePipe_PressureDrop()=begin
		new(
			length ((Symbol=>Any)[
				:Brief=>"Hydraulic Diameter of Pipe for Pressure Drop",
				:Lower=>1e-6
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Total Pressure Drop",
				:Default=>0.01,
				:Lower=>0,
				:DisplayUnit=>"kPa",
				:Symbol=>"\\Delta P"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Pressure Drop for friction",
				:Default=>0.01,
				:Lower=>0,
				:DisplayUnit=>"kPa",
				:Symbol=>"\\Delta P_{fric}"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Pressure Drop due to return",
				:Default=>0.01,
				:Lower=>0,
				:DisplayUnit=>"kPa",
				:Symbol=>"\\Delta P_{return}"
			]),
			fricfactor ((Symbol=>Any)[
				:Brief=>"Friction Factor",
				:Default=>0.05,
				:Lower=>1e-10,
				:Upper=>2000
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Reynolds Number",
				:Default=>100,
				:Lower=>1
			]),
			[:Dh,],
			[:Pdrop,:Pd_fric,:Pd_ret,:fi,:Re,]
		)
	end
	Dh::length 
	Pdrop::press_delta 
	Pd_fric::press_delta 
	Pd_ret::press_delta 
	fi::fricfactor 
	Re::positive 
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export DoublePipe_PressureDrop
function atributes(in::DoublePipe_PressureDrop,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="to be documented"
	fields[:Info]="to be documented"
	drive!(fields,_)
	return fields
end
DoublePipe_PressureDrop(_::Dict{Symbol,Any})=begin
	newModel=DoublePipe_PressureDrop()
	newModel.attributes=atributes(newModel,_)
	newModel
end
