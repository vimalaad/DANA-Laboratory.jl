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
#* Author: Gerson Balbueno Bicca 
#* $Id: Heatex.mso 574 2008-07-25 14:18:50Z rafael $
#*--------------------------------------------------------------------
type Heatex_NTU
	Heatex_NTU()=begin
		new(
			Heatex_Basic(),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Type of Heat Exchanger",
				:Valid=>["Counter Flow","Cocurrent Flow", "Shell and Tube"],
				:Default=>"Cocurrent Flow"
			]),
			NTU_Basic ((Symbol=>Any)[
				:Brief=>"NTU Method of Calculation",
				:Symbol=>" "
			]),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Liquid Molar Fraction in Hot Side",
				:Hidden=>true
			]),(NComp)),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Vapour Molar Fraction in Hot Side",
				:Hidden=>true
			]),(NComp)),
			fraction ((Symbol=>Any)[
				:Brief=>"Vapour Fraction in Hot Side",
				:Hidden=>true
			]),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Liquid Molar Fraction in Cold Side",
				:Hidden=>true
			]),(NComp)),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Vapour Molar Fraction in Cold Side",
				:Hidden=>true
			]),(NComp)),
			fraction ((Symbol=>Any)[
				:Brief=>"Vapour Fraction in Cold Side",
				:Hidden=>true
			]),
			[
				:([vh, xh, yh] = _P1.PP.Flash(_P1.InletHot.T, _P1.InletHot.P, _P1.InletHot.z)),
				:([vc, xc, yc] = _P1.PP.Flash(_P1.InletCold.T, _P1.InletCold.P, _P1.InletCold.z)),
				:(Method.NTU*Method.Cmin = U*A),
				:(Method.Cmin = min([Method.Ch,Method.Cc])),
				:(Method.Cmax = max([Method.Ch,Method.Cc])),
				:(Method.Cr = Method.Cmin/Method.Cmax),
				:(Q = Method.Eft*Method.Cmin*(_P1.InletHot.T-_P1.InletCold.T)),
				:(Method.Ch = _P1.InletHot.F*((1-_P1.InletHot.v)*_P1.PP.LiquidCp(0.5*_P1.InletHot.T+0.5*_P1.OutletHot.T,0.5*_P1.InletHot.P+0.5*_P1.OutletHot.P,xh)+ _P1.InletHot.v*_P1.PP.VapourCp(0.5*_P1.InletHot.T+0.5*_P1.OutletHot.T,0.5*_P1.InletHot.P+0.5*_P1.OutletHot.P,yh))),
				:(Method.Cc = _P1.InletCold.F*((1-_P1.InletCold.v)*_P1.PP.LiquidCp(0.5*_P1.InletCold.T+0.5*_P1.OutletCold.T,0.5*_P1.InletCold.P+0.5*_P1.OutletCold.P,xc)+ _P1.InletCold.v*_P1.PP.VapourCp(0.5*_P1.InletCold.T+0.5*_P1.OutletCold.T,0.5*_P1.InletCold.P+0.5*_P1.OutletCold.P,yc))),
				:(Method.Eft1 = 1),
				:(Method.Eft = 1-exp(-Method.NTU)),
				:(Method.Eft = (1-exp(-Method.NTU*(1+Method.Cr)))/(1+Method.Cr)),
				:(Method.Eft = Method.NTU/(1+Method.NTU)),
				:(Method.Eft = (1-exp(-Method.NTU*(1-Method.Cr)))/(1-Method.Cr*exp(-Method.NTU*(1-Method.Cr)))),
				:(Method.Eft = 2*(1+Method.Cr+sqrt(1+Method.Cr^2)*((1+exp(-Method.NTU*sqrt(1+Method.Cr^2)))/(1-exp(-Method.NTU*sqrt(1+Method.Cr^2)))) )^(-1)),
			],
			[
				"Flash Calculation in Hot Side","Flash Calculation in Cold Side","Number of Units Transference","Minimum Heat Capacity","Maximum Heat Capacity","Thermal Capacity Ratio","Duty","Hot Stream Average Heat Capacity","Cold Stream Average Heat Capacity","Effectiveness Correction","Effectiveness","Effectiveness in Cocurrent Flow","Effectiveness in Counter Flow","Effectiveness in Counter Flow","TEMA E Shell Effectiveness",
			],
			[:ExchangerType,],
			[:Method,:xh,:yh,:vh,:xc,:yc,:vc,]
		)
	end
	_P1::Heatex_Basic
	ExchangerType::DanaSwitcher 
	Method::NTU_Basic 
	xh::Array{fraction }
	yh::Array{fraction }
	vh::fraction 
	xc::Array{fraction }
	yc::Array{fraction }
	vc::fraction 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Heatex_NTU
function setEquationFlow(in::Heatex_NTU)
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
	if Method.Cr == 0 
		addEquation(11)
	else
		let switch=ExchangerType
			if switch=="Cocurrent Flow"
				addEquation(12)
			elseif switch=="Counter Flow"
				if Method.Cr == 1 
					addEquation(13)
				else
					addEquation(14)
				end
			elseif switch=="Shell and Tube"
				addEquation(15)
			end
		end
	end
end
function atributes(in::Heatex_NTU,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/HeatExchanger_NTU"
	fields[:Brief]="Simplified model for Heat Exchangers"
	fields[:Info]="This model perform material and heat balance using the NTU-Effectiveness Approach. 
This shortcut calculation does not require exchanger configuration or geometry data.

== Assumptions ==
* Steady-State operation;
* No heat loss to the surroundings.

== Specify ==
* The Inlet streams: Hot and Cold.

== References ==
[1] E.A.D. Saunders, Heat Exchangers: Selection, Design and
 Construction, Longman, Harlow, 1988. 

"
	drive!(fields,_)
	return fields
end
Heatex_NTU(_::Dict{Symbol,Any})=begin
	newModel=Heatex_NTU()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(Heatex_NTU)
