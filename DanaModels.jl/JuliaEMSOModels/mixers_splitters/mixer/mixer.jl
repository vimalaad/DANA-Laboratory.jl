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
#*-------------------------------------------------------------------
#* Author: Maur좩cio Carvalho Maciel
#* $Id$
#*--------------------------------------------------------------------
type mixer
	mixer()=begin
		NComp=outers.NComp
		new(
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of chemical components",
				:Lower=>1
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of Inlet Streams",
				:Lower=>1,
				:Default=>2
			]),
			fill(stream ((Symbol=>Any)[
				:Brief=>"Inlet streams",
				:PosX=>0,
				:PosY=>0.5,
				:Symbol=>"_{inMix}"
			]),(Ninlet)),
			streamPH ((Symbol=>Any)[
				:Brief=>"Outlet stream",
				:PosX=>1,
				:PosY=>0.5059,
				:Symbol=>"_{out}"
			]),
			[
				:(Outlet.F = sum(Inlet.F)),
				:(Outlet.F*Outlet.z([1:NComp]) = sum(Inlet.F*Inlet.z([1:NComp]))),
				:(Outlet.F*Outlet.h = sum(Inlet.F*Inlet.h)),
				:(Outlet.P = min(Inlet.P)),
			],
			[
				"Flow","Composition","Energy Balance","Pressure",
			],
			[:NComp,:Ninlet,],
			[:Inlet,:Outlet,]
		)
	end
	NComp::DanaInteger 
	Ninlet::DanaInteger 
	Inlet::Array{stream }
	Outlet::streamPH 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export mixer
function setEquationFlow(in::mixer)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
end
function atributes(in::mixer,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/mixer"
	fields[:Brief]="Model of a mixer"
	fields[:Info]="== Assumptions ==
* static
* adiabatic

== Specify ==
* the inlet streams"
	drive!(fields,_)
	return fields
end
mixer(_::Dict{Symbol,Any})=begin
	newModel=mixer()
	newModel.attributes=atributes(newModel,_)
	newModel
end
