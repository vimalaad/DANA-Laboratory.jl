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
#*-----------------------------------------------------------------------
#* Author: Tiago Os򱨯rio
#* $Id$
#*---------------------------------------------------------------------
type IAE
	IAE()=begin
		[
			:(output=0*"s"),
		],
		[
			"",
		],
		new(
			DanaReal ((Symbol=>Any)[
				:Brief=>"input signal"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"output signal",
				:Unit=>"s"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"setpoint"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"absolute error"
			]),
			[
				:(absError = abs(setPoint-input)),
				:(diff(output)=absError),
			],
			[
				"Absolute error definition","Calculate output",
			],
			[:input,:output,:setPoint,:absError,]
		)
	end
	input::DanaReal 
	output::DanaReal 
	setPoint::DanaReal 
	absError::DanaReal 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	initials::Array{Expr,1}
	initialNames::Array{String,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export IAE
function setEquationFlow(in::IAE)
	addEquation(1)
	addEquation(2)
end
function initial(in::IAE)
	addEquation(1)
end
function atributes(in::IAE,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/IAE"
	fields[:Brief]="Model IAE."
	fields[:Info]="== Inputs ==
* One input signal.
* One setpoint signal.
	
== Outputs ==
* One output signal.
"
	drive!(fields,_)
	return fields
end
IAE(_::Dict{Symbol,Any})=begin
	newModel=IAE()
	newModel.attributes=atributes(newModel,_)
	newModel
end
