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
type HiLoSelect
	HiLoSelect()=begin
		new(
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"HiLoSelect option",
				:Valid=>["higher","lower"],
				:Default=>"higher"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"input signal 1"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"input signal 2"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"output signal"
			]),
			[
				:(output = max([input1,input2])),
				:(output = min([input1,input2])),
			],
			[
				"Calculate output maximum","Calculate output minimum",
			],
			[:Select,],
			[:input1,:input2,:output,]
		)
	end
	Select::DanaSwitcher 
	input1::DanaReal 
	input2::DanaReal 
	output::DanaReal 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export HiLoSelect
function setEquationFlow(in::HiLoSelect)
	let switch=Select
		if switch=="higher"
			addEquation(1)
		elseif switch=="lower"
			addEquation(2)
		end
	end
end
function atributes(in::HiLoSelect,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/HiLoSelect"
	fields[:Brief]="Model HiLo Select."
	fields[:Info]="== Inputs ==
* Two different input signals.
	
== Outputs ==
* One output signal.
"
	drive!(fields,_)
	return fields
end
HiLoSelect(_::Dict{Symbol,Any})=begin
	newModel=HiLoSelect()
	newModel.attributes=atributes(newModel,_)
	newModel
end
