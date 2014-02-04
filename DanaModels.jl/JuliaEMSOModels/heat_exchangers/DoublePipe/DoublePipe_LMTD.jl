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
type DoublePipe_LMTD
	DoublePipe_LMTD()=begin
		new(
			DoublePipe_Basic(),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Flow Direction",
				:Valid=>["counter","cocurrent"],
				:Default=>"cocurrent"
			]),
			LMTD_Basic ((Symbol=>Any)[
				:Brief=>"LMTD Method of Calculation",
				:Symbol=>" "
			]),
			[
				:(_P1.Details.Q = _P1.Details.Ud*_P1.Geometry.Pi*_P1.Geometry.DoInner*_P1.Geometry.Lpipe*Method.LMTD),
				:(_P1.Details.Q = _P1.Qestimated),
				:(Method.Fc = 1),
				:(Method.DT0 = _P1.InletOuter.T - _P1.InletInner.T),
				:(Method.DTL = _P1.OutletOuter.T - _P1.OutletInner.T),
				:(Method.DT0 = _P1.InletOuter.T - _P1.OutletInner.T),
				:(Method.DTL = _P1.OutletOuter.T - _P1.InletInner.T),
				:(Method.DT0 = _P1.InletInner.T - _P1.InletOuter.T),
				:(Method.DTL = _P1.OutletInner.T - _P1.OutletOuter.T),
				:(Method.DT0 = _P1.InletInner.T - _P1.OutletOuter.T),
				:(Method.DTL = _P1.OutletInner.T - _P1.InletOuter.T),
			],
			[
				"Duty","Duty","LMTD Correction Factor - True counter ou cocurrent flow","Temperature Difference at Inlet - Cocurrent Flow","Temperature Difference at Outlet - Cocurrent Flow","Temperature Difference at Inlet - Counter Flow","Temperature Difference at Outlet - Counter Flow","Temperature Difference at Inlet - Cocurrent Flow","Temperature Difference at Outlet - Cocurrent Flow","Temperature Difference at Inlet - Counter Flow","Temperature Difference at Outlet - Counter Flow",
			],
			[:FlowDirection,],
			[:Method,]
		)
	end
	_P1::DoublePipe_Basic
	FlowDirection::DanaSwitcher 
	Method::LMTD_Basic 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export DoublePipe_LMTD
function setEquationFlow(in::DoublePipe_LMTD)
	let switch=CalculationApproach
		if switch=="Full"
			addEquation(1)
		elseif switch=="Simplified"
			addEquation(2)
		end
	end
	addEquation(3)
	let switch=HotSide
		if HotSide==InletInner.T > InletOuter.T
			set(switch,"inner")
		end
		if HotSide==InletInner.T < InletOuter.T
			set(switch,"outer")
		end
		if switch=="outer"
			let switch=FlowDirection
				if switch=="cocurrent"
					addEquation(4)
					addEquation(5)
				elseif switch=="counter"
					addEquation(6)
					addEquation(7)
				end
			end
		elseif switch=="inner"
			let switch=FlowDirection
				if switch=="cocurrent"
					addEquation(8)
					addEquation(9)
				elseif switch=="counter"
					addEquation(10)
					addEquation(11)
				end
			end
		end
	end
end
function atributes(in::DoublePipe_LMTD,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Icon]="icon/DoublePipe"
	fields[:Pallete]=true
	fields[:Brief]="Double Pipe Heat Exchanger - LMTD Method"
	fields[:Info]="Thermal analysis of double pipe heat exchanger using the LMTD Method.

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
DoublePipe_LMTD(_::Dict{Symbol,Any})=begin
	newModel=DoublePipe_LMTD()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(DoublePipe_LMTD)
