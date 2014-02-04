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
#* Author: Paula B. Staudt
#* $Id$
#*--------------------------------------------------------------------
type condenser
	condenser()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger(),
			volume ((Symbol=>Any)[
				:Brief=>"Condenser total volume"
			]),
			area ((Symbol=>Any)[
				:Brief=>"Cross Section Area of reboiler"
			]),
			stream((Symbol=>Any)[
				:Brief=>"Vapour inlet stream",
				:PosX=>0.1164,
				:PosY=>0,
				:Symbol=>"_{inV}"
			]),
			liquid_stream((Symbol=>Any)[
				:Brief=>"Liquid outlet stream",
				:PosX=>0.4513,
				:PosY=>1,
				:Symbol=>"_{outL}"
			]),
			vapour_stream((Symbol=>Any)[
				:Brief=>"Vapour outlet stream",
				:PosX=>0.4723,
				:PosY=>0,
				:Symbol=>"_{outV}"
			]),
			energy_stream ((Symbol=>Any)[
				:Brief=>"Cold supplied",
				:PosX=>1,
				:PosY=>0.6311,
				:Symbol=>"_{in}"
			]),
			fill(mol ((Symbol=>Any)[
				:Brief=>"Molar Holdup in the tray"
			]),(NComp)),
			mol ((Symbol=>Any)[
				:Brief=>"Molar liquid holdup"
			]),
			mol ((Symbol=>Any)[
				:Brief=>"Molar vapour holdup"
			]),
			energy ((Symbol=>Any)[
				:Brief=>"Total Energy Holdup on tray"
			]),
			volume_mol ((Symbol=>Any)[
				:Brief=>"Liquid Molar Volume"
			]),
			volume_mol ((Symbol=>Any)[
				:Brief=>"Vapour Molar volume"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Level of liquid phase"
			]),
			[
				:(diff(M) = InletV.F*InletV.z - OutletL.F*OutletL.z - OutletV.F*OutletV.z),
				:(diff(E) = InletV.F*InletV.h - OutletL.F*OutletL.h - OutletV.F*OutletV.h + InletQ.Q),
				:(M = ML*OutletL.z + MV*OutletV.z),
				:(E = ML*OutletL.h + MV*OutletV.h - OutletV.P*V),
				:(sum(OutletL.z)=1.0),
				:(sum(OutletL.z)=sum(OutletV.z)),
				:(vL = PP.LiquidVolume(OutletL.T, OutletL.P, OutletL.z)),
				:(vV = PP.VapourVolume(OutletV.T, OutletV.P, OutletV.z)),
				:(PP.LiquidFugacityCoefficient(OutletL.T, OutletL.P, OutletL.z)*OutletL.z = PP.VapourFugacityCoefficient(OutletV.T, OutletV.P, OutletV.z)*OutletV.z),
				:(OutletL.T = OutletV.T),
				:(OutletV.P = OutletL.P),
				:(V = ML*vL + MV*vV),
				:(Level = ML*vL/Across),
			],
			[
				"Component Molar Balance","Energy Balance","Molar Holdup","Energy Holdup","Mol fraction normalisation","","Liquid Volume","Vapour Volume","Chemical Equilibrium","Thermal Equilibrium","Mechanical Equilibrium","Geometry Constraint","Level of liquid phase",
			],
			[:PP,:NComp,:V,:Across,],
			[:InletV,:OutletL,:OutletV,:InletQ,:M,:ML,:MV,:E,:vL,:vV,:Level,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	V::volume 
	Across::area 
	InletV::stream
	OutletL::liquid_stream
	OutletV::vapour_stream
	InletQ::energy_stream 
	M::Array{mol }
	ML::mol 
	MV::mol 
	E::energy 
	vL::volume_mol 
	vV::volume_mol 
	Level::length 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export condenser
function setEquationFlow(in::condenser)
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
function atributes(in::condenser,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Condenser"
	fields[:Brief]="Model of a dynamic condenser."
	fields[:Info]="== Assumptions ==
* perfect mixing of both phases;
* thermodynamics equilibrium.
	
== Specify ==
* the inlet stream;
* the outlet flows: OutletV.F and OutletL.F;
* the heat supply.
	
== Initial Conditions ==
* the condenser temperature (OutletL.T);
* the condenser liquid level (Level);
* (NoComps - 1) OutletL (OR OutletV) compositions.
"
	drive!(fields,_)
	return fields
end
condenser(_::Dict{Symbol,Any})=begin
	newModel=condenser()
	newModel.attributes=atributes(newModel,_)
	newModel
end
