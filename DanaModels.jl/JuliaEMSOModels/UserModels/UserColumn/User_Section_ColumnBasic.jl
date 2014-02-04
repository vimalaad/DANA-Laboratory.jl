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
type User_Section_ColumnBasic
	User_Section_ColumnBasic()=begin
		PP=outers.PP
		NComp=outers.NComp
		[
			:(trays([1:NumberOfTrays]).OutletL.T = TopTemperature+(TbottomTemperature-TopTemperature)*(([1:NumberOfTrays]-1)/(NumberOfTrays-1))),
			:(trays([1:NumberOfTrays]).Level = LevelFraction*hw),
			:(trays([1:NumberOfTrays]).OutletL.z([1:NComp-1]) = TopComposition([1:NComp-1]) +(BottomComposition([1:NComp-1])-TopComposition([1:NComp-1]) )*(([1:NumberOfTrays]-1)/(NumberOfTrays-1))),
		],
		[
			"The initial temperature of the trays","The initial Level of the trays","The initial composition of the trays",
		],
		new(
			DanaPlugin ((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of components"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of trays",
				:Default=>8
			]),
			fill(DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of trays",
				:Default=>0,
				:Hidden=>true
			]),(NumberOfTrays)),
			fill(DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of trays",
				:Default=>0,
				:Hidden=>true
			]),(NumberOfTrays)),
			fill(DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of trays",
				:Default=>0,
				:Hidden=>true
			]),(NumberOfTrays)),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Feed tray Location",
				:Default=>2
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Liquid Side Stream Location",
				:Default=>2
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Vapour Side Stream Location",
				:Default=>2
			]),
			acceleration ((Symbol=>Any)[
				:Brief=>"Gravity Acceleration",
				:Default=>9.81,
				:Hidden=>true
			]),
			fill(molweight ((Symbol=>Any)[
				:Brief=>"Component Mol Weight",
				:Hidden=>true
			]),(NComp)),
			DanaSwitcher ((Symbol=>Any)[
				:Valid=>["Reepmeyer", "Feehery_Fv", "Roffel_Fv", "Klingberg", "Wang_Fv", "Elgue"],
				:Default=>"Reepmeyer"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Valid=>["default", "Wang_Fl", "Olsen", "Feehery_Fl", "Roffel_Fl"],
				:Default=>"default"
			]),
			volume ((Symbol=>Any)[
				:Brief=>"Total Volume of the tray"
			]),
			heat_rate ((Symbol=>Any)[
				:Brief=>"Rate of heat supply"
			]),
			area ((Symbol=>Any)[
				:Brief=>"Plate area = Atray - Adowncomer"
			]),
			area ((Symbol=>Any)[
				:Brief=>"Total holes area"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Weir length"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Weir height"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Feeherys correlation coefficient",
				:Unit=>"1/m^4",
				:Default=>1
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Elgues correlation coefficient",
				:Unit=>"kg/m/mol^2",
				:Default=>1
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Olsens correlation coefficient",
				:Default=>1
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Number of liquid passes in the tray",
				:Default=>1
			]),
			temperature(),
			temperature(),
			fraction ((Symbol=>Any)[
				:Brief=>"Level Fraction"
			]),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Component Molar Fraction at Top"
			]),(NComp)),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Component Molar Fraction at Bottom"
			]),(NComp)),
			volume ((Symbol=>Any)[
				:Brief=>"Total Volume of the tray",
				:Hidden=>true
			]),
			heat_rate ((Symbol=>Any)[
				:Brief=>"Rate of heat supply",
				:Hidden=>true
			]),
			area ((Symbol=>Any)[
				:Brief=>"Plate area = Atray - Adowncomer",
				:Hidden=>true
			]),
			area ((Symbol=>Any)[
				:Brief=>"Total holes area",
				:Hidden=>true
			]),
			length ((Symbol=>Any)[
				:Brief=>"Weir length",
				:Hidden=>true
			]),
			length ((Symbol=>Any)[
				:Brief=>"Weir height",
				:Hidden=>true
			]),
			fraction ((Symbol=>Any)[
				:Brief=>"Aeration fraction"
			]),
			fraction ((Symbol=>Any)[
				:Brief=>"Dry pressure drop coefficient"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Feeherys correlation coefficient",
				:Unit=>"1/m^4",
				:Default=>1,
				:Hidden=>true
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Elgues correlation coefficient",
				:Unit=>"kg/m/mol^2",
				:Default=>1,
				:Hidden=>true
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Olsens correlation coefficient",
				:Default=>1,
				:Hidden=>true
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Number of liquid passes in the tray",
				:Default=>1,
				:Hidden=>true
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Valid=>["on", "off"],
				:Default=>"on",
				:Hidden=>true
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Valid=>["on", "off"],
				:Default=>"on",
				:Hidden=>true
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Feed stream",
				:PosX=>0,
				:PosY=>0.55
			]),
			flow_mol ((Symbol=>Any)[
				:Brief=>"Stream Molar Flow Rate"
			]),
			flow_mol ((Symbol=>Any)[
				:Brief=>"Stream Molar Flow Rate"
			]),
			fill(User_tray ((Symbol=>Any)[
				:Brief=>"Number of trays"
			]),(NumberOfTrays)),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Murphree efficiency"
			]),
			[
				:(FeedTray.F*FeedTrayIndex= trays.Inlet.F),
				:(FeedTray.T = trays.Inlet.T),
				:(FeedTray.P = trays.Inlet.P),
				:(FeedTray.z = trays.Inlet.z),
				:(FeedTray.v = trays.Inlet.v),
				:(FeedTray.h = trays.Inlet.h),
				:(trays([1:NumberOfTrays]).OutletV.z = MurphreeEff * (trays([1:NumberOfTrays]).yideal - trays([1:NumberOfTrays]).InletV.z) + trays([1:NumberOfTrays]).InletV.z),
				:(trays([1:NumberOfTrays]).Level = trays([1:NumberOfTrays]).ML*trays([1:NumberOfTrays]).vL/Ap),
				:(V = trays([1:NumberOfTrays]).ML* trays([1:NumberOfTrays]).vL + trays([1:NumberOfTrays]).MV*trays([1:NumberOfTrays]).vV),
				:(trays([1:NumberOfTrays]).E = trays([1:NumberOfTrays]).ML*trays([1:NumberOfTrays]).OutletL.h + trays([1:NumberOfTrays]).MV*trays([1:NumberOfTrays]).OutletV.h - trays([1:NumberOfTrays]).OutletL.P*V),
				:(diff(trays([1:NumberOfTrays]).E) = ( trays([1:NumberOfTrays]).Inlet.F*trays([1:NumberOfTrays]).Inlet.h + trays([1:NumberOfTrays]).InletL.F*trays([1:NumberOfTrays]).InletL.h + trays([1:NumberOfTrays]).InletV.F*trays([1:NumberOfTrays]).InletV.h- trays([1:NumberOfTrays]).OutletL.F*trays([1:NumberOfTrays]).OutletL.h - trays([1:NumberOfTrays]).OutletV.F*trays([1:NumberOfTrays]).OutletV.h -trays([1:NumberOfTrays]).VapourSideStream.F*trays([1:NumberOfTrays]).VapourSideStream.h - trays([1:NumberOfTrays]).LiquidSideStream.F*trays([1:NumberOfTrays]).LiquidSideStream.h + Q )),
				:(trays([1:NumberOfTrays]).OutletL.F*trays([1:NumberOfTrays]).vL = 1.84*"1/s"*lw*((trays([1:NumberOfTrays]).Level-(beta*hw))/(beta))^2),
				:(trays([1:NumberOfTrays]).OutletL.F*trays([1:NumberOfTrays]).vL = 1.84*"m^0.5/s"*lw*((trays([1:NumberOfTrays]).Level-(beta*hw))/(beta))^1.5),
				:(trays([1:NumberOfTrays]).OutletL.F / "mol/s"= lw*Np*trays([1:NumberOfTrays]).rhoL/sum(Mw*trays([1:NumberOfTrays]).OutletV.z)/(0.665*fw)^1.5 * ((trays([1:NumberOfTrays]).ML*sum(Mw*trays([1:NumberOfTrays]).OutletL.z)/trays([1:NumberOfTrays]).rhoL/Ap)-hw)^1.5 * "m^0.5/mol"),
				:(trays([1:NumberOfTrays]).OutletL.F = lw*trays([1:NumberOfTrays]).rhoL/sum(Mw*trays([1:NumberOfTrays]).OutletL.z) * ((trays([1:NumberOfTrays]).Level-hw)/750/"mm")^1.5 * "m^2/s"),
				:(trays([1:NumberOfTrays]).OutletL.F = 2/3*sqrt(2*g)*trays([1:NumberOfTrays]).rhoL/sum(Mw*trays([1:NumberOfTrays]).OutletL.z)*lw*(2*trays([1:NumberOfTrays]).btemp-1)*(trays([1:NumberOfTrays]).ML*sum(Mw*trays([1:NumberOfTrays]).OutletL.z)/(Ap*1.3)/trays([1:NumberOfTrays]).rhoL/(2*trays([1:NumberOfTrays]).btemp-1))^1.5),
				:(trays([1:NumberOfTrays]).OutletL.F = 0 * "mol/h"),
				:(trays([1:NumberOfTrays]).btemp = 1 - 0.3593/"Pa^0.0888545"*abs(trays([1:NumberOfTrays]).OutletV.F*sum(Mw*trays([1:NumberOfTrays]).OutletV.z)/(Ap*1.3)/sqrt(trays([1:NumberOfTrays]).rhoV))^0.177709),
				:(trays([1:NumberOfTrays]).InletV.F*trays([1:NumberOfTrays]).vV = sqrt((trays([1:NumberOfTrays]).InletV.P - trays([1:NumberOfTrays]).OutletV.P)/(trays([1:NumberOfTrays]).rhoV*alfa))*Ah),
				:(trays([1:NumberOfTrays]).InletV.F = trays([1:NumberOfTrays]).rhoV/Ap/w/sum(Mw*trays([1:NumberOfTrays]).OutletV.z) * sqrt(((trays([1:NumberOfTrays]).InletV.P - trays([1:NumberOfTrays]).OutletV.P)-(trays([1:NumberOfTrays]).rhoV*g*trays([1:NumberOfTrays]).ML*trays([1:NumberOfTrays]).vL/Ap))/trays([1:NumberOfTrays]).rhoV)),
				:(trays([1:NumberOfTrays]).InletV.F^1.08 * 0.0013 * "kg/m/mol^1.08/s^0.92*1e5" = (trays([1:NumberOfTrays]).InletV.P - trays([1:NumberOfTrays]).OutletV.P)*1e5 - (beta*sum(trays([1:NumberOfTrays]).M*Mw)/(Ap*1.3)*g*1e5) * (trays([1:NumberOfTrays]).rhoV*Ah/sum(Mw*trays([1:NumberOfTrays]).OutletV.z))^1.08 * "m^1.08/mol^1.08"),
				:(trays([1:NumberOfTrays]).InletV.F * trays([1:NumberOfTrays]).vV = Ap * sqrt(((trays([1:NumberOfTrays]).InletV.P - trays([1:NumberOfTrays]).OutletV.P)-trays([1:NumberOfTrays]).rhoL*g*trays([1:NumberOfTrays]).Level)/trays([1:NumberOfTrays]).rhoV)),
				:(trays([1:NumberOfTrays]).InletV.F * trays([1:NumberOfTrays]).vV = Ap * sqrt(((trays([1:NumberOfTrays]).InletV.P - trays([1:NumberOfTrays]).OutletV.P)-trays([1:NumberOfTrays]).rhoL*g*trays([1:NumberOfTrays]).Level)/trays([1:NumberOfTrays]).rhoV*alfa)),
				:(trays([1:NumberOfTrays]).InletV.F = sqrt((trays([1:NumberOfTrays]).InletV.P - trays([1:NumberOfTrays]).OutletV.P)/btray)),
				:(trays([1:NumberOfTrays]).InletV.F = 0 * "mol/s"),
			],
			[
				"","","","","","","Murphree Efficiency","Level of clear liquid over the weir","Geometry Constraint","Energy Holdup","Energy Balance","Francis Equation","","","","","Low level","","","","","","","","",
			],
			[:PP,:NComp,:NumberOfTrays,:FeedTrayIndex,:LiqSideTrayIndex,:VapSideTrayIndex,:FeedTrayLocation,:LiquidSideStreamLocation,:VapourSideStreamLocation,:g,:Mw,:VapourFlowModel,:LiquidFlowModel,:VolumeOfTray,:HeatSupply,:PlateArea,:HolesArea,:WeirLength,:WeirHeight,:FeeheryCoeff,:ElgueCoeff,:OlsenCoeff,:TrayLiquidPasses,:TopTemperature,:TbottomTemperature,:LevelFraction,:TopComposition,:BottomComposition,:V,:Q,:Ap,:Ah,:lw,:hw,:beta,:alfa,:w,:btray,:fw,:Np,:VapourFlow,:LiquidFlow,],
			[:FeedTray,:VapourDrawOffFlow,:LiquidDrawOffFlow,:trays,:MurphreeEff,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	NumberOfTrays::DanaInteger 
	FeedTrayIndex::Array{DanaInteger }
	LiqSideTrayIndex::Array{DanaInteger }
	VapSideTrayIndex::Array{DanaInteger }
	FeedTrayLocation::DanaInteger 
	LiquidSideStreamLocation::DanaInteger 
	VapourSideStreamLocation::DanaInteger 
	g::acceleration 
	Mw::Array{molweight }
	VapourFlowModel::DanaSwitcher 
	LiquidFlowModel::DanaSwitcher 
	VolumeOfTray::volume 
	HeatSupply::heat_rate 
	PlateArea::area 
	HolesArea::area 
	WeirLength::length 
	WeirHeight::length 
	FeeheryCoeff::DanaReal 
	ElgueCoeff::DanaReal 
	OlsenCoeff::DanaReal 
	TrayLiquidPasses::DanaReal 
	TopTemperature::temperature
	TbottomTemperature::temperature
	LevelFraction::fraction 
	TopComposition::Array{fraction }
	BottomComposition::Array{fraction }
	V::volume 
	Q::heat_rate 
	Ap::area 
	Ah::area 
	lw::length 
	hw::length 
	beta::fraction 
	alfa::fraction 
	w::DanaReal 
	btray::DanaReal 
	fw::DanaReal 
	Np::DanaReal 
	VapourFlow::DanaSwitcher 
	LiquidFlow::DanaSwitcher 
	FeedTray::stream 
	VapourDrawOffFlow::flow_mol 
	LiquidDrawOffFlow::flow_mol 
	trays::Array{User_tray }
	MurphreeEff::DanaReal 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	initials::Array{Expr,1}
	initialNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export User_Section_ColumnBasic
function set(in::User_Section_ColumnBasic)
	FeedTrayIndex(FeedTrayLocation) =1
	 VapSideTrayIndex(FeedTrayLocation) =1
	 LiqSideTrayIndex(FeedTrayLocation) =1
	 Mw = PP.MolecularWeight()
	 V=VolumeOfTray
	 Q=HeatSupply
	 Ap=PlateArea
	 Ah=HolesArea
	 lw=WeirLength
	 hw=WeirHeight
	 w=FeeheryCoeff
	 btray=ElgueCoeff
	 fw=OlsenCoeff
	 Np=TrayLiquidPasses
	 
end
function setEquationFlow(in::User_Section_ColumnBasic)
	# Connecting Trays
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
	let switch=LiquidFlow
		if LiquidFlow==trays(i).Level < (beta *hw)
			set(switch,"off")
		end
		if LiquidFlow==trays(i).Level > (beta * hw) + 1e-6*"m"
			set(switch,"on")
		end
		if switch=="on"
			let switch=LiquidFlowModel
				if switch=="default"
					addEquation(12)
				elseif switch=="Wang_Fl"
					addEquation(13)
				elseif switch=="Olsen"
					addEquation(14)
				elseif switch=="Feehery_Fl"
					addEquation(15)
				elseif switch=="Roffel_Fl"
					addEquation(16)
				end
			end
		elseif switch=="off"
			addEquation(17)
		end
	end
	addEquation(18)
	#/'(kg/m)^0.0888545/s^0.177709';
	let switch=VapourFlow
		if VapourFlow==trays(i).InletV.F < 1e-6 * "kmol/h"
			set(switch,"off")
		end
		if VapourFlow==trays(i).InletV.P > trays(i).OutletV.P + trays(i).Level*g*trays(i).rhoL + 1e-1 * "atm"
			set(switch,"on")
		end
		if switch=="on"
			let switch=VapourFlowModel
				if switch=="Reepmeyer"
					addEquation(19)
				elseif switch=="Feehery_Fv"
					addEquation(20)
				elseif switch=="Roffel_Fv"
					addEquation(21)
				elseif switch=="Klingberg"
					addEquation(22)
				elseif switch=="Wang_Fv"
					addEquation(23)
				elseif switch=="Elgue"
					addEquation(24)
				end
			end
		elseif switch=="off"
			addEquation(25)
		end
	end
end
function initial(in::User_Section_ColumnBasic)
	addEquation(1)
	addEquation(2)
	addEquation(3)
end
function atributes(in::User_Section_ColumnBasic,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
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
User_Section_ColumnBasic(_::Dict{Symbol,Any})=begin
	newModel=User_Section_ColumnBasic()
	newModel.attributes=atributes(newModel,_)
	newModel
end
