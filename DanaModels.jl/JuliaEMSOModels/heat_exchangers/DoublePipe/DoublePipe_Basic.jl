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
#*--------------------------------------------------------------------
#* Author: Gerson Balbueno Bicca 
#* $Id$
#*------------------------------------------------------------------
type DoublePipe_Basic
	DoublePipe_Basic()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin ((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of Components",
				:Hidden=>true
			]),
			fill(molweight ((Symbol=>Any)[
				:Brief=>"Component Mol Weight",
				:Hidden=>true
			]),(NComp)),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Flag for Fluid Alocation ",
				:Valid=>["outer","inner"],
				:Default=>"outer",
				:Hidden=>true
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Inner Flow Regime ",
				:Valid=>["laminar","transition","turbulent"],
				:Default=>"laminar",
				:Hidden=>true
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Outer Flow Regime ",
				:Valid=>["laminar","transition","turbulent"],
				:Default=>"laminar",
				:Hidden=>true
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Heat Transfer Correlation in Laminar Flow for the Inner Side",
				:Valid=>["Hausen","Schlunder"],
				:Default=>"Hausen"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Heat Transfer Correlation in Transition Flow for the Inner Side",
				:Valid=>["Gnielinski","Hausen"],
				:Default=>"Gnielinski"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Heat Transfer Correlation in Turbulent Flow for the Inner Side",
				:Valid=>["Petukhov","SiederTate"],
				:Default=>"Petukhov"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Heat Transfer Correlation in Laminar Flow for the Outer Side",
				:Valid=>["Hausen","Schlunder"],
				:Default=>"Hausen"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Heat Transfer Correlation in Transition Flow for the OuterSide",
				:Valid=>["Gnielinski","Hausen"],
				:Default=>"Gnielinski"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Heat Transfer Correlation in Turbulent Flow for the Outer Side",
				:Valid=>["Petukhov","SiederTate"],
				:Default=>"Petukhov"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Options for convergence Calculations ",
				:Valid=>["Simplified","Full"],
				:Default=>"Full"
			]),
			power ((Symbol=>Any)[
				:Brief=>"Estimated Duty",
				:Default=>70,
				:Lower=>1e-6,
				:Upper=>1e10
			]),
			DoublePipe_Geometry ((Symbol=>Any)[
				:Brief=>"Double pipe geometry",
				:Symbol=>" "
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet Inner Stream",
				:PosX=>0,
				:PosY=>0.5225,
				:Symbol=>"_{inInner}"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet Outer Stream",
				:PosX=>0.2805,
				:PosY=>0,
				:Symbol=>"_{inOuter}"
			]),
			streamPH ((Symbol=>Any)[
				:Brief=>"Outlet Inner Stream",
				:PosX=>1,
				:PosY=>0.5225,
				:Symbol=>"_{outInner}"
			]),
			streamPH ((Symbol=>Any)[
				:Brief=>"Outlet Outer Stream",
				:PosX=>0.7264,
				:PosY=>1,
				:Symbol=>"_{outOuter}"
			]),
			Details_Main ((Symbol=>Any)[
				:Brief=>"Some Details in the Heat Exchanger",
				:Symbol=>" "
			]),
			Main_DoublePipe ((Symbol=>Any)[
				:Brief=>"Inner Side of the Heat Exchanger",
				:Symbol=>"_{Inner}"
			]),
			Main_DoublePipe ((Symbol=>Any)[
				:Brief=>"Outer Side of the Heat Exchanger",
				:Symbol=>"_{Outer}"
			]),
			[
				:(Outer.Properties.Average.T = 0.5*InletOuter.T + 0.5*OutletOuter.T),
				:(Inner.Properties.Average.T = 0.5*InletInner.T + 0.5*OutletInner.T),
				:(Outer.Properties.Average.P = 0.5*InletOuter.P+0.5*OutletOuter.P),
				:(Inner.Properties.Average.P = 0.5*InletInner.P+0.5*OutletInner.P),
				:(Inner.Properties.Wall.Twall = 0.5*Outer.Properties.Average.T + 0.5*Inner.Properties.Average.T),
				:(Outer.Properties.Wall.Twall = 0.5*Outer.Properties.Average.T + 0.5*Inner.Properties.Average.T),
				:(Outer.Properties.Average.Mw = sum(M*InletOuter.z)),
				:(Inner.Properties.Average.Mw = sum(M*InletInner.z)),
				:(Inner.Properties.Inlet.Fw = sum(M*InletInner.z)*InletInner.F),
				:(Inner.Properties.Outlet.Fw = sum(M*OutletInner.z)*OutletInner.F),
				:(Outer.Properties.Inlet.Fw = sum(M*InletOuter.z)*InletOuter.F),
				:(Outer.Properties.Outlet.Fw = sum(M*OutletOuter.z)*OutletOuter.F),
				:(OutletOuter.F = InletOuter.F),
				:(OutletInner.F = InletInner.F),
				:(OutletOuter.z=InletOuter.z),
				:(OutletInner.z=InletInner.z),
				:(Details.A=Geometry.Pi*Geometry.DoInner*Geometry.Lpipe),
				:(Inner.Properties.Average.Cp = PP.LiquidCp(Inner.Properties.Average.T,Inner.Properties.Average.P,InletInner.z)),
				:(Inner.Properties.Average.rho = PP.LiquidDensity(Inner.Properties.Average.T,Inner.Properties.Average.P,InletInner.z)),
				:(Inner.Properties.Inlet.rho = PP.LiquidDensity(InletInner.T,InletInner.P,InletInner.z)),
				:(Inner.Properties.Outlet.rho = PP.LiquidDensity(OutletInner.T,OutletInner.P,OutletInner.z)),
				:(Inner.Properties.Average.Mu = PP.LiquidViscosity(Inner.Properties.Average.T,Inner.Properties.Average.P,InletInner.z)),
				:(Inner.Properties.Average.K = PP.LiquidThermalConductivity(Inner.Properties.Average.T,Inner.Properties.Average.P,InletInner.z)),
				:(Inner.Properties.Wall.Mu = PP.LiquidViscosity(Inner.Properties.Wall.Twall,Inner.Properties.Average.P,InletInner.z)),
				:(Inner.Properties.Average.Cp = PP.VapourCp(Inner.Properties.Average.T,Inner.Properties.Average.P,InletInner.z)),
				:(Inner.Properties.Average.rho = PP.VapourDensity(Inner.Properties.Average.T,Inner.Properties.Average.P,InletInner.z)),
				:(Inner.Properties.Inlet.rho = PP.VapourDensity(InletInner.T,InletInner.P,InletInner.z)),
				:(Inner.Properties.Outlet.rho = PP.VapourDensity(OutletInner.T,OutletInner.P,OutletInner.z)),
				:(Inner.Properties.Average.Mu = PP.VapourViscosity(Inner.Properties.Average.T,Inner.Properties.Average.P,InletInner.z)),
				:(Inner.Properties.Average.K = PP.VapourThermalConductivity(Inner.Properties.Average.T,Inner.Properties.Average.P,InletInner.z)),
				:(Inner.Properties.Wall.Mu = PP.VapourViscosity(Inner.Properties.Wall.Twall,Inner.Properties.Average.P,InletInner.z)),
				:(Outer.Properties.Average.Cp = PP.LiquidCp(Outer.Properties.Average.T,Outer.Properties.Average.P,InletOuter.z)),
				:(Outer.Properties.Average.rho = PP.LiquidDensity(Outer.Properties.Average.T,Outer.Properties.Average.P,InletOuter.z)),
				:(Outer.Properties.Inlet.rho = PP.LiquidDensity(InletOuter.T,InletOuter.P,InletOuter.z)),
				:(Outer.Properties.Outlet.rho = PP.LiquidDensity(OutletOuter.T,OutletOuter.P,OutletOuter.z)),
				:(Outer.Properties.Average.Mu = PP.LiquidViscosity(Outer.Properties.Average.T,Outer.Properties.Average.P,InletOuter.z)),
				:(Outer.Properties.Average.K = PP.LiquidThermalConductivity(Outer.Properties.Average.T,Outer.Properties.Average.P,InletOuter.z)),
				:(Outer.Properties.Wall.Mu = PP.LiquidViscosity(Outer.Properties.Wall.Twall,Outer.Properties.Average.P,InletOuter.z)),
				:(Outer.Properties.Average.Cp = PP.VapourCp(Outer.Properties.Average.T,Outer.Properties.Average.P,InletOuter.z)),
				:(Outer.Properties.Average.rho = PP.VapourDensity(Outer.Properties.Average.T,Outer.Properties.Average.P,InletOuter.z)),
				:(Outer.Properties.Inlet.rho = PP.VapourDensity(InletOuter.T,InletOuter.P,InletOuter.z)),
				:(Outer.Properties.Outlet.rho = PP.VapourDensity(OutletOuter.T,OutletOuter.P,OutletOuter.z)),
				:(Outer.Properties.Average.Mu = PP.VapourViscosity(Outer.Properties.Average.T,Outer.Properties.Average.P,InletOuter.z)),
				:(Outer.Properties.Average.K = PP.VapourThermalConductivity(Outer.Properties.Average.T,Outer.Properties.Average.P,InletOuter.z)),
				:(Outer.Properties.Wall.Mu = PP.VapourViscosity(Outer.Properties.Wall.Twall,Outer.Properties.Average.P,InletOuter.z)),
				:(Details.Q = InletOuter.F*(InletOuter.h-OutletOuter.h)),
				:(Details.Q = InletInner.F*(OutletInner.h-InletInner.h)),
				:(Details.Q = InletInner.F*(InletInner.h-OutletInner.h)),
				:(Details.Q = InletOuter.F*(OutletOuter.h - InletOuter.h)),
				:(Inner.PressureDrop.fi*Inner.PressureDrop.Re = 16),
				:((Inner.PressureDrop.fi-0.0035)*(Inner.PressureDrop.Re^0.42) = 0.264),
				:((Inner.PressureDrop.fi-0.0035)*(Inner.PressureDrop.Re^0.42) = 0.264),
				:(Outer.PressureDrop.fi*Outer.PressureDrop.Re = 16),
				:((Outer.PressureDrop.fi-0.0035)*(Outer.PressureDrop.Re^0.42) = 0.264),
				:((Outer.PressureDrop.fi-0.0035)*(Outer.PressureDrop.Re^0.42) = 0.264),
				:(Inner.HeatTransfer.fi = 1/(0.79*ln(Inner.HeatTransfer.Re)-1.64)^2),
				:(Inner.HeatTransfer.Nu = 3.665 + ((0.19*((Geometry.DiInner/Geometry.Lpipe)*Inner.HeatTransfer.Re*Inner.HeatTransfer.PR)^0.8)/(1+0.117*((Geometry.DiInner/Geometry.Lpipe)*Inner.HeatTransfer.Re*Inner.HeatTransfer.PR)^0.467))),
				:(Inner.HeatTransfer.Nu = (49.027896+4.173281*Inner.HeatTransfer.Re*Inner.HeatTransfer.PR*(Geometry.DiInner/Geometry.Lpipe))^(1/3)),
				:(Inner.HeatTransfer.fi = 1/(0.79*ln(Inner.HeatTransfer.Re)-1.64)^2),
				:(Inner.HeatTransfer.Nu*(1+(12.7*sqrt(0.125*Inner.HeatTransfer.fi)*((Inner.HeatTransfer.PR)^(2/3) -1))) = 0.125*Inner.HeatTransfer.fi*(Inner.HeatTransfer.Re-1000)*Inner.HeatTransfer.PR),
				:(Inner.HeatTransfer.Nu =0.116*(Inner.HeatTransfer.Re^(0.667)-125)*Inner.HeatTransfer.PR^(0.333)*(1+(Geometry.DiInner/Geometry.Lpipe)^0.667)),
				:(Inner.HeatTransfer.fi = 1/(1.82*log(Inner.HeatTransfer.Re)-1.64)^2),
				:(Inner.HeatTransfer.Nu*(1.07+(12.7*sqrt(0.125*Inner.HeatTransfer.fi)*((Inner.HeatTransfer.PR)^(2/3) -1))) = 0.125*Inner.HeatTransfer.fi*Inner.HeatTransfer.Re*Inner.HeatTransfer.PR),
				:(Inner.HeatTransfer.Nu = 0.027*(Inner.HeatTransfer.PR)^(1/3)*(Inner.HeatTransfer.Re)^(4/5)),
				:(Inner.HeatTransfer.fi = 1/(1.82*log(Inner.HeatTransfer.Re)-1.64)^2),
				:(Outer.HeatTransfer.fi = 1/(0.79*ln(Outer.HeatTransfer.Re)-1.64)^2),
				:(Outer.HeatTransfer.Nu = 3.665 + ((0.19*((Outer.HeatTransfer.Dh/Geometry.Lpipe)*Outer.HeatTransfer.Re*Outer.HeatTransfer.PR)^0.8)/(1+0.117*((Outer.HeatTransfer.Dh/Geometry.Lpipe)*Outer.HeatTransfer.Re*Outer.HeatTransfer.PR)^0.467))),
				:(Outer.HeatTransfer.Nu = (49.027896+4.173281*Outer.HeatTransfer.Re*Outer.HeatTransfer.PR*(Outer.HeatTransfer.Dh/Geometry.Lpipe))^(1/3)),
				:(Outer.HeatTransfer.fi = 1/(0.79*ln(Outer.HeatTransfer.Re)-1.64)^2),
				:(Outer.HeatTransfer.Nu*(1+(12.7*sqrt(0.125*Outer.HeatTransfer.fi)*((Outer.HeatTransfer.PR)^(2/3) -1))) = 0.125*Outer.HeatTransfer.fi*(Outer.HeatTransfer.Re-1000)*Outer.HeatTransfer.PR),
				:(Outer.HeatTransfer.Nu = 0.116*(Outer.HeatTransfer.Re^(0.667)-125)*Outer.HeatTransfer.PR^(0.333)*(1+(Outer.HeatTransfer.Dh/Geometry.Lpipe)^0.667)),
				:(Outer.HeatTransfer.fi = 1/(0.79*ln(Outer.HeatTransfer.Re)-1.64)^2),
				:(Outer.HeatTransfer.fi = 1/(1.82*log(Outer.HeatTransfer.Re)-1.64)^2),
				:(Outer.HeatTransfer.Nu*(1.07+(12.7*sqrt(0.125*Outer.HeatTransfer.fi)*((Outer.HeatTransfer.PR)^(2/3) -1))) = 0.125*Outer.HeatTransfer.fi*Outer.HeatTransfer.Re*Outer.HeatTransfer.PR),
				:(Outer.HeatTransfer.Nu = 0.027*(Outer.HeatTransfer.PR)^(1/3)*(Outer.HeatTransfer.Re)^(4/5)),
				:(Outer.HeatTransfer.fi = 1/(1.82*log(Outer.HeatTransfer.Re)-1.64)^2),
				:(Outer.PressureDrop.Pdrop = Outer.PressureDrop.Pd_fric),
				:(Inner.PressureDrop.Pdrop = Inner.PressureDrop.Pd_fric),
				:(OutletOuter.P = InletOuter.P - Outer.PressureDrop.Pdrop),
				:(OutletInner.P = InletInner.P - Inner.PressureDrop.Pdrop),
				:(Outer.PressureDrop.Pd_fric = (2*Outer.PressureDrop.fi*Geometry.Lpipe*Outer.Properties.Average.rho*Outer.HeatTransfer.Vmean^2)/(Outer.PressureDrop.Dh*Outer.HeatTransfer.Phi)),
				:(Inner.PressureDrop.Pd_fric = (2*Inner.PressureDrop.fi*Geometry.Lpipe*Inner.Properties.Average.rho*Inner.HeatTransfer.Vmean^2)/(Geometry.DiInner*Inner.HeatTransfer.Phi)),
				:(Outer.PressureDrop.Pdrop = Outer.PressureDrop.Pd_fric),
				:(Inner.PressureDrop.Pdrop = Inner.PressureDrop.Pd_fric),
				:(OutletOuter.P = InletOuter.P - Outer.PressureDrop.Pdrop),
				:(OutletInner.P = InletInner.P - Inner.PressureDrop.Pdrop),
				:(Outer.PressureDrop.Pd_fric = 0.01*InletOuter.P),
				:(Inner.PressureDrop.Pd_fric = 0.01*InletInner.P),
				:(Inner.HeatTransfer.hcoeff = (Inner.HeatTransfer.Nu*Inner.Properties.Average.K/Geometry.DiInner)*Inner.HeatTransfer.Phi),
				:(Outer.HeatTransfer.hcoeff= (Outer.HeatTransfer.Nu*Outer.Properties.Average.K/Outer.HeatTransfer.Dh)*Outer.HeatTransfer.Phi),
				:(Outer.PressureDrop.Pd_ret = 0*"kPa"),
				:(Inner.PressureDrop.Pd_ret = 0*"kPa"),
				:(Outer.HeatTransfer.Phi = (Outer.Properties.Average.Mu/Outer.Properties.Wall.Mu)^0.14),
				:(Inner.HeatTransfer.Phi = (Inner.Properties.Average.Mu/Inner.Properties.Wall.Mu)^0.14),
				:(Outer.HeatTransfer.PR = ((Outer.Properties.Average.Cp/Outer.Properties.Average.Mw)*Outer.Properties.Average.Mu)/Outer.Properties.Average.K),
				:(Inner.HeatTransfer.PR = ((Inner.Properties.Average.Cp/Inner.Properties.Average.Mw)*Inner.Properties.Average.Mu)/Inner.Properties.Average.K),
				:(Outer.HeatTransfer.Re = (Outer.Properties.Average.rho*Outer.HeatTransfer.Vmean*Outer.HeatTransfer.Dh)/Outer.Properties.Average.Mu),
				:(Outer.PressureDrop.Re = (Outer.Properties.Average.rho*Outer.HeatTransfer.Vmean*Outer.PressureDrop.Dh)/Outer.Properties.Average.Mu),
				:(Inner.HeatTransfer.Re = (Inner.Properties.Average.rho*Inner.HeatTransfer.Vmean*Inner.HeatTransfer.Dh)/Inner.Properties.Average.Mu),
				:(Inner.PressureDrop.Re = Inner.HeatTransfer.Re),
				:(Outer.HeatTransfer.Vmean*(Outer.HeatTransfer.As*Outer.Properties.Average.rho) = Outer.Properties.Inlet.Fw),
				:(Inner.HeatTransfer.Vmean*(Inner.HeatTransfer.As*Inner.Properties.Average.rho) = Inner.Properties.Inlet.Fw),
				:(Details.Uc*((Geometry.DoInner/(Inner.HeatTransfer.hcoeff*Geometry.DiInner) )+(Geometry.DoInner*ln(Geometry.DoInner/Geometry.DiInner)/(2*Geometry.Kwall))+(1/(Outer.HeatTransfer.hcoeff)))=1),
				:(Details.Ud*(Geometry.Rfi*(Geometry.DoInner/Geometry.DiInner) + Geometry.Rfo + (Geometry.DoInner/(Inner.HeatTransfer.hcoeff*Geometry.DiInner) )+(Geometry.DoInner*ln(Geometry.DoInner/Geometry.DiInner)/(2*Geometry.Kwall))+(1/(Outer.HeatTransfer.hcoeff)))=1),
			],
			[
				"Outer	Stream Average Temperature","Inner Stream Average Temperature","Outer Stream Average Pressure","Inner Stream Average Pressure","Inner Stream Wall Temperature","Outer Stream Wall Temperature","Outer Stream Average Molecular Weight","Inner Stream Average Molecular Weight","Flow Mass Inlet Inner Stream","Flow Mass Outlet Inner Stream","Flow Mass Inlet Outer Stream","Flow Mass Outlet Outer Stream","Molar Balance Outer Stream","Molar Balance Inner Stream","Outer Stream Molar Fraction Constraint","Inner Stream Molar Fraction Constraint","Exchange Surface Area for one segment of pipe","Average Heat Capacity Inner Stream","Average Mass Density Inner Stream","Inlet Mass Density Inner Stream","Outlet Mass Density Inner Stream","Average Viscosity Inner Stream","Average	Conductivity Inner Stream","Viscosity Inner Stream at wall temperature","Average Heat Capacity InnerStream","Average Mass Density Inner Stream","Inlet Mass Density Inner Stream","Outlet Mass Density Inner Stream","Average Viscosity Inner Stream","Average Conductivity Inner Stream","Viscosity Inner Stream at wall temperature","Average Heat Capacity Outer Stream","Average Mass Density Outer Stream","Inlet Mass Density Outer Stream","Outlet Mass Density Outer Stream","Average Viscosity Outer Stream","Average Conductivity Outer Stream","Viscosity Outer Stream at wall temperature","Average Heat Capacity Outer Stream","Average Mass Density Outer Stream","Inlet Mass Density Outer Stream","Outlet Mass Density Outer Stream","Average Viscosity Outer Stream","Average Conductivity Outer Stream","Viscosity Outer Stream at wall temperature","Energy Balance Outer Stream","Energy Balance Inner Stream","Energy Balance Hot Stream","Energy Balance Cold Stream","Inner Side Friction Factor for Pressure Drop - laminar Flow","using Turbulent Flow","Inner Side Friction Factor","Outer Side Friction Factor - laminar Flow","using Turbulent Flow","Outer Side Friction Factor","Inner Side Friction Factor for Heat Transfer - laminar Flow","Nusselt Number","Nusselt Number","Inner Side Friction Factor for Heat Transfer - transition Flow","Nusselt Number","Nusselt Number","Inner Side Friction Factor for Heat Transfer - turbulent Flow","Nusselt Number","Nusselt Number","Inner Side Friction Factor for Heat Transfer - turbulent Flow","Outer Side Friction Factor for Heat Transfer - laminar Flow","Nusselt Number","Nusselt Number","Outer Side Friction Factor for Heat Transfer - transition Flow","Nusselt Number","Nusselt Number","Outer Side Friction Factor for Heat Transfer - transition Flow","Outer Side Friction Factor for Heat Transfer - turbulent Flow","Nusselt Number","Nusselt Number","Outer Side Friction Factor for Heat Transfer - turbulent Flow","Total Pressure Drop Outer Stream","Total Pressure Drop Inner Stream","Pressure Drop Outer Stream","Pressure Drop Inner Stream","Outer Pipe Pressure Drop for friction","Inner Pipe Pressure Drop for friction","Total Pressure Drop Outer Stream","Total Pressure Drop Inner Stream","Pressure Drop Outer Stream","Pressure Drop Inner Stream","Outer Pipe Pressure Drop for friction","Inner Pipe Pressure Drop for friction","Inner Pipe Film Coefficient","Outer Pipe Film Coefficient","Outer Pipe Pressure Drop due to return","Inner Pipe Pressure Drop due to return","Outer Pipe Phi correction","Inner Pipe Phi correction","Outer Pipe Prandtl Number","Inner Pipe Prandtl Number","Outer Pipe Reynolds Number for Heat Transfer","Outer Pipe Reynolds Number for Pressure Drop","Inner Pipe Reynolds Number for Heat Transfer","Inner Pipe Reynolds Number for Pressure Drop","Outer Pipe Velocity","Inner Pipe Velocity","Overall Heat Transfer Coefficient Clean","Overall Heat Transfer Coefficient Dirty",
			],
			[:PP,:NComp,:M,:HotSide,:innerFlowRegime,:outerFlowRegime,:InnerLaminarCorrelation,:InnerTransitionCorrelation,:InnerTurbulentCorrelation,:OuterLaminarCorrelation,:OuterTransitionCorrelation,:OuterTurbulentCorrelation,:CalculationApproach,:Qestimated,],
			[:Geometry,:InletInner,:InletOuter,:OutletInner,:OutletOuter,:Details,:Inner,:Outer,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	M::Array{molweight }
	HotSide::DanaSwitcher 
	innerFlowRegime::DanaSwitcher 
	outerFlowRegime::DanaSwitcher 
	InnerLaminarCorrelation::DanaSwitcher 
	InnerTransitionCorrelation::DanaSwitcher 
	InnerTurbulentCorrelation::DanaSwitcher 
	OuterLaminarCorrelation::DanaSwitcher 
	OuterTransitionCorrelation::DanaSwitcher 
	OuterTurbulentCorrelation::DanaSwitcher 
	CalculationApproach::DanaSwitcher 
	Qestimated::power 
	Geometry::DoublePipe_Geometry 
	InletInner::stream 
	InletOuter::stream 
	OutletInner::streamPH 
	OutletOuter::streamPH 
	Details::Details_Main 
	Inner::Main_DoublePipe 
	Outer::Main_DoublePipe 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export DoublePipe_Basic
function set(in::DoublePipe_Basic)
	#"Inner Pipe Cross Sectional Area for Flow"
	Inner.HeatTransfer.As = 0.25*Geometry.Pi*Geometry.DiInner*Geometry.DiInner
	 #"Outer Pipe Cross Sectional Area for Flow"
	Outer.HeatTransfer.As = 0.25*Geometry.Pi*(Geometry.DiOuter*Geometry.DiOuter - Geometry.DoInner*Geometry.DoInner)
	 #"Inner Pipe Hydraulic Diameter for Heat Transfer"
	Inner.HeatTransfer.Dh = Geometry.DiInner
	 #"Outer Pipe Hydraulic Diameter for Heat Transfer"
	Outer.HeatTransfer.Dh = (Geometry.DiOuter*Geometry.DiOuter-Geometry.DoInner*Geometry.DoInner)/Geometry.DoInner
	 #"Inner Pipe Hydraulic Diameter for Pressure Drop"
	Inner.PressureDrop.Dh = Geometry.DiInner
	 #"Outer Pipe Hydraulic Diameter for Pressure Drop"
	Outer.PressureDrop.Dh=Geometry.DiOuter-Geometry.DoInner
	 
end
function setEquationFlow(in::DoublePipe_Basic)
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
	if InletInner.v == 0 
		addEquation(18)
		addEquation(19)
		addEquation(20)
		addEquation(21)
		addEquation(22)
		addEquation(23)
		addEquation(24)
	else
		addEquation(25)
		addEquation(26)
		addEquation(27)
		addEquation(28)
		addEquation(29)
		addEquation(30)
		addEquation(31)
	end
	if InletOuter.v == 0 
		addEquation(32)
		addEquation(33)
		addEquation(34)
		addEquation(35)
		addEquation(36)
		addEquation(37)
		addEquation(38)
	else
		addEquation(39)
		addEquation(40)
		addEquation(41)
		addEquation(42)
		addEquation(43)
		addEquation(44)
		addEquation(45)
	end
	let switch=HotSide
		if HotSide==InletInner.T > InletOuter.T
			set(switch,"inner")
		end
		if HotSide==InletInner.T < InletOuter.T
			set(switch,"outer")
		end
		if switch=="outer"
			addEquation(46)
			addEquation(47)
		elseif switch=="inner"
			addEquation(48)
			addEquation(49)
		end
	end
	let switch=innerFlowRegime
		if innerFlowRegime==Inner.PressureDrop.Re > 2300
			set(switch,"transition")
		end
		if innerFlowRegime==Inner.PressureDrop.Re < 2300
			set(switch,"laminar")
		end
		if innerFlowRegime==Inner.PressureDrop.Re > 10000
			set(switch,"turbulent")
		end
		if innerFlowRegime==Inner.PressureDrop.Re < 10000
			set(switch,"transition")
		end
		if switch=="laminar"
			addEquation(50)
		elseif switch=="transition"
			addEquation(51)
		elseif switch=="turbulent"
			addEquation(52)
		end
	end
	let switch=outerFlowRegime
		if outerFlowRegime==Outer.PressureDrop.Re > 2300
			set(switch,"transition")
		end
		if outerFlowRegime==Outer.PressureDrop.Re < 2300
			set(switch,"laminar")
		end
		if outerFlowRegime==Outer.PressureDrop.Re > 10000
			set(switch,"turbulent")
		end
		if outerFlowRegime==Outer.PressureDrop.Re < 10000
			set(switch,"transition")
		end
		if switch=="laminar"
			addEquation(53)
		elseif switch=="transition"
			addEquation(54)
		elseif switch=="turbulent"
			addEquation(55)
		end
	end
	let switch=innerFlowRegime
		if innerFlowRegime==Inner.HeatTransfer.Re > 2300
			set(switch,"transition")
		end
		if innerFlowRegime==Inner.HeatTransfer.Re < 2300
			set(switch,"laminar")
		end
		if innerFlowRegime==Inner.HeatTransfer.Re > 10000
			set(switch,"turbulent")
		end
		if innerFlowRegime==Inner.HeatTransfer.Re < 10000
			set(switch,"transition")
		end
		if switch=="laminar"
			addEquation(56)
			let switch=InnerLaminarCorrelation
				if switch=="Hausen"
					addEquation(57)
				elseif switch=="Schlunder"
					addEquation(58)
				end
			end
		elseif switch=="transition"
			addEquation(59)
			let switch=InnerTransitionCorrelation
				if switch=="Gnielinski"
					addEquation(60)
				elseif switch=="Hausen"
					addEquation(61)
				end
			end
		elseif switch=="turbulent"
			let switch=InnerTurbulentCorrelation
				if switch=="Petukhov"
					addEquation(62)
					addEquation(63)
				elseif switch=="SiederTate"
					addEquation(64)
					addEquation(65)
				end
			end
		end
	end
	let switch=outerFlowRegime
		if outerFlowRegime==Outer.HeatTransfer.Re > 2300
			set(switch,"transition")
		end
		if outerFlowRegime==Outer.HeatTransfer.Re < 2300
			set(switch,"laminar")
		end
		if outerFlowRegime==Outer.HeatTransfer.Re > 10000
			set(switch,"turbulent")
		end
		if outerFlowRegime==Outer.HeatTransfer.Re < 10000
			set(switch,"transition")
		end
		if switch=="laminar"
			addEquation(66)
			let switch=OuterLaminarCorrelation
				if switch=="Hausen"
					addEquation(67)
				elseif switch=="Schlunder"
					addEquation(68)
				end
			end
		elseif switch=="transition"
			let switch=OuterTransitionCorrelation
				if switch=="Gnielinski"
					addEquation(69)
					addEquation(70)
				elseif switch=="Hausen"
					addEquation(71)
					addEquation(72)
				end
			end
		elseif switch=="turbulent"
			let switch=OuterTurbulentCorrelation
				if switch=="Petukhov"
					addEquation(73)
					addEquation(74)
				elseif switch=="SiederTate"
					addEquation(75)
					addEquation(76)
				end
			end
		end
	end
	let switch=CalculationApproach
		if switch=="Full"
			addEquation(77)
			addEquation(78)
			addEquation(79)
			addEquation(80)
			addEquation(81)
			addEquation(82)
		elseif switch=="Simplified"
			addEquation(83)
			addEquation(84)
			addEquation(85)
			addEquation(86)
			addEquation(87)
			addEquation(88)
		end
	end
	addEquation(89)
	addEquation(90)
	addEquation(91)
	addEquation(92)
	addEquation(93)
	addEquation(94)
	addEquation(95)
	addEquation(96)
	addEquation(97)
	addEquation(98)
	addEquation(99)
	addEquation(100)
	addEquation(101)
	addEquation(102)
	addEquation(103)
	addEquation(104)
end
function atributes(in::DoublePipe_Basic,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Basic Equations for rigorous double pipe heat exchanger model."
	fields[:Info]="Thermal analysis of double pipe heat exchanger using the NTU or LMTD Method.

== References ==

[1] E.A.D. Saunders, Heat Exchangers: Selection, Design and
 Construction, Longman, Harlow, 1988.

[2] Serth, Robert W., Process Heat Transfer: Principles and Applications, Elsevier, 2007. 

[3] Gnielinski, V., Forced convection in ducts, in Heat Exchanger Design Handbook, Vol. 2
 Hemisphere Publishing Corp., New York, 1988."
	drive!(fields,_)
	return fields
end
DoublePipe_Basic(_::Dict{Symbol,Any})=begin
	newModel=DoublePipe_Basic()
	newModel.attributes=atributes(newModel,_)
	newModel
end
