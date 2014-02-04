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
type stream
	stream()=begin
		NComp=outers.NComp
		new(
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of chemical components",
				:Lower=>1
			]),
			flow_mol ((Symbol=>Any)[
				:Brief=>"Stream Molar Flow Rate"
			]),
			temperature ((Symbol=>Any)[
				:Brief=>"Stream Temperature"
			]),
			pressure ((Symbol=>Any)[
				:Brief=>"Stream Pressure"
			]),
			enth_mol ((Symbol=>Any)[
				:Brief=>"Stream Enthalpy"
			]),
			fraction ((Symbol=>Any)[
				:Brief=>"Vapourization fraction"
			]),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Stream Molar Fraction"
			]),(NComp)),
			[:NComp,],
			[:F,:T,:P,:h,:v,:z,]
		)
	end
	NComp::DanaInteger 
	F::flow_mol 
	T::temperature 
	P::pressure 
	h::enth_mol 
	v::fraction 
	z::Array{fraction }
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export stream
function atributes(in::stream,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="General Material Stream"
	fields[:Info]="This is the basic building block for the EML models.
	Every model should have input and output streams derived
	from this model."
	drive!(fields,_)
	return fields
end
stream(_::Dict{Symbol,Any})=begin
	newModel=stream()
	newModel.attributes=atributes(newModel,_)
	newModel
end
