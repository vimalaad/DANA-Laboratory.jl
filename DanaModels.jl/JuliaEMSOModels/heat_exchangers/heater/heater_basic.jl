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
#*----------------------------------------------------------------------
#* Author: Gerson Balbueno Bicca 
#* $Id$
#*--------------------------------------------------------------------
type heater_basic
	heater_basic()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin ((Symbol=>Any)[
				:Brief=>"Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of Components"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Option for Display Phase Equilibrium K-values",
				:Valid=>["yes","no"],
				:Default=>"yes"
			]),
			power ((Symbol=>Any)[
				:Brief=>"Actual Duty",
				:Symbol=>"Q_{Duty}"
			]),
			fraction ((Symbol=>Any)[
				:Brief=>"Vapor fraction Outlet Stream",
				:Symbol=>"V_{frac}"
			]),
			fraction ((Symbol=>Any)[
				:Brief=>"Liquid fraction Outlet Stream",
				:Symbol=>"L_{frac}"
			]),
			fill(DanaReal ((Symbol=>Any)[
				:Brief=>"Phase Equilibrium K-values",
				:Lower=>1E-30,
				:Upper=>1E30,
				:Symbol=>"K_{value}"
			]),(NComp)),
			positive ((Symbol=>Any)[
				:Brief=>"Pressure Ratio",
				:Symbol=>"P_{ratio}"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Pressure Drop",
				:DisplayUnit=>"kPa",
				:Symbol=>"\\Delta P"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet Stream",
				:PosX=>0,
				:PosY=>0.45,
				:Symbol=>"^{in}"
			]),
			streamPH ((Symbol=>Any)[
				:Brief=>"Outlet Stream",
				:PosX=>1,
				:PosY=>0.45,
				:Symbol=>"^{out}"
			]),
			[
				:(Outlet.F = Inlet.F),
				:(Outlet.F*Outlet.z([1 : NComp]) = Inlet.F*Inlet.z([1 : NComp])),
				:(Vfrac = Outlet.v),
				:(Lfrac = 1-Vfrac),
				:(Duty = Outlet.F*Outlet.h - Inlet.F*Inlet.h),
				:(Outlet.P = Inlet.P - Pdrop),
				:(Outlet.P = Inlet.P * Pratio),
				:(Kvalue*Outlet.x = Outlet.y),
				:(Kvalue = 1),
			],
			[
				"Flow","Composition","Vapor fraction Outlet Stream","Liquid fraction Outlet Stream","Heat Duty","Pressure Drop","Pressure Ratio","K-values Phase Equilibrium","K-values Phase Equilibrium",
			],
			[:PP,:NComp,:Kvalues,],
			[:Duty,:Vfrac,:Lfrac,:Kvalue,:Pratio,:Pdrop,:Inlet,:Outlet,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	Kvalues::DanaSwitcher 
	Duty::power 
	Vfrac::fraction 
	Lfrac::fraction 
	Kvalue::Array{DanaReal }
	Pratio::positive 
	Pdrop::press_delta 
	Inlet::stream 
	Outlet::streamPH 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export heater_basic
function setEquationFlow(in::heater_basic)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
	addEquation(7)
	let switch=Kvalues
		# Fix for better convergence !!!
		if switch=="yes"
			addEquation(8)
		elseif switch=="no"
			addEquation(9)
		end
	end
end
function atributes(in::heater_basic,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Basic model for Heater or Cooler Operation"
	fields[:Info]="Determines thermal and phase conditions of an outlet stream.
"
	drive!(fields,_)
	return fields
end
heater_basic(_::Dict{Symbol,Any})=begin
	newModel=heater_basic()
	newModel.attributes=atributes(newModel,_)
	newModel
end
