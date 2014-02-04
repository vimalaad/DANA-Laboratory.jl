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
type streamPHS
	streamPHS()=begin
		PP=outers.PP
		new(
			streamPH(),
			DanaPlugin((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			entr_mol ((Symbol=>Any)[
				:Brief=>"Stream Entropy"
			]),
			[
				:(s = (1-v)*_P1.PP.LiquidEntropy(T, P, x) + v*_P1.PP.VapourEntropy(T, P, y)),
			],
			[
				"Entropy",
			],
			[:PP,],
			[:s,]
		)
	end
	_P1::streamPH
	PP::DanaPlugin
	s::entr_mol 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export streamPHS
function setEquationFlow(in::streamPHS)
	addEquation(1)
end
function atributes(in::streamPHS,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Brief]="Stream with built-in flash calculation"
	fields[:Info]="
	This model should be used when the vaporization fraction
	is unknown.
	
	The built-in flash calculation will determine the stream
	state as a function of the overall composition '''z''', the
	pressure '''P''' and the enthalpy '''h'''.
	
	Additionally, the liquid composition '''x''', the vapor
	composition '''y''' and the stream entropy are calculated.	
	"
	fields[:Pallete]=false
	drive!(fields,_)
	return fields
end
streamPHS(_::Dict{Symbol,Any})=begin
	newModel=streamPHS()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(streamPHS)
