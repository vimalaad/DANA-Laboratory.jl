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
#* Author: Maur좩cio Carvalho Maciel
#* $Id$
#*--------------------------------------------------------------------
type sepComp_n
	sepComp_n()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin ((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of chemical components",
				:Lower=>1
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of Outlet Streams",
				:Lower=>1
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Component specified",
				:Default=>1,
				:Lower=>1
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet stream",
				:PosX=>0,
				:PosY=>0.5,
				:Symbol=>"_{in}"
			]),
			fill(stream ((Symbol=>Any)[
				:Brief=>"Outlet streams",
				:PosX=>1,
				:PosY=>0.5059,
				:Symbol=>"_{out}"
			]),(NOutlet)),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Distribution of the Outlet streams",
				:Symbol=>"\\phi"
			]),(NOutlet)),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Recovery of the component specified",
				:Symbol=>"\\eta"
			]),(NOutlet)),
			[
				:(sum(Outlet.F) = Inlet.F),
				:(sum(Outlet([1:NOutlet-1]).z) = 1),
				:(sum(Outlet.F*Outlet.z([1:NComp])) = Inlet.F*Inlet.z([1:NComp])),
				:(Outlet([1:NOutlet]).F = Inlet.F*frac([1:NOutlet])),
				:(recovery([1:NOutlet])*Inlet.z(mainComp) = frac([1:NOutlet])*Outlet([1:NOutlet]).z(mainComp)),
				:(Outlet([1:NOutlet]).P = Inlet.P),
				:(Outlet([1:NOutlet]).h = (1-Outlet([1:NOutlet]).v)*PP.LiquidEnthalpy(Outlet([1:NOutlet]).T, Outlet([1:NOutlet]).P, Outlet([1:NOutlet]).z) + Outlet([1:NOutlet]).v*PP.VapourEnthalpy(Outlet([1:NOutlet]).T, Outlet([1:NOutlet]).P, Outlet([1:NOutlet]).z)),
				:(Outlet([1:NOutlet]).T = Inlet.T),
				:(Outlet([1:NOutlet]).v = PP.VapourFraction(Outlet([1:NOutlet]).T, Outlet([1:NOutlet]).P, Outlet([1:NOutlet]).z)),
			],
			[
				"Flow","Mol fraction normalisation","Composition","Flow","Recovery","Pressure","Enthalpy","Temperature","Vapourization Fraction",
			],
			[:PP,:NComp,:NOutlet,:mainComp,],
			[:Inlet,:Outlet,:frac,:recovery,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	NOutlet::DanaInteger 
	mainComp::DanaInteger 
	Inlet::stream 
	Outlet::Array{stream }
	frac::Array{fraction }
	recovery::Array{fraction }
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export sepComp_n
function setEquationFlow(in::sepComp_n)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
	addEquation(7)
	addEquation(8)
	addEquation(9)
end
function atributes(in::sepComp_n,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/splitter_n"
	fields[:Brief]="Model of a separator of components"
	fields[:Info]="== Assumptions ==
* thermodynamics equilibrium
* adiabatic

== Specify ==
* the inlet stream
* (NComp - 1) molar fractions to (Noutlet - 1) outlet streams
* (Noutlet - 1) frac (fraction of split of the outlet streams):
			
	frac(i) = (Mole Flow of the outlet stream i / 
				Mole Flow of the inlet stream)
						where i = 1, 2,...,Noutlet

			or

* (Noutlet - 1) recovery (Recovery of the component specified in the outlet stream i):

  recovery(i) = (Mole Flow of the component specified in the Outlet stream i/ 
				Mole Flow of the component specified in the inlet stream)
						where i = 1, 2,...,Noutlet
"
	drive!(fields,_)
	return fields
end
sepComp_n(_::Dict{Symbol,Any})=begin
	newModel=sepComp_n()
	newModel.attributes=atributes(newModel,_)
	newModel
end
