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
#*-----------------------------------------------------------------------
#* Author: N�bia do Carmo Ferreira
#* $Id: column.mso 210 2007-03-15 12:52:28Z arge $
#*---------------------------------------------------------------------
#----------------------------------------------------------------------
#* Model of cost of a distillation column containing:
#*	- NTrays like tray;
#*	- a kettle reboiler;
#*	- dymamic condenser;
#*	- a splitter which separate reflux and distillate;
#*	- a pump in reflux stream;
#*
#*	- This model is valid if:
#*	   0.91m < Di < 7.32m
#*	   17.57m < Lt < 51.82m
#*	   0.6m < D < 4.8m
#*
#*---------------------------------------------------------------------
type Distillation_kettle_cond_cost
	Distillation_kettle_cond_cost()=begin
		new(
			Distillation_kettle_cond(),
			DanaSwitcher ((Symbol=>Any)[
				:Valid=>["Stainless steel 316", "Stainless steel 304", "Carpenter 20 CB_3", "Nickel 200", "Monel 400", "Inconel 600", "Incoloy 825", "Titanium"],
				:Default=>"Stainless steel 304"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Valid=>["Valve", "Grid", "Bubble cap", "Sieve"],
				:Default=>"Valve"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Valid=>["Stainless steel 304", "Stainless steel 316", "Carpenter 20 CB_3", "Monel"],
				:Default=>"Stainless steel 304"
			]),
			fill(DanaReal()),
			length ((Symbol=>Any)[
				:Brief=>"Internal Diameter for the hoof of the towers"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Hoof Length"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Bottom thickness"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Wall thickness"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Tower diameter"
			]),
			dens_mass ((Symbol=>Any)[
				:Brief=>"Mass Density of the Material"
			]),
			constant ((Symbol=>Any)[
				:Brief=>"Pi Number",
				:Default=>3.14159265
			]),
			currency ((Symbol=>Any)[
				:Brief=>"Total Cost of the hoof of the towers"
			]),
			currency ((Symbol=>Any)[
				:Brief=>"Base Cost for the hoof of the distillation tower"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Cost Factor based on the construction material"
			]),
			currency ((Symbol=>Any)[
				:Brief=>"Cost for stairs and platform"
			]),
			currency ((Symbol=>Any)[
				:Brief=>"Base Cost for the trays of the tower"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Cost Factor based on the construction material of the trays"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Cost Factor based on the number of trays in the tower"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Cost Factor based on the type of the tray"
			]),
			currency ((Symbol=>Any)[
				:Brief=>"Total Cost"
			]),
			mass ((Symbol=>Any)[
				:Brief=>"Equipment Weight"
			]),
			[
				:(Cs = Cb*Fm),
				:(Cb = "US\$"*exp(Cost(1,1) + Cost(1,2)*ln(Ws/"kg") + Cost(1,3)*(ln(Ws/"kg"))^2 + Cost(1,4)*(Lt/Di)*(ln(Tb/Tp)))),
				:(Cpl = "US\$"*Cost(2,1)*(Di^0.63316)/"m^0.63316"*(Lt^0.80161)/"m^0.80161"),
				:(Cbt = "US\$"*Cost(6,1)*exp(Cost(6,2)*D/"m")),
				:(Ftm = Cost(7,1) + Cost(7,2)*D/"m"),
				:(Ftm = Cost(8,1) + Cost(8,2)*D/"m"),
				:(Ftm = Cost(9,1) + Cost(9,2)*D/"m"),
				:(Ftm = Cost(10,1) + Cost(10,2)*D/"m"),
				:(Fnt = Cost(11,1)/(Cost(11,2))^_P1.NTrays),
				:(Ct = Cb*Fm + _P1.NTrays*Cbt*Ftm*Ftt*Fnt + Cpl),
				:(Ftt = Cost(12,1)),
				:(Fm = Cost(5,1)),
				:(Ws = dens_mass_material*Di*(Lt + 0.8116*Di)*Tp*Pi),
			],
			[
				"Total Cost of the hoof of the towers","Base Cost for the hoof of the distillation tower","Cost for stairs and platform","Base Cost for the trays of the tower","Cost Factor based on the construction material of the trays","Cost Factor based on the construction material of the trays","Cost Factor based on the construction material of the trays","Cost Factor based on the construction material of the trays","Cost Factor based on the number of trays in the tower","Total Cost","Cost Factor based on the type of the tray","Cost Factor based on the construction material","Equipment Weight",
			],
			[:Material,:Tray_Type,:Tray_Material,:Cost,:Di,:Lt,:Tb,:Tp,:D,:dens_mass_material,:Pi,],
			[:Cs,:Cb,:Fm,:Cpl,:Cbt,:Ftm,:Fnt,:Ftt,:Ct,:Ws,]
		)
	end
	_P1::Distillation_kettle_cond
	Material::DanaSwitcher 
	Tray_Type::DanaSwitcher 
	Tray_Material::DanaSwitcher 
	Cost::Array{DanaReal}
	Di::length 
	Lt::length 
	Tb::length 
	Tp::length 
	D::length 
	dens_mass_material::dens_mass 
	Pi::constant 
	Cs::currency 
	Cb::currency 
	Fm::positive 
	Cpl::currency 
	Cbt::currency 
	Ftm::positive 
	Fnt::positive 
	Ftt::positive 
	Ct::currency 
	Ws::mass 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Distillation_kettle_cond_cost
function setEquationFlow(in::Distillation_kettle_cond_cost)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	let switch=Tray_Material
		if switch=="Stainless steel 304"
			addEquation(5)
		elseif switch=="Stainless steel 316"
			addEquation(6)
		elseif switch=="Carpenter 20 CB_3"
			addEquation(7)
		elseif switch=="Monel"
			addEquation(8)
		end
	end
	addEquation(9)
	addEquation(10)
	addEquation(11)
	addEquation(12)
	addEquation(13)
end
function atributes(in::Distillation_kettle_cond_cost,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/DistillationKettleCond"
	fields[:Brief]="Model of a distillation column with dynamic condenser and dynamic reboiler."
	fields[:Info]="== Specify ==
* the feed stream of each tray (Inlet);
* the Murphree eficiency for each tray Emv;
* the pump pressure difference;
* the heat supllied in reboiler and condenser;
* the condenser vapor outlet flow (OutletV.F);
* the reboiler liquid outlet flow (OutletL.F);
* both splitter outlet flows OR one of the splitter outlet flows and the splitter frac.
* all necessary dimensions and materials for cost evaluation
	
== Initial Conditions ==
* the trays temperature (OutletL.T);
* the trays liquid level (Level) OR the trays liquid flow (OutletL.F);
* (NoComps - 1) OutletL (OR OutletV) compositions for each tray;
	
* the condenser temperature (OutletL.T);
* the condenser liquid level (Level);
* (NoComps - 1) OutletL (OR OutletV) compositions;
	
* the reboiler temperature (OutletL.T);
* the reboiler liquid level (Level);
* (NoComps - 1) OutletL (OR OutletV) compositions.
"
	drive!(fields,_)
	return fields
end
Distillation_kettle_cond_cost(_::Dict{Symbol,Any})=begin
	newModel=Distillation_kettle_cond_cost()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(Distillation_kettle_cond_cost)
