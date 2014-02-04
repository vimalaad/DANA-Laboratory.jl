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
type splitter
	splitter()=begin
		new(
			stream ((Symbol=>Any)[
				:Brief=>"Inlet stream",
				:PosX=>0,
				:PosY=>0.5069,
				:Symbol=>"_{in}"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Outlet stream 1",
				:PosX=>1,
				:PosY=>0.3027,
				:Symbol=>"_{out1}"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Outlet stream 2",
				:PosX=>1,
				:PosY=>0.7141,
				:Symbol=>"_{out2}"
			]),
			fraction ((Symbol=>Any)[
				:Brief=>"Fraction to Outlet 1",
				:Symbol=>"\\phi"
			]),
			[
				:(Outlet1.F = Inlet.F * frac),
				:(Outlet1.F + Outlet2.F = Inlet.F),
				:(Outlet1.z = Inlet.z),
				:(Outlet2.z = Inlet.z),
				:(Outlet1.P = Inlet.P),
				:(Outlet2.P = Inlet.P),
				:(Outlet1.h = Inlet.h),
				:(Outlet2.h = Inlet.h),
				:(Outlet1.T = Inlet.T),
				:(Outlet2.T = Inlet.T),
				:(Outlet1.v = Inlet.v),
				:(Outlet2.v = Inlet.v),
			],
			[
				"Flow","","Composition","","Pressure","","Enthalpy","","Temperature","","Vapourisation Fraction","",
			],
			[:Inlet,:Outlet1,:Outlet2,:frac,]
		)
	end
	Inlet::stream 
	Outlet1::stream 
	Outlet2::stream 
	frac::fraction 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export splitter
function setEquationFlow(in::splitter)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
	addEquation(7)
	addEquation(8)
	addEquation(9)
	addEquation(10)
	addEquation(11)
	addEquation(12)
end
function atributes(in::splitter,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/splitter"
	fields[:Brief]="Splitter with 2 outlet streams"
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
splitter(_::Dict{Symbol,Any})=begin
	newModel=splitter()
	newModel.attributes=atributes(newModel,_)
	newModel
end
