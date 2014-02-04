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
type Lag_1
	Lag_1()=begin
		[
			:(diff(output)=0/"s"),
		],
		[
			"",
		],
		new(
			positive ((Symbol=>Any)[
				:Brief=>"model gain"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"model time constant",
				:Unit=>"s"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"input signal"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"output signal"
			]),
			[
				:(gain*input= tau*diff(output) + output),
			],
			[
				"Calculate output",
			],
			[:gain,:tau,],
			[:input,:output,]
		)
	end
	gain::positive 
	tau::positive 
	input::DanaReal 
	output::DanaReal 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	initials::Array{Expr,1}
	initialNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Lag_1
function setEquationFlow(in::Lag_1)
	addEquation(1)
end
function initial(in::Lag_1)
	addEquation(1)
end
function atributes(in::Lag_1,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Lag_1"
	fields[:Brief]="Model Lag."
	fields[:Info]="== Inputs ==
* One input signal.
	
== Outputs ==
* One output signal.
"
	drive!(fields,_)
	return fields
end
Lag_1(_::Dict{Symbol,Any})=begin
	newModel=Lag_1()
	newModel.attributes=atributes(newModel,_)
	newModel
end
