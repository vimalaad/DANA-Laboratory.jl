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
type Shell_Pdrop
	Shell_Pdrop()=begin
		new(
			press_delta ((Symbol=>Any)[
				:Brief=>"Ideal Pressure Drop",
				:Symbol=>"\\Delta P_{ideal}",
				:Default=>0.01,
				:Lower=>0,
				:DisplayUnit=>"kPa"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Cross Flow Pressure Drop",
				:Symbol=>"\\Delta P_{CrossFlow}",
				:Default=>0.01,
				:Lower=>0,
				:DisplayUnit=>"kPa"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"End Zones Pressure Drop",
				:Symbol=>"\\Delta P_{EndZones}",
				:Default=>0.01,
				:Lower=>0,
				:DisplayUnit=>"kPa"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Window Pressure Drop",
				:Symbol=>"\\Delta P_{Window}",
				:Default=>0.01,
				:Lower=>1e-10,
				:DisplayUnit=>"kPa"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Inlet Nozzle Pressure Drop",
				:Symbol=>"\\Delta P_{Nozzle\\_In}",
				:Default=>0.01,
				:Lower=>0,
				:DisplayUnit=>"kPa"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Outlet Nozzle Pressure Drop",
				:Symbol=>"\\Delta P_{Nozzle\\_Out}",
				:Default=>0.01,
				:Lower=>0,
				:DisplayUnit=>"kPa"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Total Pressure Drop",
				:Symbol=>"\\Delta P_{Total}",
				:Default=>0.01,
				:Lower=>0,
				:DisplayUnit=>"kPa"
			]),
			fricfactor ((Symbol=>Any)[
				:Brief=>"Friction Factor",
				:Symbol=>"f_i",
				:Default=>0.05,
				:Lower=>1e-10,
				:Upper=>2000
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"Inlet Nozzle Velocity",
				:Symbol=>"V_{Nozzle\\_In}",
				:Default=>1,
				:Upper=>1e5,
				:Lower=>0
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"Outlet Nozzle Velocity",
				:Symbol=>"V_{Nozzle\\_Out}",
				:Default=>1,
				:Upper=>1e5,
				:Lower=>0
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Outlet Nozzle rho-V^2",
				:Default=>1,
				:Upper=>1e6,
				:Unit=>"kg/s^2/m"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Inlet Nozzle rho-V^2",
				:Default=>1,
				:Upper=>1e6,
				:Unit=>"kg/s^2/m"
			]),
			[
				:(Total = CrossFlow+ EndZones + InletNozzle + OutletNozzle + Window),
			],
			[
				"Shell Side Total Pressure Drop",
			],
			[:Ideal,:CrossFlow,:EndZones,:Window,:InletNozzle,:OutletNozzle,:Total,:FricFactor,:Vnozzle_in,:Vnozzle_out,:RVsquare_out,:RVsquare_in,]
		)
	end
	Ideal::press_delta 
	CrossFlow::press_delta 
	EndZones::press_delta 
	Window::press_delta 
	InletNozzle::press_delta 
	OutletNozzle::press_delta 
	Total::press_delta 
	FricFactor::fricfactor 
	Vnozzle_in::velocity 
	Vnozzle_out::velocity 
	RVsquare_out::positive 
	RVsquare_in::positive 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Shell_Pdrop
function setEquationFlow(in::Shell_Pdrop)
	addEquation(1)
end
function atributes(in::Shell_Pdrop,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Pressure drop and velocities in the shell side section of a shell and tube heat exchanger."
	drive!(fields,_)
	return fields
end
Shell_Pdrop(_::Dict{Symbol,Any})=begin
	newModel=Shell_Pdrop()
	newModel.attributes=atributes(newModel,_)
	newModel
end
