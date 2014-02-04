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
#* Author: Based on Models written by Paula B. Staudt
#* $Id$
#*--------------------------------------------------------------------
# The complete documentation for these models needs to be updated !!!
type User_trayBasic
	User_trayBasic()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin ((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger(),
			stream ((Symbol=>Any)[
				:Brief=>"Feed stream",
				:PosX=>0,
				:PosY=>0.4932,
				:Hidden=>true
			]),
			liquid_stream ((Symbol=>Any)[
				:Brief=>"liquid Sidestream",
				:Hidden=>true
			]),
			vapour_stream ((Symbol=>Any)[
				:Brief=>"vapour Sidestream",
				:Hidden=>true
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
			[
				:(diff(M)=Inlet.F*Inlet.z + InletL.F*InletL.z + InletV.F*InletV.z- OutletL.F*OutletL.z - OutletV.F*OutletV.z- LiquidSideStream.F*LiquidSideStream.z-VapourSideStream.F*VapourSideStream.z),
				:(M = ML*OutletL.z + MV*OutletV.z),
				:(sum(OutletL.z)= 1.0),
				:(sum(OutletL.z)= sum(OutletV.z)),
				:(vL = PP.LiquidVolume(OutletL.T, OutletL.P, OutletL.z)),
				:(vV = PP.VapourVolume(OutletV.T, OutletV.P, OutletV.z)),
				:(PP.LiquidFugacityCoefficient(OutletL.T, OutletL.P, OutletL.z)*OutletL.z = PP.VapourFugacityCoefficient(OutletV.T, OutletV.P, yideal)*yideal),
				:(OutletV.T = OutletL.T),
				:(OutletV.P = OutletL.P),
				:(OutletV.T = VapourSideStream.T),
				:(OutletL.T = LiquidSideStream.T),
				:(OutletV.P= VapourSideStream.P),
				:(OutletL.P = LiquidSideStream.P),
				:(OutletL.z= LiquidSideStream.z),
				:(OutletV.z= VapourSideStream.z),
			],
			[
				"Component Molar Balance","Molar Holdup","Mol fraction normalisation","","Liquid Volume","Vapour Volume","Chemical Equilibrium","Thermal Equilibrium","Mechanical Equilibrium","Thermal Equilibrium Vapour Side Stream","Thermal Equilibrium Liquid Side Stream","Mechanical Equilibrium Vapour Side Stream","Mechanical Equilibrium Liquid Side Stream","Composition Liquid Side Stream","Composition Vapour Side Stream",
			],
			[:PP,:NComp,],
			[:Inlet,:LiquidSideStream,:VapourSideStream,:InletL,:InletV,:OutletL,:OutletV,:M,:ML,:MV,:E,:vL,:vV,:Level,:yideal,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger
	Inlet::stream 
	LiquidSideStream::liquid_stream 
	VapourSideStream::vapour_stream 
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
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export User_trayBasic
function setEquationFlow(in::User_trayBasic)
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
	addEquation(15)
end
function atributes(in::User_trayBasic,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Icon]="icon/Tray"
	fields[:Brief]="Basic description of a tray column model."
	fields[:Info]="To be updated"
	drive!(fields,_)
	return fields
end
User_trayBasic(_::Dict{Symbol,Any})=begin
	newModel=User_trayBasic()
	newModel.attributes=atributes(newModel,_)
	newModel
end
