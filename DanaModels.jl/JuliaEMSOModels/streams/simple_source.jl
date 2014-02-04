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
type simple_source
	simple_source()=begin
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
				:Brief=>"Valid Phases for Flash Calculation",
				:Valid=>["Vapour-Only", "Liquid-Only","Vapour-Liquid"],
				:Default=>"Vapour-Liquid"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Outlet stream",
				:PosX=>1,
				:PosY=>0.5256,
				:Symbol=>"_{out}",
				:Protected=>true
			]),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Stream Molar Composition"
			]),(NComp)),
			flow_mol ((Symbol=>Any)[
				:Brief=>"Stream Molar Flow Rate"
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
			[
				:(Outlet.z = MolarComposition/sum(MolarComposition)),
				:(Outlet.v = 0),
				:(x = Outlet.z),
				:(y = Outlet.z),
				:(Outlet.h = PP.LiquidEnthalpy(Outlet.T, Outlet.P, x)),
				:(Outlet.v = 1),
				:(x = Outlet.z),
				:(y = Outlet.z),
				:(Outlet.h = PP.VapourEnthalpy(Outlet.T, Outlet.P, y)),
				:([Outlet.v, x, y] = PP.Flash(Outlet.T, Outlet.P, Outlet.z)),
				:(Outlet.h = (1-Outlet.v)*PP.LiquidEnthalpy(Outlet.T, Outlet.P, x) + Outlet.v*PP.VapourEnthalpy(Outlet.T, Outlet.P, y)),
				:(T_Cdeg = Outlet.T - 273.15 * "K"),
				:(Outlet.F = F),
				:(Outlet.P = P),
				:(Outlet.T = T),
			],
			[
				"Stream Molar Composition","Vapour Fraction","Liquid Composition","Vapour Composition","Overall Enthalpy","Vapor Fraction","Liquid Composition","Vapour Composition","Overall Enthalpy","Flash Calculation","Overall Enthalpy","Temperature in �C","Equate Flow","Equate Pressures","Equate Temperatures",
			],
			[:PP,:NComp,:M,:ValidPhases,],
			[:Outlet,:MolarComposition,:F,:T,:T_Cdeg,:P,:x,:y,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	M::Array{molweight }
	ValidPhases::DanaSwitcher 
	Outlet::stream 
	MolarComposition::Array{fraction }
	F::flow_mol 
	T::temperature 
	T_Cdeg::temperature 
	P::pressure 
	x::Array{fraction }
	y::Array{fraction }
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export simple_source
function set(in::simple_source)
	M = PP.MolecularWeight()
	 
end
function setEquationFlow(in::simple_source)
	addEquation(1)
	let switch=ValidPhases
		if switch=="Liquid-Only"
			addEquation(2)
			addEquation(3)
			addEquation(4)
			addEquation(5)
		elseif switch=="Vapour-Only"
			addEquation(6)
			addEquation(7)
			addEquation(8)
			addEquation(9)
		elseif switch=="Vapour-Liquid"
			addEquation(10)
			addEquation(11)
		end
	end
	addEquation(12)
	addEquation(13)
	addEquation(14)
	addEquation(15)
end
function atributes(in::simple_source,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Source"
	fields[:Brief]="Simple Material stream source"
	fields[:Info]="
	This model should be used for boundary streams.
	Usually these streams are known and come from another process
	units.

	The user should specify:
	 * Total molar flow
	 * Temperature
	 * Pressure
	 * Molar composition
"
	drive!(fields,_)
	return fields
end
simple_source(_::Dict{Symbol,Any})=begin
	newModel=simple_source()
	newModel.attributes=atributes(newModel,_)
	newModel
end
