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
#*----------------------------------------------------------------------
#* Author: Paula B. Staudt
#* $Id$
#*--------------------------------------------------------------------
type flash
	flash()=begin
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
			volume ((Symbol=>Any)[
				:Brief=>"Total Volume of the flash"
			]),
			fill(molweight()),
			DanaSwitcher ((Symbol=>Any)[
				:Valid=>["vertical","horizontal"],
				:Default=>"vertical"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Vessel diameter"
			]),
			stream((Symbol=>Any)[
				:Brief=>"Feed Stream",
				:PosX=>0,
				:PosY=>0.5421,
				:Symbol=>"_{in}"
			]),
			liquid_stream((Symbol=>Any)[
				:Brief=>"Liquid outlet stream",
				:PosX=>0.4790,
				:PosY=>1,
				:Symbol=>"_{outL}"
			]),
			vapour_stream((Symbol=>Any)[
				:Brief=>"Vapour outlet stream",
				:PosX=>0.4877,
				:PosY=>0,
				:Symbol=>"_{outV}"
			]),
			energy_stream ((Symbol=>Any)[
				:Brief=>"Rate of heat supply",
				:PosX=>1,
				:PosY=>0.7559,
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
				:Brief=>"liquid height"
			]),
			area ((Symbol=>Any)[
				:Brief=>"Flash Cross section area"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Vapour Molar fraction",
				:Symbol=>"\\ksi"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Vapourization fraction",
				:Symbol=>"\\phi"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Pressure Ratio",
				:Symbol=>"P_{ratio}"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Pressure Drop",
				:DisplayUnit=>"kPa",
				:Symbol=>"\\Delta P"
			]),
			[
				:(diff(M)=Inlet.F*Inlet.z - OutletL.F*OutletL.z - OutletV.F*OutletV.z),
				:(diff(E) = Inlet.F*Inlet.h - OutletL.F*OutletL.h - OutletV.F*OutletV.h + InletQ.Q),
				:(M = ML*OutletL.z + MV*OutletV.z),
				:(E = ML*OutletL.h + MV*OutletV.h - OutletL.P*V),
				:(sum(OutletL.z)=1.0),
				:(sum(OutletL.z)=sum(OutletV.z)),
				:(OutletV.F = Inlet.F * vfrac),
				:(OutletV.F = (OutletV.F + OutletL.F) * vfrac),
				:(MV = (ML + MV) * vMfrac),
				:(vL = PP.LiquidVolume(OutletL.T, OutletL.P, OutletL.z)),
				:(vV = PP.VapourVolume(OutletV.T, OutletV.P, OutletV.z)),
				:(PP.LiquidFugacityCoefficient(OutletL.T, OutletL.P, OutletL.z)*OutletL.z = PP.VapourFugacityCoefficient(OutletV.T, OutletV.P, OutletV.z)*OutletV.z),
				:(OutletV.T = OutletL.T),
				:(OutletV.P = OutletL.P),
				:(OutletL.P = Inlet.P - Pdrop),
				:(OutletL.P = Inlet.P * Pratio),
				:(V = ML * vL + MV * vV),
				:(Across = 0.5 * asin(1) * diameter^2),
				:(ML * vL = Across * Level),
				:(Across = 0.25*diameter^2 * (asin(1) - asin((diameter - 2*Level)/diameter)) + (Level - 0.5*diameter)*sqrt(Level*(diameter - Level))),
				:(0.5 * asin(1) * diameter^2 * ML* vL = Across * V),
			],
			[
				"Component Molar Balance","Energy Balance","Molar Holdup","Energy Holdup","Mol fraction normalisation","Mol fraction normalisation","Vaporization Ratio","Vaporization Ratio","Vaporization Fraction","Liquid Volume","Vapour Volume","Chemical Equilibrium","Thermal Equilibrium","Mechanical Equilibrium","Pressure Drop","Pressure Ratio","Geometry Constraint","Cross Section Area","Liquid Level","Cylindrical Side Area","Liquid Level",
			],
			[:PP,:NComp,:V,:Mw,:orientation,:diameter,],
			[:Inlet,:OutletL,:OutletV,:InletQ,:M,:ML,:MV,:E,:vL,:vV,:Level,:Across,:vMfrac,:vfrac,:Pratio,:Pdrop,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	V::volume 
	Mw::Array{molweight}
	orientation::DanaSwitcher 
	diameter::length 
	Inlet::stream
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
	Across::area 
	vMfrac::positive 
	vfrac::positive 
	Pratio::positive 
	Pdrop::press_delta 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export flash
function set(in::flash)
	Mw=PP.MolecularWeight()
	 
end
function setEquationFlow(in::flash)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
	if Inlet.F > 0 
		addEquation(7)
	else
		addEquation(8)
	end
	addEquation(9)
	addEquation(10)
	addEquation(11)
	addEquation(12)
	addEquation(13)
	addEquation(14)
	addEquation(15)
	addEquation(16)
	addEquation(17)
	let switch=orientation
		if switch=="vertical"
			addEquation(18)
			addEquation(19)
		elseif switch=="horizontal"
			addEquation(20)
			addEquation(21)
		end
	end
end
function atributes(in::flash,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Flash"
	fields[:Brief]="Model of a dynamic flash."
	fields[:Info]="== Assumptions ==
* both phases are perfectly mixed.
	
== Specify ==
* the feed stream;
* the outlet flows: OutletV.F and OutletL.F.

== Initial Conditions ==
* the flash initial temperature (OutletL.T);
* the flash initial level (Level);
* (NoComps - 1) OutletL (OR OutletV) compositions.
"
	drive!(fields,_)
	return fields
end
flash(_::Dict{Symbol,Any})=begin
	newModel=flash()
	newModel.attributes=atributes(newModel,_)
	newModel
end
