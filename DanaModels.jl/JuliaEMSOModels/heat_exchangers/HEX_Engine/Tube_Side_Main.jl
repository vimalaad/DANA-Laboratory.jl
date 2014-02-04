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
type Tube_Side_Main
	Tube_Side_Main()=begin
		new(
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Total Number of Tubes in Shell",
				:Default=>100,
				:Lower=>1
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of Tube Passes",
				:Lower=>1
			]),
			length ((Symbol=>Any)[
				:Brief=>"Effective Tube Length",
				:Lower=>0.1
			]),
			length ((Symbol=>Any)[
				:Brief=>"Tube Pitch",
				:Lower=>1E-8
			]),
			conductivity ((Symbol=>Any)[
				:Brief=>"Tube Wall Material Thermal Conductivity"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Tube Outside Diameter",
				:Lower=>1E-6
			]),
			length ((Symbol=>Any)[
				:Brief=>"Tube Inside Diameter",
				:Lower=>1E-6
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Tubeside Fouling Resistance",
				:Unit=>"m^2*K/kW",
				:Symbol=>"Rf_{tube}",
				:Default=>1E-6 ,
				:Lower=>0
			]),
			length ((Symbol=>Any)[
				:Brief=>"Inlet Nozzle Inside Diameter",
				:Lower=>1E-6
			]),
			length ((Symbol=>Any)[
				:Brief=>"Outlet Nozzle Inside Diameter",
				:Lower=>1E-6
			]),
			Tube_Pdrop ((Symbol=>Any)[
				:Brief=>"Tube Side Pressure Drop",
				:Symbol=>" "
			]),
			Tube_Heat_Transfer ((Symbol=>Any)[
				:Brief=>"Tube Side Heat Transfer",
				:Symbol=>" "
			]),
			Physical_Properties ((Symbol=>Any)[
				:Brief=>"Tube Side Properties",
				:Symbol=>" "
			]),
			[:NumberOfTubes,:Tubepasses,:TubeLength,:TubePitch,:Kwall,:TubeOD,:TubeID,:Fouling,:InletNozzleID,:OutletNozzleID,],
			[:PressureDrop,:HeatTransfer,:Properties,]
		)
	end
	NumberOfTubes::DanaInteger 
	Tubepasses::DanaInteger 
	TubeLength::length 
	TubePitch::length 
	Kwall::conductivity 
	TubeOD::length 
	TubeID::length 
	Fouling::positive 
	InletNozzleID::length 
	OutletNozzleID::length 
	PressureDrop::Tube_Pdrop 
	HeatTransfer::Tube_Heat_Transfer 
	Properties::Physical_Properties 
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Tube_Side_Main
function atributes(in::Tube_Side_Main,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Main variables in the Tube Side section of a shell and tube heat exchanger."
	drive!(fields,_)
	return fields
end
Tube_Side_Main(_::Dict{Symbol,Any})=begin
	newModel=Tube_Side_Main()
	newModel.attributes=atributes(newModel,_)
	newModel
end
