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
#*---------------------------------------------------------------------
#* Author: Estefane Horn, N�bia do Carmo Ferreira
#*$Id$									
#*-------------------------------------------------------------------
type valve
	valve()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaSwitcher ((Symbol=>Any)[
				:Valid=>["linear", "parabolic", "equal", "quick", "hyperbolic"],
				:Default=>"linear"
			]),
			DanaPlugin ((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of chemical components",
				:Lower=>1
			]),
			dens_mass(),
			positive ((Symbol=>Any)[
				:Brief=>"Pressure Ratio",
				:Symbol=>"P_{ratio}"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Pressure Drop",
				:DisplayUnit=>"kPa",
				:Symbol=>"\\Delta P"
			]),
			flow_vol ((Symbol=>Any)[
				:Brief=>"Volumetric Flow"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Opening Function"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Valve Coefficient",
				:Unit=>"m^3/h/kPa^0.5"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Specific Gravity"
			]),
			dens_mass(),
			vol_mol ((Symbol=>Any)[
				:Brief=>"Mixture Molar Volume"
			]),
			fraction ((Symbol=>Any)[
				:Brief=>"Opening"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet stream",
				:PosX=>0,
				:PosY=>0.7365,
				:Symbol=>"_{in}"
			]),
			streamPH ((Symbol=>Any)[
				:Brief=>"Outlet stream",
				:PosX=>1,
				:PosY=>0.7365,
				:Symbol=>"_{out}"
			]),
			[
				:(Outlet.P = Inlet.P - Pdrop),
				:(Outlet.P = Inlet.P * Pratio),
				:(Outlet.h = Inlet.h),
				:(Outlet.F = Inlet.F),
				:(Outlet.z = Inlet.z),
				:(Qv = fc*cv*sqrt(Pdrop/Gf)),
				:(Qv = 0 * "m^3/h"),
				:(Gf = rho/rho60F),
				:(rho = PP.LiquidDensity(Inlet.T,Inlet.P,Inlet.z)),
				:(Qv = Inlet.F*vm),
				:(vm = PP.LiquidVolume(Inlet.T,Inlet.P,Inlet.z)),
				:(fc = x),
				:(fc = x^2),
				:(fc = x^2/(2-x^4)^(1/2)),
				:(fc = 10*x/sqrt(1+99*x^2)),
				:(fc = 0.1*x/sqrt(1-0.99*x^2)),
			],
			[
				"Pressure Drop","Pressure Ratio","Enthalpy Balance","Molar Balance","Calculate Outlet Composition","Valve Equation - Flow","Valve Equation - Closed","Calculate Gf","Calculate Specific Mass","Calculate Mass Flow","Calculate Liquid Molar Volume","Opening Equation","Opening Equation","Opening Equation","Opening Equation","Opening Equation",
			],
			[:valve_type,:PP,:NComp,:rho60F,],
			[:Pratio,:Pdrop,:Qv,:fc,:cv,:Gf,:rho,:vm,:x,:Inlet,:Outlet,]
		)
	end
	valve_type::DanaSwitcher 
	PP::DanaPlugin 
	NComp::DanaInteger 
	rho60F::dens_mass
	Pratio::positive 
	Pdrop::press_delta 
	Qv::flow_vol 
	fc::positive 
	cv::positive 
	Gf::positive 
	rho::dens_mass
	vm::vol_mol 
	x::fraction 
	Inlet::stream 
	Outlet::streamPH 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export valve
function set(in::valve)
	rho60F = 999.02 * "kg/m^3"
	 
end
function setEquationFlow(in::valve)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	if Pdrop > 0 
		addEquation(6)
	else
		addEquation(7)
	end
	addEquation(8)
	addEquation(9)
	addEquation(10)
	addEquation(11)
	let switch=valve_type
		if switch=="linear"
			addEquation(12)
		elseif switch=="parabolic"
			addEquation(13)
		elseif switch=="equal"
			addEquation(14)
		elseif switch=="quick"
			addEquation(15)
		elseif switch=="hyperbolic"
			addEquation(16)
		end
	end
end
function atributes(in::valve,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Valve"
	fields[:Brief]="Model of a valve."
	fields[:Info]="== Model of valves ==
* Linear;
* Parabolic;
* Equal;
* Quick;
* Hyperbolic.
	
== Assumptions ==
* Steady State;
* Liquid;
* Isentalpic.
	
== Specify ==
* the valve type;
* the inlet stream;
* the Volumetric Flow (Qv);
* the Valve Coefficient (cv);
* the opening (x).
"
	drive!(fields,_)
	return fields
end
valve(_::Dict{Symbol,Any})=begin
	newModel=valve()
	newModel.attributes=atributes(newModel,_)
	newModel
end
