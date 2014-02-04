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
#* Model of costs for a reboiler
#*-------------------------------------------------------------------- 
#*
#*	Streams:
#*		* a liquid inlet stream
#*		* a liquid outlet stream
#*		* a vapour outlet stream
#*		* a feed stream
#*
#*	Assumptions:
#*		* perfect mixing of both phases
#*		* thermodynamics equilibrium
#*		* no liquid entrainment in the vapour stream
#*
#*	Specify:
#*		* the Feed stream
#*		* the Liquid inlet stream
#*		* the outlet flows: OutletV.F and OutletL.F
#*
#*	Initial:
#*		* the reboiler temperature (OutletL.T)
#*		* the reboiler liquid level (Ll)
#*		* (NoComps - 1) OutletL (OR OutletV) compositions
#*
#*	- This Model is valid if 14m^2 < Across < 1100 m^2
#*
#*----------------------------------------------------------------------
#* Author: N�bia do Carmo Ferreira
#* $Id: reboiler.mso 210 2007-03-15 12:52:28Z arge $
#*--------------------------------------------------------------------
type reboiler_cost
	reboiler_cost()=begin
		new(
			reboiler(),
			DanaSwitcher ((Symbol=>Any)[
				:Valid=>["Stainless steel 316", "Stainless steel 304", "Stainless steel 347", "Nickel 200", "Monel 400", "Inconel 600", "Incoloy 825", "Titanium", "Hastelloy"],
				:Default=>"Stainless steel 316"
			]),
			fill(DanaReal()),
			currency ((Symbol=>Any)[
				:Brief=>"Capital Cost"
			]),
			currency ((Symbol=>Any)[
				:Brief=>"Basic Cost"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Cost Factor based on the type of the heat exchanger"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Cost Factor based on the project pressure"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Cost Factor based on the construction material"
			]),
			pressure ((Symbol=>Any)[
				:Brief=>"Average pressure"
			]),
			[
				:(P = 0.5*(_P1.InletL.P + _P1.OutletL.P)),
				:(Ce = Cb*Fd*Fp*Fm),
				:(Cb = "US\$"*exp(Cost(1,1) + Cost(1,2)*ln(_P1.Across/"m^2") + Cost(1,3)*(ln(_P1.Across/"m^2"))^2)),
				:(Fd = exp(Cost(3,1) + Cost(3,2)*ln(_P1.Across/"m^2") + Cost(3,3)*ln(_P1.Across/"m^2"))),
				:(Fp = Cost(5,1) + Cost(5,2)*ln(_P1.Across/"m^2")),
				:(Fp = Cost(5,1) + Cost(5,2)*ln(_P1.Across/"m^2")),
				:(Fp = Cost(6,1) + Cost(6,2)*ln(_P1.Across/"m^2")),
				:(Fp = Cost(7,1) + Cost(7,2)*ln(_P1.Across/"m^2")),
				:(Fp = Cost(7,1) + Cost(7,2)*ln(_P1.Across/"m^2")),
				:(Fm = Cost(8,1) + Cost(8,2)*ln(_P1.Across/"m^2")),
			],
			[
				"Average pressure","Capital Cost","Basic Cost","Cost Factor based on the type of the heat exchanger","Cost Factor based on the project pressure","","","","","Cost Factor based on the construction material",
			],
			[:Material,:Cost,],
			[:Ce,:Cb,:Fd,:Fp,:Fm,:P,]
		)
	end
	_P1::reboiler
	Material::DanaSwitcher 
	Cost::Array{DanaReal}
	Ce::currency 
	Cb::currency 
	Fd::positive 
	Fp::positive 
	Fm::positive 
	P::pressure 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export reboiler_cost
function setEquationFlow(in::reboiler_cost)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	if P <= 700 * "kPa" 
		# verificar
		addEquation(5)
	else
		if 700 * "kPa" < P && P < 2100 * "kPa" 
			addEquation(6)
		else
			if 2100 * "kPa" < P && P < 4200 * "kPa" 
				addEquation(7)
			else
				if 4200 * "kPa" < P && P < 6200 * "kPa" 
					addEquation(8)
				else
					addEquation(9)
					# verificar
					
				end
			end
		end
	end
	addEquation(10)
end
function atributes(in::reboiler_cost,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Reboiler"
	drive!(fields,_)
	return fields
end
reboiler_cost(_::Dict{Symbol,Any})=begin
	newModel=reboiler_cost()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(reboiler_cost)
