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
type source
	source()=begin
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
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Molar or Mass Composition",
				:Valid=>["Molar", "Mass"],
				:Default=>"Molar"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Valid Phases for Flash Calculation",
				:Valid=>["Vapour-Only", "Liquid-Only","Vapour-Liquid"],
				:Default=>"Vapour-Liquid"
			]),
			temperature ((Symbol=>Any)[
				:Brief=>"Standard temperature",
				:Hidden=>true,
				:Default=>298.15
			]),
			pressure ((Symbol=>Any)[
				:Brief=>"Standard pressure",
				:Hidden=>true,
				:Default=>1
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Outlet stream",
				:PosX=>1,
				:PosY=>0.5256,
				:Symbol=>"_{out}",
				:Protected=>true
			]),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Stream Composition"
			]),(NComp)),
			flow_mol ((Symbol=>Any)[
				:Brief=>"Stream Molar Flow Rate"
			]),
			flow_mass ((Symbol=>Any)[
				:Brief=>"Stream Mass Flow"
			]),
			flow_vol ((Symbol=>Any)[
				:Brief=>"Volumetric Flow"
			]),
			flow_vol ((Symbol=>Any)[
				:Brief=>"Standard Volumetric Flow (1 atm, 20 C)"
			]),
			temperature ((Symbol=>Any)[
				:Brief=>"Stream Temperature"
			]),
			temperature ((Symbol=>Any)[
				:Brief=>"Temperature in �C",
				:Lower=>-200
			]),
			pressure ((Symbol=>Any)[
				:Brief=>"Stream Pressure"
			]),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Liquid Molar Fraction",
				:Hidden=>true
			]),(NComp)),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Vapour Molar Fraction",
				:Hidden=>true
			]),(NComp)),
			molweight ((Symbol=>Any)[
				:Brief=>"Average Mol Weight",
				:Protected=>true
			]),
			volume_mol ((Symbol=>Any)[
				:Brief=>"Molar Volume",
				:Protected=>true
			]),
			volume_mol ((Symbol=>Any)[
				:Brief=>"Standard Molar Volume",
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
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Mass Fraction",
				:Protected=>true
			]),(NComp)),
			[
				:(Outlet.z = Composition/sum(Composition)),
				:(zmass = M*Outlet.z / Mw),
				:(zmass = Composition/sum(Composition)),
				:(Outlet.z*sum(zmass/M) = zmass/M),
				:(Outlet.v = 0),
				:(x = Outlet.z),
				:(y = Outlet.z),
				:(Outlet.h = PP.LiquidEnthalpy(Outlet.T, Outlet.P, x)),
				:(vm = PP.LiquidVolume(Outlet.T, Outlet.P, x)),
				:(vm_std = PP.LiquidVolume(T_std, P_std, x)),
				:(Outlet.v = 1),
				:(x = Outlet.z),
				:(y = Outlet.z),
				:(Outlet.h = PP.VapourEnthalpy(Outlet.T, Outlet.P, y)),
				:(vm = PP.VapourVolume(Outlet.T, Outlet.P, y)),
				:(vm_std = PP.VapourVolume(T_std, P_std, y)),
				:([Outlet.v, x, y] = PP.Flash(Outlet.T, Outlet.P, Outlet.z)),
				:(Outlet.h = (1-Outlet.v)*PP.LiquidEnthalpy(Outlet.T, Outlet.P, x) + Outlet.v*PP.VapourEnthalpy(Outlet.T, Outlet.P, y)),
				:(vm = (1-Outlet.v)*PP.LiquidVolume(Outlet.T, Outlet.P, x) + Outlet.v*PP.VapourVolume(Outlet.T, Outlet.P, y)),
				:(vm_std = (1-Outlet.v)*PP.LiquidVolume(T_std, P_std, x) + Outlet.v*PP.VapourVolume(T_std, P_std, y)),
				:(rhom * vm = 1),
				:(Mw = sum(M*Outlet.z)),
				:(rhom * Mw = rho),
				:(Fw = Mw*Outlet.F),
				:(Fvol = Outlet.F*vm),
				:(Fvol_std = Outlet.F*vm_std),
				:(T_Cdeg = Outlet.T - 273.15 * "K"),
				:(Outlet.F = F),
				:(Outlet.P = P),
				:(Outlet.T = T),
			],
			[
				"Stream Molar Composition","Stream Mass Composition","Stream Mass Composition","Stream Molar Composition","Vapour Fraction","Liquid Composition","Vapour Composition","Overall Enthalpy","Molar Volume","Standard Molar Volume","Vapor Fraction","Liquid Composition","Vapour Composition","Overall Enthalpy","Molar Volume","Standard Molar Volume","Flash Calculation","Overall Enthalpy","Molar Volume","Standard Molar Volume","Molar Density","Average Molecular Weight","Mass or Molar Density","Flow Mass","Volumetric Flow","Standard Volumetric Flow","Temperature in �C","Equate Flow","Equate Pressures","Equate Temperatures",
			],
			[:PP,:NComp,:M,:CompositionBasis,:ValidPhases,:T_std,:P_std,],
			[:Outlet,:Composition,:F,:Fw,:Fvol,:Fvol_std,:T,:T_Cdeg,:P,:x,:y,:Mw,:vm,:vm_std,:rho,:rhom,:zmass,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	M::Array{molweight }
	CompositionBasis::DanaSwitcher 
	ValidPhases::DanaSwitcher 
	T_std::temperature 
	P_std::pressure 
	Outlet::stream 
	Composition::Array{fraction }
	F::flow_mol 
	Fw::flow_mass 
	Fvol::flow_vol 
	Fvol_std::flow_vol 
	T::temperature 
	T_Cdeg::temperature 
	P::pressure 
	x::Array{fraction }
	y::Array{fraction }
	Mw::molweight 
	vm::volume_mol 
	vm_std::volume_mol 
	rho::dens_mass 
	rhom::dens_mol 
	zmass::Array{fraction }
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export source
function set(in::source)
	M = PP.MolecularWeight()
	 
end
function setEquationFlow(in::source)
	let switch=CompositionBasis
		if switch=="Molar"
			addEquation(1)
			addEquation(2)
		elseif switch=="Mass"
			addEquation(3)
			addEquation(4)
		end
	end
	let switch=ValidPhases
		if switch=="Liquid-Only"
			addEquation(5)
			addEquation(6)
			addEquation(7)
			addEquation(8)
			addEquation(9)
			addEquation(10)
		elseif switch=="Vapour-Only"
			addEquation(11)
			addEquation(12)
			addEquation(13)
			addEquation(14)
			addEquation(15)
			addEquation(16)
		elseif switch=="Vapour-Liquid"
			addEquation(17)
			addEquation(18)
			addEquation(19)
			addEquation(20)
		end
	end
	addEquation(21)
	addEquation(22)
	addEquation(23)
	addEquation(24)
	addEquation(25)
	addEquation(26)
	addEquation(27)
	addEquation(28)
	addEquation(29)
	addEquation(30)
end
function atributes(in::source,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Source"
	fields[:Brief]="Material stream source"
	fields[:Info]="
	This model should be used for boundary streams.
	Usually these streams are known and come from another process
	units.

	The user should specify:
	 * Total molar (mass or volumetric) flow
	 * Temperature
	 * Pressure
	 * Molar or mass composition
	
	No matter the specification set, the model will calculate some
	additional properties:
	 * Mass density
	 * Mass flow
	 * Mass compostions
	 * Specific volume
	 * Vapour fraction
	 * Volumetric flow
	 * Liquid and Vapour compositions
	"
	drive!(fields,_)
	return fields
end
source(_::Dict{Symbol,Any})=begin
	newModel=source()
	newModel.attributes=atributes(newModel,_)
	newModel
end
