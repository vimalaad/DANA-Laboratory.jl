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
#* Author: Rafael de P. Soares and Paula B. Staudt
#* $Id$
#*--------------------------------------------------------------------
type pfr
	pfr()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin ((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of components"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of reactions"
			]),
			fill(DanaReal ((Symbol=>Any)[
				:Brief=>"Stoichiometric Matrix"
			]),(NComp, NReac)),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of points of discretization",
				:Default=>10
			]),
			fill(molweight ((Symbol=>Any)[
				:Brief=>"Component Mol Weight"
			]),(NComp)),
			length ((Symbol=>Any)[
				:Brief=>"Reactor Length"
			]),
			area ((Symbol=>Any)[
				:Brief=>"Cross section area"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet Stream",
				:PosX=>0,
				:PosY=>0.5076,
				:Symbol=>"_{in}"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Outlet Stream",
				:PosX=>1,
				:PosY=>0.5236,
				:Symbol=>"_{out}"
			]),
			fill(vapour_stream()),
			fill(vol_mol()),
			fill(dens_mass()),
			fill(heat_rate()),
			fill(mol ((Symbol=>Any)[
				:Brief=>"Molar holdup"
			]),(NComp, NDisc)),
			fill(mol ((Symbol=>Any)[
				:Brief=>"Molar holdup"
			]),(NDisc)),
			fill(conc_mol ((Symbol=>Any)[
				:Brief=>"Components concentration",
				:Lower=>-1e-6
			]),(NComp, NDisc)),
			fill(energy ((Symbol=>Any)[
				:Brief=>"Total Energy Holdup on element"
			]),(NDisc)),
			fill(reaction_mol()),
			fill(heat_reaction()),
			[
				:(str(1).F = Inlet.F),
				:(str(1).T = Inlet.T),
				:(str(1).P = Inlet.P),
				:(str(1).z = Inlet.z),
				:(Outlet.F = str(NDisc+1).F),
				:(Outlet.T = str(NDisc+1).T),
				:(Outlet.P = str(NDisc+1).P),
				:(Outlet.z = str(NDisc+1).z),
				:(Outlet.h = str(NDisc+1).h),
				:(Outlet.v = str(NDisc+1).v),
				:(diff(M([1:NComp],[1:NDisc])) = (str([1:NDisc]).F*str([1:NDisc]).[1:NDisc]([1:NComp]) - str([1:NDisc]+1).F*str([1:NDisc]+1).[1:NDisc]([1:NComp])) + sum(stoic([1:NComp],:)*r(:, [1:NDisc])) * Across*L/NDisc),
				:(diff(E([1:NDisc])) = str([1:NDisc]).F*str([1:NDisc]).h - str([1:NDisc]+1).F*str([1:NDisc]+1).h + sum(Hr(:,[1:NDisc])*r(:,[1:NDisc])) * Across*L/NDisc - q([1:NDisc])),
				:(E([1:NDisc]) = Mt([1:NDisc])*str([1:NDisc]+1).h - str([1:NDisc]+1).P*Across*L/NDisc),
				:(str([1:NDisc]+1).F*vol([1:NDisc]+1)*rho([1:NDisc]+1) = str([1:NDisc]).F*vol([1:NDisc])*rho([1:NDisc])),
				:(C(:,[1:NDisc]) * Across*L/NDisc = M(:,[1:NDisc])),
				:(Across*L/NDisc = Mt([1:NDisc]) * vol([1:NDisc])),
				:(str([1:NDisc]+1).[1:NDisc] * Mt([1:NDisc]) = M(:,[1:NDisc])),
				:(vol([1:NDisc+1]) = PP.VapourVolume(str([1:NDisc+1]).T, str([1:NDisc+1]).P, str([1:NDisc+1]).[1:NDisc+1])),
				:(rho([1:NDisc+1]) = PP.VapourDensity(str([1:NDisc+1]).T, str([1:NDisc+1]).P, str([1:NDisc+1]).[1:NDisc+1])),
			],
			[
				"Inlet boundary","","","","Outlet boundary","","","","","","Component Molar Balance","Energy Balance","Energy Holdup","mass flow is considered constant","Molar concentration","Geometrical constraint","Molar fraction","Specific Volume","Specific Mass",
			],
			[:PP,:NComp,:NReac,:stoic,:NDisc,:Mw,:L,:Across,],
			[:Inlet,:Outlet,:str,:vol,:rho,:q,:M,:Mt,:C,:E,:r,:Hr,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	NReac::DanaInteger 
	stoic::Array{DanaReal }
	NDisc::DanaInteger 
	Mw::Array{molweight }
	L::length 
	Across::area 
	Inlet::stream 
	Outlet::stream 
	str::Array{vapour_stream}
	vol::Array{vol_mol}
	rho::Array{dens_mass}
	q::Array{heat_rate}
	M::Array{mol }
	Mt::Array{mol }
	C::Array{conc_mol }
	E::Array{energy }
	r::Array{reaction_mol}
	Hr::Array{heat_reaction}
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export pfr
function set(in::pfr)
	Mw = PP.MolecularWeight()
	 
end
function setEquationFlow(in::pfr)
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
	#Hf(:,z) = PP.IdealGasEnthalpyOfFormation(str(z+1).T);
	#Hr(:,z) = -sum(stoic*Hf(:, z));
	addEquation(18)
	addEquation(19)
end
function atributes(in::pfr,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Brief]="Model of a Generic PFR with constant mass holdup"
	fields[:Icon]="icon/pfr"
	fields[:Info]="== Requires the information of ==
* Reaction values
* Heat of reaction
* Pressure profile
"
	drive!(fields,_)
	return fields
end
pfr(_::Dict{Symbol,Any})=begin
	newModel=pfr()
	newModel.attributes=atributes(newModel,_)
	newModel
end
