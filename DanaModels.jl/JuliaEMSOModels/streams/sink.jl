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
type sink
	sink()=begin
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
				:Brief=>"Density model",
				:Valid=>["volume", "correlation"],
				:Default=>"volume"
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
				:Brief=>"Inlet Stream",
				:PosX=>0,
				:PosY=>0.5308,
				:Symbol=>"_{in}"
			]),
			fraction ((Symbol=>Any)[
				:Brief=>"Vapourization fraction"
			]),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Liquid Molar Fraction",
				:Hidden=>true
			]),(NComp)),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Vapour Molar Fraction",
				:Hidden=>true
			]),(NComp)),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Mass Fraction"
			]),(NComp)),
			molweight ((Symbol=>Any)[
				:Brief=>"Average Mol Weight"
			]),
			volume_mol ((Symbol=>Any)[
				:Brief=>"Molar Volume"
			]),
			volume_mol ((Symbol=>Any)[
				:Brief=>"Standard Molar Volume",
				:Protected=>true
			]),
			dens_mass ((Symbol=>Any)[
				:Brief=>"Stream Mass Density"
			]),
			dens_mol ((Symbol=>Any)[
				:Brief=>"Stream Molar Density"
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
			entr_mol ((Symbol=>Any)[
				:Brief=>"Stream Entropy"
			]),
			temperature ((Symbol=>Any)[
				:Brief=>"Temperature in �C",
				:Lower=>-200
			]),
			[
				:([v, x, y] = PP.FlashPH(Inlet.P, Inlet.h, Inlet.z)),
				:(Mw = sum(M*Inlet.z)),
				:(rhom * vm = 1),
				:(rho * ((1-v)/PP.LiquidDensity(Inlet.T,Inlet.P,x) + v/PP.VapourDensity(Inlet.T,Inlet.P,y)) = 1),
				:(rhom * Mw = rho),
				:(Fw = Mw*Inlet.F),
				:(vm = (1-v)*PP.LiquidVolume(Inlet.T, Inlet.P, x) + v*PP.VapourVolume(Inlet.T, Inlet.P, y)),
				:(vm_std = (1-v)*PP.LiquidVolume(T_std, P_std, x) + v*PP.VapourVolume(T_std, P_std, y)),
				:(Fvol = Inlet.F*vm),
				:(Fvol_std = Inlet.F*vm_std),
				:(zmass = M*Inlet.z / Mw),
				:(s = (1-v)*PP.LiquidEntropy(Inlet.T, Inlet.P, x) + v*PP.VapourEntropy(Inlet.T, Inlet.P, y)),
				:(T_Cdeg = Inlet.T - 273.15 * "K"),
			],
			[
				"Flash Calculation","Average Molecular Weight","Molar Density","Mass Density","Mass or Molar Density","Flow Mass","Molar Volume","Standard Molar Volume","Volumetric Flow","Standard Volumetric Flow","Mass Fraction","Overall Entropy","Temperature in �C",
			],
			[:PP,:NComp,:M,:rhoModel,:T_std,:P_std,],
			[:Inlet,:v,:x,:y,:zmass,:Mw,:vm,:vm_std,:rho,:rhom,:Fw,:Fvol,:Fvol_std,:s,:T_Cdeg,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	M::Array{molweight }
	rhoModel::DanaSwitcher 
	T_std::temperature 
	P_std::pressure 
	Inlet::stream 
	v::fraction 
	x::Array{fraction }
	y::Array{fraction }
	zmass::Array{fraction }
	Mw::molweight 
	vm::volume_mol 
	vm_std::volume_mol 
	rho::dens_mass 
	rhom::dens_mol 
	Fw::flow_mass 
	Fvol::flow_vol 
	Fvol_std::flow_vol 
	s::entr_mol 
	T_Cdeg::temperature 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export sink
function set(in::sink)
	M = PP.MolecularWeight()
	 
end
function setEquationFlow(in::sink)
	addEquation(1)
	addEquation(2)
	let switch=rhoModel
		if switch=="volume"
			addEquation(3)
		elseif switch=="correlation"
			addEquation(4)
		end
	end
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
function atributes(in::sink,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Sink"
	fields[:Brief]="Material stream sink"
	fields[:Info]="
	This model should be used for boundary streams when additional
	information about the stream is desired.

	Some of the additional informations calculated by this models are:
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
sink(_::Dict{Symbol,Any})=begin
	newModel=sink()
	newModel.attributes=atributes(newModel,_)
	newModel
end
