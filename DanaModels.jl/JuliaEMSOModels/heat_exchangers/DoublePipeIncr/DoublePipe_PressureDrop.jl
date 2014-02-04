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
#* $Id: DoublePipeIncr.mso								$
#*------------------------------------------------------------------
type DoublePipe_PressureDrop
	DoublePipe_PressureDrop()=begin
		N=outers.N
		Npoints=outers.Npoints
		new(
			length ((Symbol=>Any)[
				:Brief=>"Hydraulic Diameter of Pipe for Pressure Drop",
				:Lower=>1e-6
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of zones",
				:Default=>2
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of incremental points",
				:Default=>3
			]),
			fill(pressure ((Symbol=>Any)[
				:Brief=>"Incremental Local  Pressure",
				:Default=>1,
				:Lower=>1e-10,
				:Upper=>2e4,
				:DisplayUnit=>"kPa"
			]),(Npoints)),
			press_delta ((Symbol=>Any)[
				:Brief=>"Total Pressure Drop",
				:Default=>0.01,
				:Lower=>0,
				:DisplayUnit=>"kPa",
				:Symbol=>"\\Delta P"
			]),
			fill(press_delta ((Symbol=>Any)[
				:Brief=>"Incremental Pressure Drop for friction",
				:Default=>0.01,
				:Lower=>0,
				:DisplayUnit=>"kPa",
				:Symbol=>"\\Delta P_{fric}"
			]),(Npoints)),
			fill(fricfactor ((Symbol=>Any)[
				:Brief=>"Incremental Friction Factor",
				:Default=>0.05,
				:Lower=>1e-10,
				:Upper=>2000
			]),(N)),
			fill(positive ((Symbol=>Any)[
				:Brief=>"Incremental Reynolds Number",
				:Default=>100,
				:Lower=>1
			]),(N)),
			press_delta ((Symbol=>Any)[
				:Brief=>"Inlet Nozzle Pressure Drop",
				:Default=>0.01,
				:Lower=>0,
				:DisplayUnit=>"kPa"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Outlet Nozzle Pressure Drop",
				:Default=>0.01,
				:Lower=>0,
				:DisplayUnit=>"kPa"
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"Inlet Nozzle Velocity",
				:Default=>1,
				:Upper=>1e5,
				:Lower=>0
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"Outlet Nozzle Velocity",
				:Default=>1,
				:Upper=>1e5,
				:Lower=>0
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Inlet Nozzle rho-V^2",
				:Default=>1,
				:Upper=>1e6,
				:Unit=>"kg/s^2/m"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Outlet Nozzle rho-V^2",
				:Default=>1,
				:Upper=>1e6,
				:Unit=>"kg/s^2/m"
			]),
			[:Dh,:N,:Npoints,],
			[:Plocal,:Pdrop,:Pd_fric,:fi,:Re,:Pdnozzle_in,:Pdnozzle_out,:Vnozzle_in,:Vnozzle_out,:RVsquare_in,:RVsquare_out,]
		)
	end
	Dh::length 
	N::DanaInteger 
	Npoints::DanaInteger 
	Plocal::Array{pressure }
	Pdrop::press_delta 
	Pd_fric::Array{press_delta }
	fi::Array{fricfactor }
	Re::Array{positive }
	Pdnozzle_in::press_delta 
	Pdnozzle_out::press_delta 
	Vnozzle_in::velocity 
	Vnozzle_out::velocity 
	RVsquare_in::positive 
	RVsquare_out::positive 
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
