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
type reboiler
	reboiler()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger(),
			area ((Symbol=>Any)[
				:Brief=>"Cross Section Area of reboiler"
			]),
			volume ((Symbol=>Any)[
				:Brief=>"Total volume of reboiler"
			]),
			stream((Symbol=>Any)[
				:Brief=>"Feed Stream",
				:PosX=>0.8127,
				:PosY=>0,
				:Symbol=>"_{in}"
			]),
			stream((Symbol=>Any)[
				:Brief=>"Liquid inlet stream",
				:PosX=>0,
				:PosY=>0.5254,
				:Symbol=>"_{inL}"
			]),
			liquid_stream((Symbol=>Any)[
				:Brief=>"Liquid outlet stream",
				:PosX=>0.2413,
				:PosY=>1,
				:Symbol=>"_{outL}"
			]),
			vapour_stream((Symbol=>Any)[
				:Brief=>"Vapour outlet stream",
				:PosX=>0.5079,
				:PosY=>0,
				:Symbol=>"_{outV}"
			]),
			energy_stream ((Symbol=>Any)[
				:Brief=>"Heat supplied",
				:PosX=>1,
				:PosY=>0.6123,
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
			dens_mass ((Symbol=>Any)[
				:Brief=>"Vapour Density"
			]),
			[
				:(diff(M)= Inlet.F*Inlet.z + InletL.F*InletL.z - OutletL.F*OutletL.z - OutletV.F*OutletV.z),
				:(diff(E) = Inlet.F*Inlet.h + InletL.F*InletL.h - OutletL.F*OutletL.h - OutletV.F*OutletV.h + InletQ.Q),
				:(M = ML*OutletL.z + MV*OutletV.z),
				:(E = ML*OutletL.h + MV*OutletV.h - OutletL.P*V),
				:(sum(OutletL.z)=1.0),
				:(sum(OutletL.z)=sum(OutletV.z)),
				:(rhoV = PP.VapourDensity(OutletV.T, OutletV.P, OutletV.z)),
				:(vL = PP.LiquidVolume(OutletL.T, OutletL.P, OutletL.z)),
				:(vV = PP.VapourVolume(OutletV.T, OutletV.P, OutletV.z)),
				:(PP.LiquidFugacityCoefficient(OutletL.T, OutletL.P, OutletL.z)*OutletL.z = PP.VapourFugacityCoefficient(OutletV.T, OutletV.P, OutletV.z)*OutletV.z),
				:(OutletL.P = OutletV.P),
				:(OutletL.T = OutletV.T),
				:(V = ML*vL + MV*vV),
				:(Level = ML*vL/Across),
			],
			[
				"Component Molar Balance","Energy Balance","Molar Holdup","Energy Holdup","Mol fraction normalisation","","Vapour Density","Liquid Volume","Vapour Volume","Chemical Equilibrium","Mechanical Equilibrium","Thermal Equilibrium","Geometry Constraint","Level of liquid phase",
			],
			[:PP,:NComp,:Across,:V,],
			[:Inlet,:InletL,:OutletL,:OutletV,:InletQ,:M,:ML,:MV,:E,:vL,:vV,:Level,:rhoV,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	Across::area 
	V::volume 
	Inlet::stream
	InletL::stream
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
	rhoV::dens_mass 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export reboiler
function setEquationFlow(in::reboiler)
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
	addEquation(14)
end
function atributes(in::reboiler,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Reboiler"
	fields[:Brief]="Model of a dynamic reboiler - kettle."
	fields[:Info]="== Assumptions ==

* perfect mixing of both phases;
* thermodynamics equilibrium;
* no liquid entrainment in the vapour stream.
	
== Specify ==

* the inlet stream;
* the liquid inlet stream;
* the outlet flows: OutletV.F and OutletL.F;
* the heat supply.
	
== Initial Conditions ==

* the reboiler temperature (OutletL.T);
* the reboiler liquid level (Level);
* (NoComps - 1) OutletL (OR OutletV) compositions.
"
	drive!(fields,_)
	return fields
end
reboiler(_::Dict{Symbol,Any})=begin
	newModel=reboiler()
	newModel.attributes=atributes(newModel,_)
	newModel
end
