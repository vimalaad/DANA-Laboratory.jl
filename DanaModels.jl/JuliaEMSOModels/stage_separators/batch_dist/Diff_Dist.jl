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
type Diff_Dist
	Diff_Dist()=begin
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
			area ((Symbol=>Any)[
				:Brief=>"Cross Section Area"
			]),
			volume ((Symbol=>Any)[
				:Brief=>"Total volume"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Feed stream",
				:PosX=>0,
				:PosY=>0.9385,
				:Symbol=>"_{in}"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Liquid inlet stream",
				:PosX=>0.5,
				:PosY=>0.1984,
				:Symbol=>"_{inL}"
			]),
			vapour_stream ((Symbol=>Any)[
				:Brief=>"Vapour outlet stream",
				:PosX=>1,
				:PosY=>0.1984,
				:Symbol=>"_{outV}"
			]),
			energy_stream ((Symbol=>Any)[
				:Brief=>"Heat supplied",
				:PosX=>1,
				:PosY=>0.9578,
				:Symbol=>"_{in}"
			]),
			fill(mol ((Symbol=>Any)[
				:Brief=>"Molar Holdup in the distillator"
			]),(NComp)),
			mol ((Symbol=>Any)[
				:Brief=>"Molar liquid holdup"
			]),
			mol ((Symbol=>Any)[
				:Brief=>"Molar vapour holdup"
			]),
			energy ((Symbol=>Any)[
				:Brief=>"Total Energy holdup on distillator"
			]),
			volume_mol ((Symbol=>Any)[
				:Brief=>"Liquid Molar Volume"
			]),
			volume_mol ((Symbol=>Any)[
				:Brief=>"Vapour Molar volume"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Level of liquid phase",
				:Default=>1,
				:Lower=>0
			]),
			temperature ((Symbol=>Any)[
				:Brief=>"Temperature on distillator"
			]),
			pressure ((Symbol=>Any)[
				:Brief=>"Pressure on distillator"
			]),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Molar Fraction of the Liquid of the distillator"
			]),(NComp)),
			enth_mol ((Symbol=>Any)[
				:Brief=>"Molar Enthalpy of the liquid of the distillator"
			]),
			[
				:(diff(M)= Inlet.F*Inlet.z + InletL.F*InletL.z - OutletV.F*OutletV.z),
				:(diff(E) = Inlet.F*Inlet.h + InletL.F*InletL.h - OutletV.F*OutletV.h + InletQ.Q),
				:(M = ML*x + MV*OutletV.z),
				:(E = ML*h + MV*OutletV.h - P*V),
				:(sum(x)=1.0),
				:(sum(x)=sum(OutletV.z)),
				:(volL = PP.LiquidVolume(T, P, x)),
				:(volV = PP.VapourVolume(OutletV.T, OutletV.P, OutletV.z)),
				:(PP.LiquidFugacityCoefficient(T, P, x)*x = PP.VapourFugacityCoefficient(OutletV.T, OutletV.P, OutletV.z)*OutletV.z),
				:(P = OutletV.P),
				:(T = OutletV.T),
				:(V = ML*volL + MV*volV),
				:(Level = ML*volL/Across),
				:(h = PP.LiquidEnthalpy(T, P, x)),
			],
			[
				"Component Molar Balance","Energy Balance","Molar Holdup","Energy Holdup","Mol fraction normalisation","","Liquid Volume","Vapour Volume","Chemical Equilibrium","Mechanical Equilibrium","Thermal Equilibrium","Geometry Constraint","Level of liquid phase","Enthalpy",
			],
			[:PP,:NComp,:Across,:V,],
			[:Inlet,:InletL,:OutletV,:InletQ,:M,:ML,:MV,:E,:volL,:volV,:Level,:T,:P,:x,:h,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	Across::area 
	V::volume 
	Inlet::stream 
	InletL::stream 
	OutletV::vapour_stream 
	InletQ::energy_stream 
	M::Array{mol }
	ML::mol 
	MV::mol 
	E::energy 
	volL::volume_mol 
	volV::volume_mol 
	Level::length 
	T::temperature 
	P::pressure 
	x::Array{fraction }
	h::enth_mol 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Diff_Dist
function setEquationFlow(in::Diff_Dist)
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
function atributes(in::Diff_Dist,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/BatchDist"
	fields[:Brief]="Model of a Batch Differential Distillation."
	fields[:Info]="== Assumptions ==
* perfect mixing of both phases;
* thermodynamics equilibrium;
* no liquid entrainment in the vapour stream.
	
== Specify ==
* the inlet stream;
* the liquid inlet stream;
* the molar flow of the vapour outlet stream.
	
== Initial Conditions ==
* the distillator temperature (T);
* the distillator liquid level (Level);
* (NoComps - 1) compositions in the distillator or in the OutletV.
"
	drive!(fields,_)
	return fields
end
Diff_Dist(_::Dict{Symbol,Any})=begin
	newModel=Diff_Dist()
	newModel.attributes=atributes(newModel,_)
	newModel
end
