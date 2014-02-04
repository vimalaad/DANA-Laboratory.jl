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
#*----------------------------------------------------------------------
#* Author: Maur좩cio Carvalho Maciel, Paula B. Staudt, Rafael P. Soares
#* $Id$
#*--------------------------------------------------------------------
type splitter_n
	splitter_n()=begin
		new(
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of Outlet Streams",
				:Lower=>1
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet stream",
				:PosX=>0,
				:PosY=>0.5001,
				:Symbol=>"_{in}"
			]),
			fill(stream ((Symbol=>Any)[
				:Brief=>"Outlet streams",
				:PosX=>1,
				:PosY=>0.5,
				:Symbol=>"_{out}"
			]),(NOutlet)),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Distribution of Outlets",
				:Default=>0.5,
				:Symbol=>"\\phi"
			]),(NOutlet)),
			[
				:(sum(frac) = 1),
				:(Outlet([1:NOutlet]).F = Inlet.F*frac([1:NOutlet])),
				:(Outlet([1:NOutlet]).z = Inlet.z),
				:(Outlet([1:NOutlet]).P = Inlet.P),
				:(Outlet([1:NOutlet]).h = Inlet.h),
				:(Outlet([1:NOutlet]).T = Inlet.T),
				:(Outlet([1:NOutlet]).v = Inlet.v),
			],
			[
				"","Flow","Composition","Pressure","Enthalpy","Temperature","Vapourisation Fraction",
			],
			[:NOutlet,],
			[:Inlet,:Outlet,:frac,]
		)
	end
	NOutlet::DanaInteger 
	Inlet::stream 
	Outlet::Array{stream }
	frac::Array{fraction }
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export splitter_n
function setEquationFlow(in::splitter_n)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
	addEquation(7)
end
function atributes(in::splitter_n,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/splitter_n"
	fields[:Brief]="Model of a splitter"
	fields[:Info]="== Assumptions ==
* thermodynamics equilibrium
* adiabatic
			
== Specify ==
* the inlet stream
* (Noutlet - 1) fraction of split of the outlet streams:

	frac(i) = (Mole Flow of the outlet stream i / 
				Mole Flow of the inlet stream)
				where i = 1, 2,...,Noutlet
"
	drive!(fields,_)
	return fields
end
splitter_n(_::Dict{Symbol,Any})=begin
	newModel=splitter_n()
	newModel.attributes=atributes(newModel,_)
	newModel
end
