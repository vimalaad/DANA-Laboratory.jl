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
#* Author: Paula B. Staudt and Rafael P. Soares
#* $Id$
#*------------------------------------------------------------------
type batch_basic
	batch_basic()=begin
		NComp=outers.NComp
		new(
			DanaInteger(),
			DanaInteger(),
			fill(DanaReal ((Symbol=>Any)[
				:Brief=>"Stoichiometric Matrix"
			]),(NComp, NReac)),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet stream",
				:PosX=>0,
				:PosY=>0,
				:Symbol=>"_{in}"
			]),
			fill(conc_mol ((Symbol=>Any)[
				:Brief=>"Components concentration"
			]),(NComp)),
			fill(reaction_mol ((Symbol=>Any)[
				:Brief=>"Reaction rates"
			]),(NReac)),
			temperature ((Symbol=>Any)[
				:Brief=>"Reactor temperature"
			]),
			pressure ((Symbol=>Any)[
				:Brief=>"Reactor pressure"
			]),
			volume ((Symbol=>Any)[
				:Brief=>"Reacting Volume"
			]),
			[
				:(diff(C*Vr) = Inlet.F*Inlet.z + sumt(stoic*r)*Vr),
			],
			[
				"Component Molar Balance",
			],
			[:NComp,:NReac,:stoic,],
			[:Inlet,:C,:r,:T,:P,:Vr,]
		)
	end
	NComp::DanaInteger
	NReac::DanaInteger
	stoic::Array{DanaReal }
	Inlet::stream 
	C::Array{conc_mol }
	r::Array{reaction_mol }
	T::temperature 
	P::pressure 
	Vr::volume 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export batch_basic
function setEquationFlow(in::batch_basic)
	addEquation(1)
end
function atributes(in::batch_basic,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/batch"
	fields[:Brief]="Model of a batch reactor"
	fields[:Info]="== Assumptions ==
* isothermic
"
	drive!(fields,_)
	return fields
end
batch_basic(_::Dict{Symbol,Any})=begin
	newModel=batch_basic()
	newModel.attributes=atributes(newModel,_)
	newModel
end
