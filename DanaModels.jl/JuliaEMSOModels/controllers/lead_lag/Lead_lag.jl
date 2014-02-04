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
type Lead_lag
	Lead_lag()=begin
		[
			:(diff(aux)= 0/"s"),
		],
		[
			"",
		],
		new(
			positive ((Symbol=>Any)[
				:Brief=>"model gain"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"lead time constant",
				:Unit=>"s"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"lag time constant",
				:Unit=>"s"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"input signal"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"output signal"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"internal variable"
			]),
			[
				:(alpha*diff(aux)=gain*input-aux),
				:(output=beta*diff(aux) + aux),
			],
			[
				"Calculate variable aux","Calculate output",
			],
			[:gain,:beta,:alpha,],
			[:input,:output,:aux,]
		)
	end
	gain::positive 
	beta::positive 
	alpha::positive 
	input::DanaReal 
	output::DanaReal 
	aux::DanaReal 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	initials::Array{Expr,1}
	initialNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Lead_lag
function setEquationFlow(in::Lead_lag)
	addEquation(1)
	addEquation(2)
end
function initial(in::Lead_lag)
	addEquation(1)
end
function atributes(in::Lead_lag,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Lead_Lag"
	fields[:Brief]="Model Lead lag."
	fields[:Info]="== Inputs ==
* One input signal.
	
== Outputs ==
* One output signal.
"
	drive!(fields,_)
	return fields
end
Lead_lag(_::Dict{Symbol,Any})=begin
	newModel=Lead_lag()
	newModel.attributes=atributes(newModel,_)
	newModel
end
