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
#*--------------------------------------------------------------------
#* Author: N�bia do Carmo Ferreira 
#* $Id: HeatExchangerDetailed.mso 197 2007-03-08 14:31:57Z bicca $
#*------------------------------------------------------------------
# This model is valid if 14m^2 < A < 1100 m^2
type HeatExchanger_NTU_cost
	HeatExchanger_NTU_cost()=begin
		new(
			Heatex_NTU(),
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
				:Brief=>"Average  Pressure"
			]),
			[
				:(Pmax = max( [_P1._P1.OutletHot.P , _P1._P1.OutletCold.P] )),
				:(Ce = Cb*Fd*Fp*Fm),
				:(Cb = "US\$"*exp(Cost(1,1) + Cost(1,2)*ln(A/"m^2") + Cost(1,3)*(ln(A/"m^2"))^2)),
				:(Fd = exp(Cost(2,1) + Cost(2,2)*ln(A/"m^2") + Cost(2,3)*ln(A/"m^2"))),
				:(Fp = Cost(5,1) + Cost(5,2)*ln(A/"m^2")),
				:(Fp = Cost(5,1) + Cost(5,2)*ln(A/"m^2")),
				:(Fp = Cost(6,1) + Cost(6,2)*ln(A/"m^2")),
				:(Fp = Cost(7,1) + Cost(7,2)*ln(A/"m^2")),
				:(Fp = Cost(7,1) + Cost(7,2)*ln(A/"m^2")),
				:(Fm = Cost(8,1) + Cost(8,2)*ln(A/"m^2")),
			],
			[
				"Average pressure","Capital Cost","Basic Cost","Cost Factor based on the type of the heat exchanger","Cost Factor based on the project pressure","","","","","Cost Factor based on the construction material",
			],
			[:Material,:Cost,],
			[:Ce,:Cb,:Fd,:Fp,:Fm,:Pmax,]
		)
	end
	_P1::Heatex_NTU
	Material::DanaSwitcher 
	Cost::Array{DanaReal}
	Ce::currency 
	Cb::currency 
	Fd::positive 
	Fp::positive 
	Fm::positive 
	Pmax::pressure 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export HeatExchanger_NTU_cost
function setEquationFlow(in::HeatExchanger_NTU_cost)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	if Pmax <= 700 * "kPa" 
		# verificar
		addEquation(5)
	else
		if 700 * "kPa" < Pmax && Pmax < 2100 * "kPa" 
			addEquation(6)
		else
			if 2100 * "kPa" < Pmax && Pmax < 4200 * "kPa" 
				addEquation(7)
			else
				if 4200 * "kPa" < Pmax && Pmax < 6200 * "kPa" 
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
function atributes(in::HeatExchanger_NTU_cost,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/HeatExchanger_NTU"
	fields[:Brief]="Heat Exchanger Block - NTU Method"
	fields[:Info]="to be documented."
	drive!(fields,_)
	return fields
end
HeatExchanger_NTU_cost(_::Dict{Symbol,Any})=begin
	newModel=HeatExchanger_NTU_cost()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(HeatExchanger_NTU_cost)
