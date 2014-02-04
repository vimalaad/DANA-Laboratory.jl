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
#* Model of tanks
#*-------------------------------------------------------------------- 
#*	Streams:
#*		* an inlet stream
#*		* an outlet stream
#*
#*	Specify:
#*		* the Inlet stream
#*		* the Outlet flow
#*		* the tank Q
#*
#*	Initial:
#*		* the tank temperature (OutletL.T)
#*		* the tank level (h)
#*		* (NoComps - 1) Outlet compositions
#*----------------------------------------------------------------------
#* Author: Paula B. Staudt
#* $Id$
#*--------------------------------------------------------------------
type tank
	tank()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger(),
			area ((Symbol=>Any)[
				:Brief=>"Tank cross section area",
				:Default=>2
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet stream",
				:PosX=>0.3037,
				:PosY=>0,
				:Symbol=>"_{in}"
			]),
			liquid_stream ((Symbol=>Any)[
				:Brief=>"Outlet liquid stream",
				:PosX=>1,
				:PosY=>1,
				:Symbol=>"_{out}"
			]),
			energy_stream ((Symbol=>Any)[
				:Brief=>"Rate of heat supply",
				:PosX=>1,
				:PosY=>0.7859,
				:Symbol=>"_{in}"
			]),
			length((Symbol=>Any)[
				:Brief=>"Tank level"
			]),
			fill(mol ((Symbol=>Any)[
				:Brief=>"Molar Holdup in the tank"
			]),(NComp)),
			energy ((Symbol=>Any)[
				:Brief=>"Total Energy Holdup on tank"
			]),
			volume_mol ((Symbol=>Any)[
				:Brief=>"Liquid Molar Volume"
			]),
			[
				:(diff(M) = Inlet.F*Inlet.z - Outlet.F*Outlet.z),
				:(diff(E) = Inlet.F*Inlet.h - Outlet.F*Outlet.h + InletQ.Q),
				:(E = sum(M)*Outlet.h),
				:(Inlet.P = Outlet.P),
				:(vL = PP.LiquidVolume(Outlet.T, Outlet.P, Outlet.z)),
				:(M = Outlet.z*sum(M)),
				:(Level = sum(M)*vL/Across),
			],
			[
				"Mass balance","Energy balance","Energy Holdup","Mechanical Equilibrium","Liquid Volume","Composition","Level of liquid phase",
			],
			[:PP,:NComp,:Across,],
			[:Inlet,:Outlet,:InletQ,:Level,:M,:E,:vL,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	Across::area 
	Inlet::stream 
	Outlet::liquid_stream 
	InletQ::energy_stream 
	Level::length
	M::Array{mol }
	E::energy 
	vL::volume_mol 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export tank
function setEquationFlow(in::tank)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
	addEquation(7)
end
function atributes(in::tank,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Tank"
	fields[:Brief]="Model of a cylindrical tank."
	fields[:Info]="== Specify ==
* the Inlet stream;
* the outlet flow;
* the tank Q.

== Initial Conditions ==
* the tank initial temperature (OutletL.T);
* the tank initial level (Level);
* (NoComps - 1) OutletL (OR OutletV) compositions.
"
	drive!(fields,_)
	return fields
end
tank(_::Dict{Symbol,Any})=begin
	newModel=tank()
	newModel.attributes=atributes(newModel,_)
	newModel
end
