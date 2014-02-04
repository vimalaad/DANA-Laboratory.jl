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
#* File containg user models of columns
#* 
#*
#* The default nomenclature is:
#*		Type_Column_reboilertype_condensertyper
#*
#* where:
#*	Type = refluxed or reboiled or section
#*	Column = Stripping, Absorption, Rectifier, Distillation
#*	Reboiler type (if exists) = kettle or thermosyphon 
#*	Condenser type (if exists) = with subccoling or without subcooling
#* 
#*-----------------------------------------------------------------------
#* Author: Based on Models written by Paula B. Staudt
#* $Id$
#*---------------------------------------------------------------------
# The complete documentation for these models needs to be updated !!!
#----------------------------------------------------------------------
#* Model of a  basic column section with:
#*	- NumberOfTrays=number of trays.
#* 
#*---------------------------------------------------------------------
type User_Section_Column
	User_Section_Column()=begin
		new(
			User_Section_ColumnBasic(),
			vapour_stream ((Symbol=>Any)[
				:Brief=>"Vapour Outlet in the section",
				:PosX=>1,
				:PosY=>0.35,
				:Protected=>true
			]),
			liquid_stream ((Symbol=>Any)[
				:Brief=>"Liquid Outlet in the section",
				:PosX=>1,
				:PosY=>0.65,
				:Protected=>true
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Liquid Inlet in the section",
				:PosX=>0.80,
				:PosY=>0
			]),
			vapour_stream ((Symbol=>Any)[
				:Brief=>"Vapour Outlet in the section",
				:PosX=>0.30,
				:PosY=>0
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Vapour Inlet in the section",
				:PosX=>0.30,
				:PosY=>1
			]),
			liquid_stream ((Symbol=>Any)[
				:Brief=>"Liquid Outlet in the section",
				:PosX=>0.80,
				:PosY=>1
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Liquid connection at the middle trays",
				:PosX=>0.75,
				:PosY=>1,
				:Hidden=>true
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Vapour connection at the middle trays",
				:PosX=>0.55,
				:PosY=>0,
				:Hidden=>true
			]),
			[
				:(LiquidConnector.F= LiquidInlet.F),
				:(LiquidConnector.T = LiquidInlet.T),
				:(LiquidConnector.P = LiquidInlet.P),
				:(LiquidConnector.z = LiquidInlet.z),
				:(LiquidConnector.v = LiquidInlet.v),
				:(LiquidConnector.h = LiquidInlet.h),
				:(VapourConnector.F= VapourInlet.F),
				:(VapourConnector.T = VapourInlet.T),
				:(VapourConnector.P = VapourInlet.P),
				:(VapourConnector.z = VapourInlet.z),
				:(VapourConnector.v = VapourInlet.v),
				:(VapourConnector.h = VapourInlet.h),
				:(LiquidOutlet.F= trays(_P1.NumberOfTrays).OutletL.F),
				:(LiquidOutlet.T = trays(_P1.NumberOfTrays).OutletL.T),
				:(LiquidOutlet.P = trays(_P1.NumberOfTrays).OutletL.P),
				:(LiquidOutlet.z = trays(_P1.NumberOfTrays).OutletL.z),
				:(VapourOutlet.F= trays(1).OutletV.F),
				:(VapourOutlet.T = trays(1).OutletV.T),
				:(VapourOutlet.P = trays(1).OutletV.P),
				:(VapourOutlet.z = trays(1).OutletV.z),
				:(VapourDrawOff.F*_P1.VapSideTrayIndex= trays.VapourSideStream.F),
				:(VapourDrawOff.T = trays(_P1.VapourSideStreamLocation).VapourSideStream.T),
				:(VapourDrawOff.P = trays(_P1.VapourSideStreamLocation).VapourSideStream.P),
				:(VapourDrawOff.z = trays(_P1.VapourSideStreamLocation).VapourSideStream.z),
				:(LiquidDrawOff.F*_P1.LiqSideTrayIndex= trays.LiquidSideStream.F),
				:(LiquidDrawOff.T = trays(_P1.LiquidSideStreamLocation).LiquidSideStream.T),
				:(LiquidDrawOff.P = trays(_P1.LiquidSideStreamLocation).LiquidSideStream.P),
				:(LiquidDrawOff.z = trays(_P1.LiquidSideStreamLocation).LiquidSideStream.z),
				:(VapourDrawOffFlow = VapourDrawOff.F),
				:(LiquidDrawOffFlow = LiquidDrawOff.F),
			],
			[
				"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",
			],
			[:VapourDrawOff,:LiquidDrawOff,:LiquidInlet,:VapourOutlet,:VapourInlet,:LiquidOutlet,:LiquidConnector,:VapourConnector,]
		)
	end
	_P1::User_Section_ColumnBasic
	VapourDrawOff::vapour_stream 
	LiquidDrawOff::liquid_stream 
	LiquidInlet::stream 
	VapourOutlet::vapour_stream 
	VapourInlet::stream 
	LiquidOutlet::liquid_stream 
	LiquidConnector::stream 
	VapourConnector::stream 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export User_Section_Column
function setEquationFlow(in::User_Section_Column)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
	addEquation(7)
	addEquation(8)
	addEquation(9)
	addEquation(10)
	addEquation(11)
	addEquation(12)
	addEquation(13)
	addEquation(14)
	addEquation(15)
	addEquation(16)
	addEquation(17)
	addEquation(18)
	addEquation(19)
	addEquation(20)
	addEquation(21)
	addEquation(22)
	addEquation(23)
	addEquation(24)
	addEquation(25)
	addEquation(26)
	addEquation(27)
	addEquation(28)
	addEquation(29)
	addEquation(30)
end
function atributes(in::User_Section_Column,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/SectionColumn"
	fields[:Brief]="Model of a column section."
	fields[:Info]="== Model of a column section containing ==
* NumberOfTrays trays.
	
== Specify ==
* the feed stream of each tray (Inlet);
* the Murphree eficiency for each tray Emv;
* the InletL stream of the top tray;
* the InletV stream of the bottom tray.
	
== Initial Conditions ==
* the trays temperature (OutletL.T);
* the trays liquid level (Level) OR the trays liquid flow (OutletL.F);
* (NoComps - 1) OutletL (OR OutletV) compositions for each tray.
"
	drive!(fields,_)
	return fields
end
User_Section_Column(_::Dict{Symbol,Any})=begin
	newModel=User_Section_Column()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(User_Section_Column)
