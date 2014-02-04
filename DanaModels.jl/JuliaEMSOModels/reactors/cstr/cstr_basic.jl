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
#* Model of cstr reactor
#*--------------------------------------------------------------------
#* Author: Paula B. Staudt
#* $Id$
#*--------------------------------------------------------------------
type cstr_basic
	cstr_basic()=begin
		NComp=outers.NComp
		new(
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number Of Components"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number Of Reactions"
			]),
			fill(DanaReal ((Symbol=>Any)[
				:Brief=>"Stoichiometric Matrix"
			]),(NComp, NReac)),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet Stream",
				:PosX=>0,
				:PosY=>0,
				:Symbol=>"_{in}"
			]),
			streamPH ((Symbol=>Any)[
				:Brief=>"Outlet Stream",
				:PosX=>1,
				:PosY=>1,
				:Symbol=>"_{out}"
			]),
			heat_rate ((Symbol=>Any)[
				:Brief=>"Heat"
			]),
			volume ((Symbol=>Any)[
				:Brief=>"Reacting Volume"
			]),
			mol ((Symbol=>Any)[
				:Brief=>"Molar total amount"
			]),
			fill(conc_mol ((Symbol=>Any)[
				:Brief=>"Components concentration"
			]),(NComp)),
			[
				:(Outlet.z * M = C * Vr),
				:(sum(Outlet.z) = 1),
			],
			[
				"Molar Concentration","Molar fraction",
			],
			[:NComp,:NReac,:stoic,],
			[:Inlet,:Outlet,:q,:Vr,:M,:C,]
		)
	end
	NComp::DanaInteger 
	NReac::DanaInteger 
	stoic::Array{DanaReal }
	Inlet::stream 
	Outlet::streamPH 
	q::heat_rate 
	Vr::volume 
	M::mol 
	C::Array{conc_mol }
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export cstr_basic
function setEquationFlow(in::cstr_basic)
	addEquation(1)
	addEquation(2)
end
function atributes(in::cstr_basic,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Basic model for a CSTR reactor"
	drive!(fields,_)
	return fields
end
cstr_basic(_::Dict{Symbol,Any})=begin
	newModel=cstr_basic()
	newModel.attributes=atributes(newModel,_)
	newModel
end
