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
#*------------------------------------------------------------------
type DoublePipe_NTU
	DoublePipe_NTU()=begin
		new(
			DoublePipe_Basic(),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Flow Direction",
				:Valid=>["counter","cocurrent"],
				:Default=>"cocurrent"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Effectiveness estimate",
				:Default=>0.5
			]),
			NTU_Basic ((Symbol=>Any)[
				:Brief=>"NTU Method of Calculation",
				:Symbol=>" "
			]),
			[
				:(Method.Eft1 = 1),
				:(Method.NTU*Method.Cmin = _P1.Details.Ud*_P1.Geometry.Pi*_P1.Geometry.DoInner*_P1.Geometry.Lpipe),
				:(Method.Cmin = min([Method.Ch,Method.Cc])),
				:(Method.Cmax = max([Method.Ch,Method.Cc])),
				:(Method.Cr = Method.Cmin/Method.Cmax),
				:(Method.Eft = 1-exp(-Method.NTU)),
				:(Method.Eft = (1-exp(-Method.NTU*(1+Method.Cr)))/(1+Method.Cr)),
				:(Method.Eft = Method.NTU/(1+Method.NTU)),
				:(Method.Eft = (1-exp(-Method.NTU*(1-Method.Cr)))/(1-Method.Cr*exp(-Method.NTU*(1-Method.Cr)))),
				:(Method.NTU = 1),
				:(Method.Cmin = min([Method.Ch,Method.Cc])),
				:(Method.Cmax = max([Method.Ch,Method.Cc])),
				:(Method.Cr = 1),
				:(Method.Eft = Eftestimated),
				:(_P1.Details.Q = Method.Eft*Method.Cmin*(_P1.InletOuter.T-_P1.InletInner.T)),
				:(_P1.Details.Q = _P1.Qestimated),
				:(Method.Ch = _P1.InletOuter.F*_P1.Outer.Properties.Average.Cp),
				:(Method.Cc = _P1.InletInner.F*_P1.Inner.Properties.Average.Cp),
				:(_P1.Details.Q = Method.Eft*Method.Cmin*(_P1.InletInner.T-_P1.InletOuter.T)),
				:(_P1.Details.Q = _P1.Qestimated),
				:(Method.Cc = _P1.InletOuter.F*_P1.Outer.Properties.Average.Cp),
				:(Method.Ch = _P1.InletInner.F*_P1.Inner.Properties.Average.Cp),
			],
			[
				"Effectiveness Correction","Number of Units Transference","Minimum Heat Capacity","Maximum Heat Capacity","Thermal Capacity Ratio","Effectiveness","Effectiveness in Cocurrent Flow","Effectiveness in Counter Flow","Effectiveness in Counter Flow","Number of Units Transference","Minimum Heat Capacity","Maximum Heat Capacity","Thermal Capacity Ratio","Effectiveness","Duty","Duty","Hot Stream Heat Capacity","Cold Stream Heat Capacity","Duty","Duty","Cold Stream Heat Capacity","Hot Stream Heat Capacity",
			],
			[:FlowDirection,:Eftestimated,],
			[:Method,]
		)
	end
	_P1::DoublePipe_Basic
	FlowDirection::DanaSwitcher 
	Eftestimated::positive 
	Method::NTU_Basic 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export DoublePipe_NTU
function setEquationFlow(in::DoublePipe_NTU)
	addEquation(1)
	let switch=CalculationApproach
		if switch=="Full"
			addEquation(2)
			addEquation(3)
			addEquation(4)
			addEquation(5)
			if Method.Cr == 0 
				addEquation(6)
			else
				let switch=FlowDirection
					if switch=="cocurrent"
						addEquation(7)
					elseif switch=="counter"
						if Method.Cr == 1 
							addEquation(8)
						else
							addEquation(9)
						end
					end
				end
			end
		elseif switch=="Simplified"
			addEquation(10)
			addEquation(11)
			addEquation(12)
			addEquation(13)
			addEquation(14)
		end
	end
	let switch=HotSide
		if HotSide==InletInner.T > InletOuter.T
			set(switch,"inner")
		end
		if HotSide==InletInner.T < InletOuter.T
			set(switch,"outer")
		end
		if switch=="outer"
			let switch=CalculationApproach
				if switch=="Full"
					addEquation(15)
				elseif switch=="Simplified"
					addEquation(16)
				end
			end
			addEquation(17)
			addEquation(18)
		elseif switch=="inner"
			let switch=CalculationApproach
				if switch=="Full"
					addEquation(19)
				elseif switch=="Simplified"
					addEquation(20)
				end
			end
			addEquation(21)
			addEquation(22)
		end
	end
end
function atributes(in::DoublePipe_NTU,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Icon]="icon/DoublePipe"
	fields[:Pallete]=true
	fields[:Brief]="Double Pipe Heat Exchanger - NTU Method"
	fields[:Info]="Thermal analysis of double pipe heat exchanger using the NTU Method.

== Specify ==
* The Inlet Inner stream
* The Inlet Outer stream
== Setting Parameters ==
* Flow Direction: 
** counter flow
** cocurrent flow (Default)
* Heat Transfer Correlations:
** Laminar flow 
*** Hausen (Default)
*** Schlunder
** Transition flow
*** Gnielinski (Default)
*** Hausen
** Turbulent flow
*** Petukhov (Default)
*** Sieder Tate
* Geometrical Parameters:
** DoInner 	- Outside Diameter of Inner Pipe
** DiInner	- Inside Diameter of Inner Pipe
** DiOuter	- Inside Diameter of Outer pipe
** Lpipe		- Effective Tube Length of one segment of Pipe
** Kwall		- Tube Wall Material Thermal Conductivity
* Fouling:
**Rfi	-	Inside Fouling Resistance
**Rfo	- 	Outside Fouling Resistance
"
	drive!(fields,_)
	return fields
end
DoublePipe_NTU(_::Dict{Symbol,Any})=begin
	newModel=DoublePipe_NTU()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(DoublePipe_NTU)
