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
#* Authors: Andrey Copat, Estefane S. Horn, Marcos L. Alencastro
#* $Id$
#*--------------------------------------------------------------------
type Hidraulic_Turbine
	Hidraulic_Turbine()=begin
		NComp=outers.NComp
		PP=outers.PP
		new(
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of chemical components",
				:Lower=>1
			]),
			DanaPlugin ((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			fill(molweight ((Symbol=>Any)[
				:Brief=>"Molar Weight"
			]),(NComp)),
			efficiency ((Symbol=>Any)[
				:Brief=>"Turbine efficiency"
			]),
			efficiency ((Symbol=>Any)[
				:Brief=>"Brake efficiency"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Volumetric expansivity",
				:Unit=>"1/K"
			]),
			head ((Symbol=>Any)[
				:Brief=>"Head Developed"
			]),
			power ((Symbol=>Any)[
				:Brief=>"Fluid Power"
			]),
			power ((Symbol=>Any)[
				:Brief=>"Brake Power"
			]),
			power ((Symbol=>Any)[
				:Brief=>"Eletrical Potency"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Pressure Ratio"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Pressure Drop",
				:DisplayUnit=>"kPa",
				:Symbol=>"\\Delta P"
			]),
			molweight ((Symbol=>Any)[
				:Brief=>"Mixture Molar Weight"
			]),
			dens_mass ((Symbol=>Any)[
				:Brief=>"Specific Mass"
			]),
			cp_mol ((Symbol=>Any)[
				:Brief=>"Heat Capacity"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet stream",
				:PosX=>0,
				:PosY=>0.5086,
				:Symbol=>"_{in}"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Outlet stream",
				:PosX=>1,
				:PosY=>0.5022,
				:Symbol=>"_{out}"
			]),
			[
				:(Mwm = sum(Mw*Inlet.z)),
				:(rho = PP.LiquidDensity(Inlet.T,Inlet.P,Inlet.z)),
				:(Outlet.v = PP.VapourFraction(Outlet.T, Outlet.P, Outlet.z)),
				:(Cp = PP.LiquidCp(Inlet.T,Inlet.P,Inlet.z)),
				:(Outlet.P = Inlet.P * Pratio),
				:(Outlet.P = Inlet.P - Pdrop),
				:(FPower * rho = -Pdrop * Inlet.F * Mwm),
				:(BPower = FPower * Eff),
				:(EPower = BPower * Meff),
				:((Outlet.T - Inlet.T) * rho * Cp = (Outlet.h - Inlet.h) * rho + Pdrop * Mwm * (1-Beta*Inlet.T)),
				:((Outlet.h - Inlet.h) * rho = -Pdrop * Mwm),
				:(Outlet.F = Inlet.F),
				:(Outlet.z = Inlet.z),
				:(Head = Outlet.h - Inlet.h),
			],
			[
				"Calculate Mwm for Inlet Mixture","Calculate rho using a External Physical Properties Routine","Calculate Outlet Vapour Fraction","Calculate Cp Using a External Physical Properties Routine","Pressure Ratio","Pressure Drop","Calculate Fluid Power","Calculate Brake Power","Calculate Eletric Power","Calculate Outlet Temperature","Calculate Outlet Enthalpy","Molar Balance","Calculate Outlet Composition","Calculate Head",
			],
			[:NComp,:PP,:Mw,],
			[:Eff,:Meff,:Beta,:Head,:FPower,:BPower,:EPower,:Pratio,:Pdrop,:Mwm,:rho,:Cp,:Inlet,:Outlet,]
		)
	end
	NComp::DanaInteger 
	PP::DanaPlugin 
	Mw::Array{molweight }
	Eff::efficiency 
	Meff::efficiency 
	Beta::positive 
	Head::head 
	FPower::power 
	BPower::power 
	EPower::power 
	Pratio::positive 
	Pdrop::press_delta 
	Mwm::molweight 
	rho::dens_mass 
	Cp::cp_mol 
	Inlet::stream 
	Outlet::stream 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Hidraulic_Turbine
function set(in::Hidraulic_Turbine)
	Mw = PP.MolecularWeight()
	 
end
function setEquationFlow(in::Hidraulic_Turbine)
	#Mixtures Properties
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
function atributes(in::Hidraulic_Turbine,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/HidraulicTurbine"
	fields[:Brief]="Model of a Hidraulic Turbine."
	fields[:Info]="== Assumptions ==
* Steady State;
* Only Liquid;
* Adiabatic;
* Isentropic.
	
== Specify ==
* the inlet stream;
* the Pressure Increase (Pdiff) OR the outlet pressure (Outlet.P);
* the Turbine efficiency (Eff);
* the Brake efficiency (Meff);
* the Volumetric expansivity (Beta).
"
	drive!(fields,_)
	return fields
end
Hidraulic_Turbine(_::Dict{Symbol,Any})=begin
	newModel=Hidraulic_Turbine()
	newModel.attributes=atributes(newModel,_)
	newModel
end
