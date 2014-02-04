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
type Tube_Pdrop
	Tube_Pdrop()=begin
		new(
			press_delta ((Symbol=>Any)[
				:Brief=>"Tube Pressure Drop due to friction",
				:Symbol=>"\\Delta P_{tube}",
				:Default=>0.01,
				:Lower=>1E-10,
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
				:Symbol=>"\\Delta P_{total}",
				:Default=>0.01,
				:Lower=>1E-10,
				:DisplayUnit=>"kPa"
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
				:Upper=>1E5,
				:Lower=>0
			]),
			fricfactor ((Symbol=>Any)[
				:Brief=>"Friction Factor",
				:Symbol=>"f_i",
				:Default=>0.05,
				:Lower=>1e-10,
				:Upper=>2000
			]),
			[
				:(Total = TubeFriction + InletNozzle + OutletNozzle),
			],
			[
				"Total Pressure Drop",
			],
			[:TubeFriction,:InletNozzle,:OutletNozzle,:Total,:Vnozzle_in,:Vnozzle_out,:FricFactor,]
		)
	end
	TubeFriction::press_delta 
	InletNozzle::press_delta 
	OutletNozzle::press_delta 
	Total::press_delta 
	Vnozzle_in::velocity 
	Vnozzle_out::velocity 
	FricFactor::fricfactor 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Tube_Pdrop
function setEquationFlow(in::Tube_Pdrop)
	addEquation(1)
end
function atributes(in::Tube_Pdrop,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Pressure drop and velocities in the tube side section of a shell and tube heat exchanger."
	drive!(fields,_)
	return fields
end
Tube_Pdrop(_::Dict{Symbol,Any})=begin
	newModel=Tube_Pdrop()
	newModel.attributes=atributes(newModel,_)
	newModel
end
