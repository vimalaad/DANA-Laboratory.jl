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
#* Model of costs for tanks
#*-------------------------------------------------------------------- 
#*	Streams:
#*		* an inlet stream
#*		* an outlet stream
#*
#*	Specify:
#*		* the Inlet stream
#*		* the Outlet flow
#*		* the tank Q
#*
#*	Initial:
#*		* the tank temperature (OutletL.T)
#*		* the tank level (h)
#*		* (NoComps - 1) Outlet compositions
#*----------------------------------------------------------------------
#* Author: N�bia do Carmo Ferreira
#* $Id: tank.mso 210 2007-03-15 12:52:28Z arge $
#*--------------------------------------------------------------------
type tank_cost
	tank_cost()=begin
		new(
			tank(),
			DanaSwitcher ((Symbol=>Any)[
				:Valid=>["Stainless steel 316", "Stainless steel 304", "Stainless steel 347", "Nickel", "Monel", "Inconel", "Zirconium", "Titanium", "Brick_and_rubber", "Brick_and_polyester_lined steel", "Rubber", "Lead_lined steel", "Polyester" ,"Fiberglass_strengthened", "Aluminum", "Copper", "Concrete"],
				:Default=>"Stainless steel 316"
			]),
			fill(DanaReal()),
			length((Symbol=>Any)[
				:Brief=>"Tank height"
			]),
			currency ((Symbol=>Any)[
				:Brief=>"Capital Cost"
			]),
			currency ((Symbol=>Any)[
				:Brief=>"Basic Cost"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Cost Factor based on the construction material"
			]),
			volume ((Symbol=>Any)[
				:Brief=>"Total Volume"
			]),
			[
				:(V = _P1.Across * Height),
				:(Ce = Cb*Fm),
				:(Cb = "US\$"*exp(Cost(1,1) + Cost(1,2)*ln(V/"m^3") + Cost(1,3)*(ln(V/"m^3"))^2)),
				:(Cb = "US\$"*exp(Cost(1,1) + Cost(1,2)*ln(V/"m^3") + Cost(1,3)*(ln(V/"m^3"))^2)),
				:(Cb = "US\$"*exp(Cost(2,1) + Cost(2,2)*ln(V/"m^3") + Cost(2,3)*(ln(V/"m^3"))^2)),
				:(Cb = "US\$"*exp(Cost(2,1) + Cost(2,2)*ln(V/"m^3") + Cost(2,3)*(ln(V/"m^3"))^2)),
				:(Fm = Cost(3,1) + Cost(3,2) + Cost(3,3)),
			],
			[
				"Total Volume","Capital Cost","Basic Cost","tank bought soon","the tank manufactured in the plant","","Cost Factor based on the construction material",
			],
			[:Material,:Cost,:Height,],
			[:Ce,:Cb,:Fm,:V,]
		)
	end
	_P1::tank
	Material::DanaSwitcher 
	Cost::Array{DanaReal}
	Height::length
	Ce::currency 
	Cb::currency 
	Fm::positive 
	V::volume 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export tank_cost
function setEquationFlow(in::tank_cost)
	addEquation(1)
	addEquation(2)
	if V < 5 * "m^3" 
		addEquation(3)
		#verificar
		
	else
		if 5 * "m^3" > V && V < 80 * "m^3" 
			addEquation(4)
		else
			if 80 * "m^3" > V && V < 45000 * "m^3" 
				addEquation(5)
			else
				addEquation(6)
				#verificar
				
			end
		end
	end
	addEquation(7)
end
function atributes(in::tank_cost,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Tank"
	drive!(fields,_)
	return fields
end
tank_cost(_::Dict{Symbol,Any})=begin
	newModel=tank_cost()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(tank_cost)
