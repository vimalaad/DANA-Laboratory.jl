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
type Heatex_Basic
	Heatex_Basic()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin ((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of Components"
			]),
			fill(molweight ((Symbol=>Any)[
				:Brief=>"Component Mol Weight",
				:Hidden=>true
			]),(NComp)),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet Hot Stream",
				:PosX=>0,
				:PosY=>0.4915,
				:Symbol=>"^{inHot}"
			]),
			streamPH ((Symbol=>Any)[
				:Brief=>"Outlet Hot Stream",
				:PosX=>1,
				:PosY=>0.4915,
				:Symbol=>"^{outHot}"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet Cold Stream",
				:PosX=>0.5237,
				:PosY=>1,
				:Symbol=>"^{inCold}"
			]),
			streamPH ((Symbol=>Any)[
				:Brief=>"Outlet Cold Stream",
				:PosX=>0.5237,
				:PosY=>0,
				:Symbol=>"^{outCold}"
			]),
			area ((Symbol=>Any)[
				:Brief=>"Exchange Surface Area"
			]),
			power ((Symbol=>Any)[
				:Brief=>"Duty",
				:Default=>7000,
				:Lower=>1e-6,
				:Upper=>1e10
			]),
			heat_trans_coeff ((Symbol=>Any)[
				:Brief=>"Overall Heat Transfer Coefficient",
				:Default=>1,
				:Lower=>1e-6,
				:Upper=>1e10
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Pressure Drop Hot Side",
				:Default=>0.01,
				:Lower=>0,
				:DisplayUnit=>"kPa" ,
				:Symbol=>"\\Delta P_{hot}"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Pressure Drop Cold Side",
				:Default=>0.01,
				:Lower=>0,
				:DisplayUnit=>"kPa" ,
				:Symbol=>"\\Delta P_{cold}"
			]),
			[
				:(Q = InletHot.F*(InletHot.h-OutletHot.h)),
				:(Q =-InletCold.F*(InletCold.h-OutletCold.h)),
				:(InletHot.F = OutletHot.F),
				:(InletCold.F = OutletCold.F),
				:(OutletHot.z = InletHot.z),
				:(OutletCold.z = InletCold.z),
				:(OutletHot.P = InletHot.P - PdropHotSide),
				:(OutletCold.P = InletCold.P - PdropColdSide),
			],
			[
				"Energy Balance Hot Stream","Energy Balance Cold Stream","Molar Balance Hot Stream","Molar Balance Cold Stream","Hot Stream Molar Fraction Constraint","Cold Stream Molar Fraction Constraint","Pressure Drop Hot Stream","Pressure Drop Cold Stream",
			],
			[:PP,:NComp,:M,],
			[:InletHot,:OutletHot,:InletCold,:OutletCold,:A,:Q,:U,:PdropHotSide,:PdropColdSide,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	M::Array{molweight }
	InletHot::stream 
	OutletHot::streamPH 
	InletCold::stream 
	OutletCold::streamPH 
	A::area 
	Q::power 
	U::heat_trans_coeff 
	PdropHotSide::press_delta 
	PdropColdSide::press_delta 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Heatex_Basic
function set(in::Heatex_Basic)
	#"Component Molecular Weight"
	M = PP.MolecularWeight()
	 
end
function setEquationFlow(in::Heatex_Basic)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
	addEquation(7)
	addEquation(8)
end
function atributes(in::Heatex_Basic,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Basic Model for Simplified Heat Exchangers"
	fields[:Info]="Model of a simplified heat exchanger.
This model perform only material and heat balance.

== Assumptions ==
* Steady-State operation;
* No heat loss to the surroundings.

== Specify ==
* The Inlet streams: Hot and Cold;
"
	drive!(fields,_)
	return fields
end
Heatex_Basic(_::Dict{Symbol,Any})=begin
	newModel=Heatex_Basic()
	newModel.attributes=atributes(newModel,_)
	newModel
end
