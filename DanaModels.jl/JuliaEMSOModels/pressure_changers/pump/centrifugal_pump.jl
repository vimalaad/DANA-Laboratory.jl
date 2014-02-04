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
#* Author: Andrey Copat, Estefane S. Horn, Marcos L. Alencastro
#* $Id$
#*--------------------------------------------------------------------
type centrifugal_pump
	centrifugal_pump()=begin
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
				:Brief=>"Molar Weight"
			]),(NComp)),
			positive ((Symbol=>Any)[
				:Brief=>"Pump Efficiency",
				:Default=>0.75,
				:Lower=>1E-3
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Mechanical efficiency",
				:Default=>0.95,
				:Lower=>1E-3
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"NPSH Options",
				:Valid=>["Default","Include Kinetic Head"],
				:Default=>"Default"
			]),
			acceleration ((Symbol=>Any)[
				:Brief=>"Gravity Acceleration",
				:Default=>9.81,
				:Hidden=>true
			]),
			area ((Symbol=>Any)[
				:Brief=>"Inlet Nozzle Suction Area",
				:Default=>0.001
			]),
			flow_vol ((Symbol=>Any)[
				:Brief=>"Volumetric Flow Rate" ,
				:Protected=>true
			]),
			flow_mass ((Symbol=>Any)[
				:Brief=>"Inlet Mass Flow Rate" ,
				:Protected=>true
			]),
			flow_mass ((Symbol=>Any)[
				:Brief=>"Outlet Mass Flow Rate",
				:Protected=>true
			]),
			dens_mass ((Symbol=>Any)[
				:Brief=>"Mass Density at inlet conditions",
				:Lower=>1E-6,
				:Protected=>true
			]),
			dens_mass ((Symbol=>Any)[
				:Brief=>"Mass Density at outlet conditions",
				:Lower=>1E-6,
				:Protected=>true
			]),
			molweight ((Symbol=>Any)[
				:Brief=>"Mixture Molar Weight" ,
				:Protected=>true
			]),
			pressure ((Symbol=>Any)[
				:Brief=>"Mixture Vapour Pressure" ,
				:Protected=>true
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
				:Brief=>"Pressure Ratio",
				:Symbol=>"P_{ratio}"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Pressure Drop",
				:DisplayUnit=>"kPa",
				:Symbol=>"\\Delta P"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Pressure Increase",
				:Lower=>0,
				:DisplayUnit=>"kPa",
				:Symbol=>"P_{incr}"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Static Head"
			]),
			energy_mass ((Symbol=>Any)[
				:Brief=>"Actual Head",
				:Protected=>true
			]),
			energy_mass ((Symbol=>Any)[
				:Brief=>"Isentropic Head",
				:Protected=>true
			]),
			length ((Symbol=>Any)[
				:Brief=>"Available Net Positive Suction Head" ,
				:Protected=>true
			]),
			length ((Symbol=>Any)[
				:Brief=>"Velocity Head",
				:Protected=>true
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"Velocity Inlet Nozzle",
				:Hidden=>true
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet stream",
				:PosX=>0,
				:PosY=>0.4025,
				:Symbol=>"_{in}"
			]),
			streamPH ((Symbol=>Any)[
				:Brief=>"Outlet stream",
				:PosX=>1,
				:PosY=>0.20,
				:Symbol=>"_{out}"
			]),
			work_stream ((Symbol=>Any)[
				:Brief=>"Work Inlet",
				:PosX=>0.5,
				:PosY=>1,
				:Protected=>true
			]),
			[
				:(Fvol = NozzleVelocity*SuctionArea),
				:(VelocityHead = 0.5*NozzleVelocity^2/g),
				:(Mwm = sum(Mw*Inlet.z)),
				:(rho_in = PP.LiquidDensity(Inlet.T, Inlet.P, Inlet.z)),
				:(rho_out= PP.LiquidDensity(Outlet.T, Outlet.P, Outlet.z)),
				:(Fw_in = Mwm*Inlet.F),
				:(Fw_out = Fw_in),
				:(Outlet.P = Inlet.P + Pincrease),
				:(Pvapor = PP.BubbleP(Inlet.T,Inlet.z)),
				:(Outlet.P = Inlet.P * Pratio),
				:(Outlet.P = Inlet.P - Pdrop),
				:(HeadIsentropic = -Pdrop/rho_in),
				:(Head = HeadIsentropic/PumpEfficiency),
				:(Head*Mwm = (Outlet.h-Inlet.h)),
				:(FluidPower = HeadIsentropic *Mwm* Inlet.F),
				:(BrakePower * PumpEfficiency = FluidPower),
				:(EletricPower = -WorkIn.Work),
				:(BrakePower = EletricPower * MechanicalEff),
				:(Outlet.F = Inlet.F),
				:(Outlet.z = Inlet.z),
				:(Fvol = Fw_in/rho_in),
				:(NPSH_available = (Inlet.P - Pvapor)/(rho_in*g) + StaticHead),
				:(NPSH_available = (Inlet.P - Pvapor)/(rho_in*g)+VelocityHead+StaticHead),
			],
			[
				"Velocity Inlet Nozzle","Velocity Head","Average Molecular Weight","Mass Density at inlet conditions","Mass Density at outlet conditions","Inlet Flow Mass","Outlet Flow Mass","Pressure Increase","Mixture Vapour Pressure","Pressure Ratio","Pressure Drop","Isentropic Head","Pump Efficiency","Actual Head","Fluid Power","Brake Power","Eletric Power","Eletric Power","Molar Balance","Outlet Composition","Volumetric Flow Rate","Net Positive Suction Head Available - Without Velocity Head","Net Positive Suction Head Available - Included Velocity Head",
			],
			[:PP,:NComp,:Mw,:PumpEfficiency,:MechanicalEff,:NPSH_Options,:g,:SuctionArea,],
			[:Fvol,:Fw_in,:Fw_out,:rho_in,:rho_out,:Mwm,:Pvapor,:FluidPower,:BrakePower,:EletricPower,:Pratio,:Pdrop,:Pincrease,:StaticHead,:Head,:HeadIsentropic,:NPSH_available,:VelocityHead,:NozzleVelocity,:Inlet,:Outlet,:WorkIn,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	Mw::Array{molweight }
	PumpEfficiency::positive 
	MechanicalEff::positive 
	NPSH_Options::DanaSwitcher 
	g::acceleration 
	SuctionArea::area 
	Fvol::flow_vol 
	Fw_in::flow_mass 
	Fw_out::flow_mass 
	rho_in::dens_mass 
	rho_out::dens_mass 
	Mwm::molweight 
	Pvapor::pressure 
	FluidPower::power 
	BrakePower::power 
	EletricPower::power 
	Pratio::positive 
	Pdrop::press_delta 
	Pincrease::press_delta 
	StaticHead::length 
	Head::energy_mass 
	HeadIsentropic::energy_mass 
	NPSH_available::length 
	VelocityHead::length 
	NozzleVelocity::velocity 
	Inlet::stream 
	Outlet::streamPH 
	WorkIn::work_stream 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export centrifugal_pump
function set(in::centrifugal_pump)
	Mw = PP.MolecularWeight()
	 g = 9.81*"m/s^2"
	 
end
function setEquationFlow(in::centrifugal_pump)
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
	let switch=NPSH_Options
		if switch=="Default"
			addEquation(22)
		elseif switch=="Include Kinetic Head"
			addEquation(23)
		end
	end
end
function atributes(in::centrifugal_pump,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Pump"
	fields[:Brief]="Model of a centrifugal pump."
	fields[:Info]="== Assumptions ==

* Steady State;

* Only Liquid;

* Adiabatic;

* Isentropic.

"
	drive!(fields,_)
	return fields
end
centrifugal_pump(_::Dict{Symbol,Any})=begin
	newModel=centrifugal_pump()
	newModel.attributes=atributes(newModel,_)
	newModel
end
