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
type Results_Hairpin
	Results_Hairpin()=begin
		new(
			press_delta ((Symbol=>Any)[
				:Brief=>"Inlet Nozzle Pressure Drop",
				:Default=>0.01,
				:Lower=>1e-10,
				:DisplayUnit=>"kPa"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Outlet Nozzle Pressure Drop",
				:Default=>0.01,
				:Lower=>1e-10,
				:DisplayUnit=>"kPa"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Total Pressure Drop",
				:Default=>0.01,
				:Lower=>0,
				:DisplayUnit=>"kPa",
				:Symbol=>"\\Delta P"
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"Inlet Nozzle Velocity",
				:Default=>1,
				:Upper=>1e5
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"Outlet Nozzle Velocity",
				:Default=>1,
				:Upper=>1e5
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
			heat_trans_coeff ((Symbol=>Any)[
				:Brief=>"Average Film Coefficient",
				:Default=>1,
				:Lower=>1e-12,
				:Upper=>1e6,
				:DisplayUnit=>"W/m^2/K"
			]),
			[:Pdnozzle_in,:Pdnozzle_out,:Pdrop,:Vnozzle_in,:Vnozzle_out,:RVsquare_in,:RVsquare_out,:hcoeff,]
		)
	end
	Pdnozzle_in::press_delta 
	Pdnozzle_out::press_delta 
	Pdrop::press_delta 
	Vnozzle_in::velocity 
	Vnozzle_out::velocity 
	RVsquare_in::positive 
	RVsquare_out::positive 
	hcoeff::heat_trans_coeff 
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Results_Hairpin
function atributes(in::Results_Hairpin,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="to be documented"
	fields[:Info]="to be documented"
	drive!(fields,_)
	return fields
end
Results_Hairpin(_::Dict{Symbol,Any})=begin
	newModel=Results_Hairpin()
	newModel.attributes=atributes(newModel,_)
	newModel
end
