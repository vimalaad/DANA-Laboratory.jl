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
#*
#*----------------------------------------------------------------------
#* Author: Based on Models written by Paula B. Staudt
#* $Id$
#*--------------------------------------------------------------------
# The complete documentation for these models needs to be updated !!!
type User_tray
	User_tray()=begin
		new(
			User_trayBasic(),
			dens_mass(),
			dens_mass(),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Temporary variable of Roffels liquid flow equation"
			]),
			[
				:(rhoL = _P1.PP.LiquidDensity(_P1.OutletL.T, _P1.OutletL.P, _P1.OutletL.z)),
				:(rhoV = _P1.PP.VapourDensity(_P1.InletV.T, _P1.InletV.P, _P1.InletV.z)),
			],
			[
				"Liquid Density","Vapour Density",
			],
			[:rhoL,:rhoV,:btemp,]
		)
	end
	_P1::User_trayBasic
	rhoL::dens_mass
	rhoV::dens_mass
	btemp::DanaReal 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export User_tray
function setEquationFlow(in::User_tray)
	addEquation(1)
	addEquation(2)
end
function atributes(in::User_tray,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Icon]="icon/Tray"
	fields[:Brief]="Description of a column tray."
	fields[:Info]="To be updated"
	drive!(fields,_)
	return fields
end
User_tray(_::Dict{Symbol,Any})=begin
	newModel=User_tray()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(User_tray)
