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
type sepComp
	sepComp()=begin
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
				:Brief=>"Component specified",
				:Default=>1,
				:Lower=>1
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet stream",
				:PosX=>0,
				:PosY=>0.5001,
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
			fraction ((Symbol=>Any)[
				:Brief=>"Recovery of the component specified",
				:Symbol=>"\\eta"
			]),
			[
				:(Outlet1.F = Inlet.F * frac),
				:(Outlet1.F + Outlet2.F = Inlet.F),
				:(recovery*Inlet.z(mainComp) = frac*Outlet1.z(mainComp)),
				:(sum(Outlet1.z) = 1),
				:(Outlet1.F*Outlet1.z([1:NComp]) + Outlet2.F*Outlet2.z([1:NComp]) = Inlet.F*Inlet.z([1:NComp])),
				:(Outlet1.P = Inlet.P),
				:(Outlet2.P = Inlet.P),
				:(Outlet1.h = (1-Outlet1.v)*PP.LiquidEnthalpy(Outlet1.T, Outlet1.P, Outlet1.z) + Outlet1.v*PP.VapourEnthalpy(Outlet1.T, Outlet1.P, Outlet1.z)),
				:(Outlet2.h = (1-Outlet2.v)*PP.LiquidEnthalpy(Outlet2.T, Outlet2.P, Outlet2.z) + Outlet2.v*PP.VapourEnthalpy(Outlet2.T, Outlet2.P, Outlet2.z)),
				:(Outlet1.T = Inlet.T),
				:(Outlet2.T = Inlet.T),
				:(Outlet1.v = PP.VapourFraction(Outlet1.T, Outlet1.P, Outlet1.z)),
				:(Outlet2.v = PP.VapourFraction(Outlet2.T, Outlet2.P, Outlet2.z)),
			],
			[
				"Flow","","","","Composition","Pressure","","Enthalpy","","Temperature","","Vapourization Fraction","",
			],
			[:PP,:NComp,:mainComp,],
			[:Inlet,:Outlet1,:Outlet2,:frac,:recovery,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	mainComp::DanaInteger 
	Inlet::stream 
	Outlet1::stream 
	Outlet2::stream 
	frac::fraction 
	recovery::fraction 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export sepComp
function setEquationFlow(in::sepComp)
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
	addEquation(13)
end
function atributes(in::sepComp,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/splitter"
	fields[:Brief]="Model of a separator of components"
	fields[:Info]="== Assumptions ==
* thermodynamics equilibrium
* adiabatic
	
== Specify ==
* the inlet stream
* (NComp - 1) molar fractions to 1 of the outlet streams
* the fraction of split of the outlet streams
"
	drive!(fields,_)
	return fields
end
sepComp(_::Dict{Symbol,Any})=begin
	newModel=sepComp()
	newModel.attributes=atributes(newModel,_)
	newModel
end
