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
type trayBasic
	trayBasic()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger(),
			volume((Symbol=>Any)[
				:Brief=>"Total Volume of the tray"
			]),
			heat_rate ((Symbol=>Any)[
				:Brief=>"Rate of heat supply"
			]),
			area ((Symbol=>Any)[
				:Brief=>"Plate area = Atray - Adowncomer"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Feed stream",
				:PosX=>0,
				:PosY=>0.4932,
				:Symbol=>"_{in}"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet liquid stream",
				:PosX=>0.5195,
				:PosY=>0,
				:Symbol=>"_{inL}"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet vapour stream",
				:PosX=>0.4994,
				:PosY=>1,
				:Symbol=>"_{inV}"
			]),
			liquid_stream ((Symbol=>Any)[
				:Brief=>"Outlet liquid stream",
				:PosX=>0.8277,
				:PosY=>1,
				:Symbol=>"_{outL}"
			]),
			vapour_stream ((Symbol=>Any)[
				:Brief=>"Outlet vapour stream",
				:PosX=>0.8043,
				:PosY=>0,
				:Symbol=>"_{outV}"
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
				:Brief=>"Height of clear liquid on plate"
			]),
			fill(fraction()),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Murphree efficiency"
			]),
			[
				:(diff(M)=Inlet.F*Inlet.z + InletL.F*InletL.z + InletV.F*InletV.z - OutletL.F*OutletL.z - OutletV.F*OutletV.z),
				:(diff(E) = ( Inlet.F*Inlet.h + InletL.F*InletL.h + InletV.F*InletV.h - OutletL.F*OutletL.h - OutletV.F*OutletV.h + Q )),
				:(M = ML*OutletL.z + MV*OutletV.z),
				:(E = ML*OutletL.h + MV*OutletV.h - OutletL.P*V),
				:(sum(OutletL.z)= 1.0),
				:(sum(OutletL.z)= sum(OutletV.z)),
				:(vL = PP.LiquidVolume(OutletL.T, OutletL.P, OutletL.z)),
				:(vV = PP.VapourVolume(OutletV.T, OutletV.P, OutletV.z)),
				:(PP.LiquidFugacityCoefficient(OutletL.T, OutletL.P, OutletL.z)*OutletL.z = PP.VapourFugacityCoefficient(OutletV.T, OutletV.P, yideal)*yideal),
				:(OutletV.z = Emv * (yideal - InletV.z) + InletV.z),
				:(OutletV.T = OutletL.T),
				:(OutletV.P = OutletL.P),
				:(V = ML* vL + MV*vV),
				:(Level = ML*vL/Ap),
			],
			[
				"Component Molar Balance","Energy Balance","Molar Holdup","Energy Holdup","Mol fraction normalisation","","Liquid Volume","Vapour Volume","Chemical Equilibrium","Murphree Efficiency","Thermal Equilibrium","Mechanical Equilibrium","Geometry Constraint","Level of clear liquid over the weir",
			],
			[:PP,:NComp,:V,:Q,:Ap,],
			[:Inlet,:InletL,:InletV,:OutletL,:OutletV,:M,:ML,:MV,:E,:vL,:vV,:Level,:yideal,:Emv,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	V::volume
	Q::heat_rate 
	Ap::area 
	Inlet::stream 
	InletL::stream 
	InletV::stream 
	OutletL::liquid_stream 
	OutletV::vapour_stream 
	M::Array{mol }
	ML::mol 
	MV::mol 
	E::energy 
	vL::volume_mol 
	vV::volume_mol 
	Level::length 
	yideal::Array{fraction}
	Emv::DanaReal 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export trayBasic
function setEquationFlow(in::trayBasic)
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
function atributes(in::trayBasic,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Icon]="icon/Tray"
	fields[:Brief]="Basic equations of a tray column model."
	fields[:Info]="This model contains only the main equations of a column tray equilibrium model without
the hidraulic equations.
	
== Assumptions ==
* both phases (liquid and vapour) exists all the time;
* thermodymanic equilibrium with Murphree plate efficiency;
* no entrainment of liquid or vapour phase;
* no weeping;
* the dymanics in the downcomer are neglected.
"
	drive!(fields,_)
	return fields
end
trayBasic(_::Dict{Symbol,Any})=begin
	newModel=trayBasic()
	newModel.attributes=atributes(newModel,_)
	newModel
end
