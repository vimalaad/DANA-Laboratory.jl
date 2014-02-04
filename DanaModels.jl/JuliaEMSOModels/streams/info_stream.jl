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
#*--------------------------------------------------------------------
#* Model of basic streams
#*----------------------------------------------------------------------
#* Author: Paula B. Staudt and Rafael de P. Soares
#* $Id$
#*---------------------------------------------------------------------
type info_stream
	info_stream()=begin
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
			fill(molweight ((Symbol=>Any)[
				:Brief=>"Component Mol Weight"
			]),(NComp)),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet Stream",
				:PosX=>0,
				:PosY=>0.5308,
				:Protected=>true ,
				:Symbol=>"_{in}"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Outlet Stream",
				:PosX=>1,
				:PosY=>0.5308,
				:Protected=>true ,
				:Symbol=>"_{out}"
			]),
			fraction ((Symbol=>Any)[
				:Brief=>"Vapourization fraction",
				:Hidden=>true
			]),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Liquid Molar Fraction",
				:Hidden=>true
			]),(NComp)),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Vapour Molar Fraction",
				:Hidden=>true
			]),(NComp)),
			fill(flow_mol ((Symbol=>Any)[
				:Brief=>"Component Molar Flow",
				:Protected=>true
			]),(NComp)),
			flow_mass ((Symbol=>Any)[
				:Brief=>"Total Mass Flow",
				:Protected=>true
			]),
			fill(flow_mass ((Symbol=>Any)[
				:Brief=>"Component Mass Flow",
				:Protected=>true
			]),(NComp)),
			flow_vol ((Symbol=>Any)[
				:Brief=>"Total Volumetric Flow",
				:Protected=>true
			]),
			temperature ((Symbol=>Any)[
				:Brief=>"Temperature in �C",
				:Lower=>-200,
				:Protected=>true
			]),
			viscosity ((Symbol=>Any)[
				:Brief=>"Stream Viscosity",
				:Lower=>0.0001,
				:Symbol=>"\\mu",
				:Protected=>true
			]),
			cp_mol ((Symbol=>Any)[
				:Brief=>"Stream Molar Heat Capacity",
				:Upper=>1e10,
				:Protected=>true
			]),
			conductivity ((Symbol=>Any)[
				:Brief=>"Stream Thermal Conductivity",
				:Default=>1.0,
				:Lower=>1e-5,
				:Upper=>500,
				:Protected=>true
			]),
			molweight ((Symbol=>Any)[
				:Brief=>"Average Mol Weight",
				:Protected=>true
			]),
			volume_mol ((Symbol=>Any)[
				:Brief=>"Molar Volume",
				:Protected=>true
			]),
			dens_mass ((Symbol=>Any)[
				:Brief=>"Stream Mass Density",
				:Protected=>true
			]),
			dens_mol ((Symbol=>Any)[
				:Brief=>"Stream Molar Density",
				:Protected=>true
			]),
			entr_mol ((Symbol=>Any)[
				:Brief=>"Stream Entropy",
				:Protected=>true
			]),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Mass Fraction",
				:Protected=>true
			]),(NComp)),
			[
				:([v, x, y] = PP.FlashPH(Inlet.P, Inlet.h, Inlet.z)),
				:(Mw = sum(M*Inlet.z)),
				:(rho * ((1-v)/PP.LiquidDensity(Inlet.T,Inlet.P,x) + v/PP.VapourDensity(Inlet.T,Inlet.P,y)) = 1),
				:(rhom * Mw = rho),
				:(FwTotal = Mw*Inlet.F),
				:(Fw = FwTotal*zmass),
				:(vm = (1-v)*PP.LiquidVolume(Inlet.T, Inlet.P, x) + v*PP.VapourVolume(Inlet.T,Inlet.P,y)),
				:(FvolTotal = Inlet.F*vm),
				:(zmass = M*Inlet.z / Mw),
				:(Cp = (1-v)*PP.LiquidCp(Inlet.T, Inlet.P, x) + v*PP.VapourCp(Inlet.T,Inlet.P,y)),
				:(Mu = (1-v)*PP.LiquidViscosity(Inlet.T, Inlet.P, x) + v*PP.VapourViscosity(Inlet.T,Inlet.P,y)),
				:(K = (1-v)*PP.LiquidThermalConductivity(Inlet.T, Inlet.P, x) + v*PP.VapourThermalConductivity(Inlet.T,Inlet.P,y)),
				:(s = (1-v)*PP.LiquidEntropy(Inlet.T, Inlet.P, x) + v*PP.VapourEntropy(Inlet.T, Inlet.P, y)),
				:(T_Cdeg = Inlet.T - 273.15 * "K"),
				:(Outlet.F = Inlet.F),
				:(F = Inlet.F*Inlet.z),
				:(Outlet.T = Inlet.T),
				:(Outlet.P = Inlet.P),
				:(Outlet.v = Inlet.v),
				:(Outlet.h = Inlet.h),
				:(Outlet.z= Inlet.z),
			],
			[
				"Flash Calculation","Average Molecular Weight","Mass Density","Mass or Molar Density","Total Flow Mass","Component Flow Mass","Molar Volume","Total Volumetric Flow","Mass Fraction","Stream Heat Capacity","Stream Viscosity","Stream ThermalConductivity","Stream Overall Entropy","Temperature in �C","Outlet Flow","Component Molar Flow","Outlet Temperature","Outlet Pressure","Outlet Vapour Fraction","Outlet Enthalpy","Outlet Composition",
			],
			[:PP,:NComp,:M,],
			[:Inlet,:Outlet,:v,:x,:y,:F,:FwTotal,:Fw,:FvolTotal,:T_Cdeg,:Mu,:Cp,:K,:Mw,:vm,:rho,:rhom,:s,:zmass,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	M::Array{molweight }
	Inlet::stream 
	Outlet::stream 
	v::fraction 
	x::Array{fraction }
	y::Array{fraction }
	F::Array{flow_mol }
	FwTotal::flow_mass 
	Fw::Array{flow_mass }
	FvolTotal::flow_vol 
	T_Cdeg::temperature 
	Mu::viscosity 
	Cp::cp_mol 
	K::conductivity 
	Mw::molweight 
	vm::volume_mol 
	rho::dens_mass 
	rhom::dens_mol 
	s::entr_mol 
	zmass::Array{fraction }
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export info_stream
function set(in::info_stream)
	M = PP.MolecularWeight()
	 
end
function setEquationFlow(in::info_stream)
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
	addEquation(16)
	addEquation(17)
	addEquation(18)
	addEquation(19)
	addEquation(20)
	addEquation(21)
end
function atributes(in::info_stream,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Info_Stream"
	fields[:Brief]="Material stream information"
	fields[:Info]="
	This model should be used for middle streams when additional
	information about the stream is desired.

	Some of the additional informations calculated by this models are:
	 * Mass density
	 * Mass flow
	 * Mass compostions
	 * Specific volume
	 * Vapour fraction
	 * Volumetric flow
	 * Liquid and Vapour compositions
	 * Viscosity
	 * Heat Capacity
	 * Thermal Conductivity
	 * Temperature in Celsius Degrees
	"
	drive!(fields,_)
	return fields
end
info_stream(_::Dict{Symbol,Any})=begin
	newModel=info_stream()
	newModel.attributes=atributes(newModel,_)
	newModel
end
