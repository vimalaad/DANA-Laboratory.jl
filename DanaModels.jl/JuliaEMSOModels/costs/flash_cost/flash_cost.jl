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
#*-------------------------------------------------------------------
#* Model of costs for a dynamic flash
#*-------------------------------------------------------------------- 
#* 	- Streams
#*		* a liquid outlet stream
#*		* a vapour outlet stream
#*		* a feed stream
#*
#*	- Assumptions
#*		* both phases are perfectly mixed
#*
#*	- Specify:
#*		* the feed stream;
#*		* the outlet flows: OutletV.F and OutletL.F
#*
#*	- Initial:
#*		* the flash initial temperature (OutletL.T)
#*		* the flash initial liquid level (Ll)
#*		* (NoComps - 1) OutletL (OR OutletV) compositions
#*
#*	- This model is valid if:
#*         369 kg < Equipment Weight (horizontal) < 415000kg
#*	      2210 kg < Equipment Weight (vertical) < 103000kg
#*	      0.92m < Di (horizontal) < 3.66m
#*	      1.83m < Di (vertical) < 3.05m
#*	      3.66m < Flash Length (vertical) < 6.10m
#*----------------------------------------------------------------------
#* Author: N�bia do Carmo Ferreira
#* $Id: flash.mso 118 2007-01-15 18:48:01Z rafael $
#*--------------------------------------------------------------------
type flash_cost
	flash_cost()=begin
		new(
			flash(),
			DanaSwitcher ((Symbol=>Any)[
				:Valid=>["Stainless steell 304", "Stainless steel 316", "Carpenter 20CB_3", "Nickel 200", "Monel 400", "Inconel 600", "Incoloy 825", "Titanium"],
				:Default=>"Stainless steel 304"
			]),
			fill(DanaReal()),
			length ((Symbol=>Any)[
				:Brief=>"Flash Length"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Internal Diameter for vertical vases"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Internal Diameter for horizontal vases"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Thickness"
			]),
			dens_mass ((Symbol=>Any)[
				:Brief=>"Mass Density of the Material"
			]),
			constant ((Symbol=>Any)[
				:Brief=>"Pi Number",
				:Default=>3.14159265
			]),
			currency ((Symbol=>Any)[
				:Brief=>"Capital Cost"
			]),
			currency ((Symbol=>Any)[
				:Brief=>"Basic Cost"
			]),
			currency ((Symbol=>Any)[
				:Brief=>"Cost for stairs, railing and platform"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Cost Factor based on the construction material"
			]),
			mass ((Symbol=>Any)[
				:Brief=>"Equipment Weight"
			]),
			[
				:(Ce = Cb*Fm + Ca),
				:(Cb = "US\$"*exp(Cost(2,1) - Cost(2,2)*ln(Ws/"kg") + Cost(2,3)*(ln(Ws/"kg"))^2)),
				:(Ca = "US\$"*Cost(4,1)*((Div^0.73960)/"m^0.73960")*((flash_length^0.70684)/"m^0.70684")),
				:(Ws = dens_mass_material*Div*(flash_length + Cost(5,1)*Div)*Ts),
				:(Cb = "US\$"*exp(Cost(1,1) - Cost(1,2)*ln(Ws/"kg") + Cost(1,3)*(ln(Ws/"kg"))^2)),
				:(Ca = "US\$"*Cost(3,1)*((Dih^0.20294)/"m^0.20294")),
				:(Ws = dens_mass_material*Dih*(flash_length + Cost(5,1)*Dih)*Ts*Pi),
				:(Fm = Cost(6,1)),
			],
			[
				"Capital Cost","Basic Cost","Cost for stairs, railing and platform","Equipment Weight for vertical vases","Basic Cost for horizontal flash","Cost for stairs, railing and platform","Equipment Weight for horizontal vases","Cost Factor based on the construction material",
			],
			[:Material,:Cost,:flash_length,:Div,:Dih,:Ts,:dens_mass_material,:Pi,],
			[:Ce,:Cb,:Ca,:Fm,:Ws,]
		)
	end
	_P1::flash
	Material::DanaSwitcher 
	Cost::Array{DanaReal}
	flash_length::length 
	Div::length 
	Dih::length 
	Ts::length 
	dens_mass_material::dens_mass 
	Pi::constant 
	Ce::currency 
	Cb::currency 
	Ca::currency 
	Fm::positive 
	Ws::mass 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export flash_cost
function setEquationFlow(in::flash_cost)
	addEquation(1)
	let switch=orientation
		if switch=="vertical"
			addEquation(2)
			addEquation(3)
			addEquation(4)
		elseif switch=="horizontal"
			addEquation(5)
			addEquation(6)
			addEquation(7)
		end
	end
	addEquation(8)
end
function atributes(in::flash_cost,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Flash"
	drive!(fields,_)
	return fields
end
flash_cost(_::Dict{Symbol,Any})=begin
	newModel=flash_cost()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(flash_cost)
