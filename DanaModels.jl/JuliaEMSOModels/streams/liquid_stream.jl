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
#* Model of basic streams
#*----------------------------------------------------------------------
#* Author: Paula B. Staudt and Rafael de P. Soares
#* $Id$
#*---------------------------------------------------------------------
type liquid_stream
	liquid_stream()=begin
		PP=outers.PP
		new(
			stream(),
			DanaPlugin((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			[
				:(h = PP.LiquidEnthalpy(T, P, z)),
				:(v = 0),
			],
			[
				"Liquid Enthalpy","Liquid stream",
			],
			[:PP,],
		)
	end
	_P1::stream
	PP::DanaPlugin
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export liquid_stream
function setEquationFlow(in::liquid_stream)
	addEquation(1)
	addEquation(2)
end
function atributes(in::liquid_stream,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Liquid Material Stream"
	fields[:Info]="Model for liquid material streams.
	This model should be used only when the phase of the stream
	is known ''a priori''."
	drive!(fields,_)
	return fields
end
liquid_stream(_::Dict{Symbol,Any})=begin
	newModel=liquid_stream()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(liquid_stream)
