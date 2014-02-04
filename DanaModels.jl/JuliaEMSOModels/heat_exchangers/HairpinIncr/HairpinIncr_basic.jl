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
#* $Id: HairpinIncr.mso								$
#*------------------------------------------------------------------
type HairpinIncr_basic
	HairpinIncr_basic()=begin
		PP=outers.PP
		NComp=outers.NComp
		N=outers.N
		Npoints=outers.Npoints
		Pi=outers.Pi
		DoInner=outers.DoInner
		DiInner=outers.DiInner
		DiOuter=outers.DiOuter
		Lpipe=outers.Lpipe
		Kwall=outers.Kwall
		Rfi=outers.Rfi
		Rfo=outers.Rfo
		new(
			DanaPlugin ((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of Components"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of zones",
				:Default=>2
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of incremental points",
				:Default=>3
			]),
			fill(molweight ((Symbol=>Any)[
				:Brief=>"Component Mol Weight"
			]),(NComp)),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Flag for Fluid Alocation ",
				:Valid=>["outer","inner"],
				:Default=>"outer"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Inner Flow Regime ",
				:Valid=>["laminar","transition","turbulent"],
				:Default=>"laminar"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Outer Flow Regime ",
				:Valid=>["laminar","transition","turbulent"],
				:Default=>"laminar"
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
			constant ((Symbol=>Any)[
				:Brief=>"Pi Number",
				:Default=>3.14159265,
				:Symbol=>"\\pi"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Outside Diameter of Inner Pipe",
				:Lower=>1e-6
			]),
			length ((Symbol=>Any)[
				:Brief=>"Inside Diameter of Inner Pipe",
				:Lower=>1e-10
			]),
			length ((Symbol=>Any)[
				:Brief=>"Inside Diameter of Outer pipe",
				:Lower=>1e-10
			]),
			length ((Symbol=>Any)[
				:Brief=>"Effective Tube Length of one segment of Pipe",
				:Lower=>0.1,
				:Symbol=>"L_{pipe}"
			]),
			conductivity ((Symbol=>Any)[
				:Brief=>"Tube Wall Material Thermal Conductivity",
				:Default=>1.0,
				:Symbol=>"K_{wall}"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Inside Fouling Resistance",
				:Unit=>"m^2*K/kW",
				:Default=>1e-6,
				:Lower=>0
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Outside Fouling Resistance",
				:Unit=>"m^2*K/kW",
				:Default=>1e-6,
				:Lower=>0
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
			Main_Hairpin ((Symbol=>Any)[
				:Brief=>"Inner Side of the Heat Exchanger",
				:Symbol=>"_{Inner}"
			]),
			Main_Hairpin ((Symbol=>Any)[
				:Brief=>"Outer Side of the Heat Exchanger",
				:Symbol=>"_{Outer}"
			]),
			fill(length ((Symbol=>Any)[
				:Brief=>"Incremental Tube Length",
				:Symbol=>"L_{incr}"
			]),(Npoints)),
			[
				:(Outer.Properties.Average.T(1:N) = 0.5*Outer.HeatTransfer.Tlocal(1:N) + 0.5*Outer.HeatTransfer.Tlocal(2:Npoints)),
				:(Inner.Properties.Average.T(1:N) = 0.5*Inner.HeatTransfer.Tlocal(1:N) + 0.5*Inner.HeatTransfer.Tlocal(2:Npoints)),
				:(Outer.Properties.Average.P(1:N) = 0.5*Outer.PressureDrop.Plocal(1:N) + 0.5*Outer.PressureDrop.Plocal(2:Npoints)),
				:(Inner.Properties.Average.P(1:N) = 0.5*Inner.PressureDrop.Plocal(1:N) + 0.5*Inner.PressureDrop.Plocal(2:Npoints)),
				:(Inner.Properties.Wall.Twall = 0.5*Outer.Properties.Average.T + 0.5*Inner.Properties.Average.T),
				:(Outer.Properties.Wall.Twall = 0.5*Outer.Properties.Average.T + 0.5*Inner.Properties.Average.T),
				:(Outer.Properties.Average.Mw = sum(M*InletOuter.z)),
				:(Inner.Properties.Average.Mw = sum(M*InletInner.z)),
				:(Inner.Properties.Inlet.rho = PP.LiquidDensity(InletInner.T,InletInner.P,InletInner.z)),
				:(Inner.Properties.Outlet.rho = PP.LiquidDensity(OutletInner.T,OutletInner.P,OutletInner.z)),
				:(Inner.Properties.Inlet.rho = PP.VapourDensity(InletInner.T,InletInner.P,InletInner.z)),
				:(Inner.Properties.Outlet.rho = PP.VapourDensity(OutletInner.T,OutletInner.P,OutletInner.z)),
				:(Outer.Properties.Inlet.rho = PP.LiquidDensity(InletOuter.T,InletOuter.P,InletOuter.z)),
				:(Outer.Properties.Outlet.rho = PP.LiquidDensity(OutletOuter.T,OutletOuter.P,OutletOuter.z)),
				:(Outer.Properties.Inlet.rho = PP.VapourDensity(InletOuter.T,InletOuter.P,InletOuter.z)),
				:(Outer.Properties.Outlet.rho = PP.VapourDensity(OutletOuter.T,OutletOuter.P,OutletOuter.z)),
				:(Inner.Properties.Average.Cp([1:N]) = PP.LiquidCp(Inner.Properties.Average.T([1:N]),Inner.Properties.Average.P([1:N]),InletInner.z)),
				:(Inner.Properties.Average.rho([1:N]) = PP.LiquidDensity(Inner.Properties.Average.T([1:N]),Inner.Properties.Average.P([1:N]),InletInner.z)),
				:(Inner.Properties.Average.Mu([1:N]) = PP.LiquidViscosity(Inner.Properties.Average.T([1:N]),Inner.Properties.Average.P([1:N]),InletInner.z)),
				:(Inner.Properties.Average.K([1:N]) = PP.LiquidThermalConductivity(Inner.Properties.Average.T([1:N]),Inner.Properties.Average.P([1:N]),InletInner.z)),
				:(Inner.Properties.Wall.Mu([1:N]) = PP.LiquidViscosity(Inner.Properties.Wall.Twall([1:N]),Inner.Properties.Average.P([1:N]),InletInner.z)),
				:(Inner.Properties.Average.Cp([1:N]) = PP.VapourCp(Inner.Properties.Average.T([1:N]),Inner.Properties.Average.P([1:N]),InletInner.z)),
				:(Inner.Properties.Average.rho([1:N]) = PP.VapourDensity(Inner.Properties.Average.T([1:N]),Inner.Properties.Average.P([1:N]),InletInner.z)),
				:(Inner.Properties.Average.Mu([1:N]) = PP.VapourViscosity(Inner.Properties.Average.T([1:N]),Inner.Properties.Average.P([1:N]),InletInner.z)),
				:(Inner.Properties.Average.K([1:N]) = PP.VapourThermalConductivity(Inner.Properties.Average.T([1:N]),Inner.Properties.Average.P([1:N]),InletInner.z)),
				:(Inner.Properties.Wall.Mu([1:N]) = PP.VapourViscosity(Inner.Properties.Wall.Twall([1:N]),Inner.Properties.Average.P([1:N]),InletInner.z)),
				:(Outer.Properties.Average.Cp([1:N]) = PP.LiquidCp(Outer.Properties.Average.T([1:N]),Outer.Properties.Average.P([1:N]),InletOuter.z)),
				:(Outer.Properties.Average.rho([1:N]) = PP.LiquidDensity(Outer.Properties.Average.T([1:N]),Outer.Properties.Average.P([1:N]),InletOuter.z)),
				:(Outer.Properties.Average.Mu([1:N]) = PP.LiquidViscosity(Outer.Properties.Average.T([1:N]),Outer.Properties.Average.P([1:N]),InletOuter.z)),
				:(Outer.Properties.Average.K([1:N]) = PP.LiquidThermalConductivity(Outer.Properties.Average.T([1:N]),Outer.Properties.Average.P([1:N]),InletOuter.z)),
				:(Outer.Properties.Wall.Mu([1:N]) = PP.LiquidViscosity(Outer.Properties.Wall.Twall([1:N]),Outer.Properties.Average.P([1:N]),InletOuter.z)),
				:(Outer.Properties.Average.Cp([1:N]) = PP.VapourCp(Outer.Properties.Average.T([1:N]),Outer.Properties.Average.P([1:N]),InletOuter.z)),
				:(Outer.Properties.Average.rho([1:N]) = PP.VapourDensity(Outer.Properties.Average.T([1:N]),Outer.Properties.Average.P([1:N]),InletOuter.z)),
				:(Outer.Properties.Average.Mu([1:N]) = PP.VapourViscosity(Outer.Properties.Average.T([1:N]),Outer.Properties.Average.P([1:N]),InletOuter.z)),
				:(Outer.Properties.Average.K([1:N]) = PP.VapourThermalConductivity(Outer.Properties.Average.T([1:N]),Outer.Properties.Average.P([1:N]),InletOuter.z)),
				:(Outer.Properties.Wall.Mu([1:N]) = PP.VapourViscosity(Outer.Properties.Wall.Twall([1:N]),Outer.Properties.Average.P([1:N]),InletOuter.z)),
				:(Inner.Properties.Inlet.Fw = sum(M*InletInner.z)*InletInner.F),
				:(Inner.Properties.Outlet.Fw = sum(M*OutletInner.z)*OutletInner.F),
				:(Outer.Properties.Inlet.Fw = sum(M*InletOuter.z)*InletOuter.F),
				:(Outer.Properties.Outlet.Fw = sum(M*OutletOuter.z)*OutletOuter.F),
				:(OutletOuter.F = InletOuter.F),
				:(OutletInner.F = InletInner.F),
				:(OutletOuter.z=InletOuter.z),
				:(OutletInner.z=InletInner.z),
				:(Details.A=Pi*DoInner*Lpipe),
				:(Lincr(1) = 0*"m"),
				:(Lincr([1:N]+1) = [1:N]*abs(Lpipe)/N),
				:(Inner.PressureDrop.fi([1:N])*Inner.PressureDrop.Re([1:N]) = 16),
				:((Inner.PressureDrop.fi([1:N])-0.0035)*(Inner.PressureDrop.Re([1:N])^0.42) = 0.264),
				:((Inner.PressureDrop.fi([1:N])-0.0035)*(Inner.PressureDrop.Re([1:N])^0.42) = 0.264),
				:(Outer.PressureDrop.fi([1:N])*Outer.PressureDrop.Re([1:N]) = 16),
				:((Outer.PressureDrop.fi([1:N])-0.0035)*(Outer.PressureDrop.Re([1:N])^0.42) = 0.264),
				:((Outer.PressureDrop.fi([1:N])-0.0035)*(Outer.PressureDrop.Re([1:N])^0.42) = 0.264),
				:(Inner.HeatTransfer.fi([1:N]) = 1/(0.79*ln(Inner.HeatTransfer.Re([1:N]))-1.64)^2),
				:(Inner.HeatTransfer.Nu([1:N]) = 3.665 + ((0.19*((DiInner/Lpipe)*Inner.HeatTransfer.Re([1:N])*Inner.HeatTransfer.PR([1:N]))^0.8)/(1+0.117*((DiInner/Lpipe)*Inner.HeatTransfer.Re([1:N])*Inner.HeatTransfer.PR([1:N]))^0.467))),
				:(Inner.HeatTransfer.Nu([1:N]) = (49.027896+4.173281*Inner.HeatTransfer.Re([1:N])*Inner.HeatTransfer.PR([1:N])*(DiInner/Lpipe))^(1/3)),
				:(Inner.HeatTransfer.fi([1:N]) = 1/(0.79*ln(Inner.HeatTransfer.Re([1:N]))-1.64)^2),
				:(Inner.HeatTransfer.Nu([1:N])*(1+(12.7*sqrt(0.125*Inner.HeatTransfer.fi([1:N]))*((Inner.HeatTransfer.PR([1:N]))^(2/3) -1))) = 0.125*Inner.HeatTransfer.fi([1:N])*(Inner.HeatTransfer.Re([1:N])-1000)*Inner.HeatTransfer.PR([1:N])),
				:(Inner.HeatTransfer.Nu([1:N]) =0.116*(Inner.HeatTransfer.Re([1:N])^(0.667)-125)*Inner.HeatTransfer.PR([1:N])^(0.333)*(1+(DiInner/Lpipe)^0.667)),
				:(Inner.HeatTransfer.fi([1:N]) = 1/(1.82*log(Inner.HeatTransfer.Re([1:N]))-1.64)^2),
				:(Inner.HeatTransfer.Nu([1:N])*(1.07+(12.7*sqrt(0.125*Inner.HeatTransfer.fi([1:N]))*((Inner.HeatTransfer.PR([1:N]))^(2/3) -1))) = 0.125*Inner.HeatTransfer.fi([1:N])*Inner.HeatTransfer.Re([1:N])*Inner.HeatTransfer.PR([1:N])),
				:(Inner.HeatTransfer.Nu([1:N]) = 0.027*(Inner.HeatTransfer.PR([1:N]))^(1/3)*(Inner.HeatTransfer.Re([1:N]))^(4/5)),
				:(Inner.HeatTransfer.fi([1:N]) = 1/(1.82*log(Inner.HeatTransfer.Re([1:N]))-1.64)^2),
				:(Outer.HeatTransfer.fi([1:N]) = 1/(0.79*ln(Outer.HeatTransfer.Re([1:N]))-1.64)^2),
				:(Outer.HeatTransfer.Nu([1:N]) = 3.665 + ((0.19*((Outer.HeatTransfer.Dh/Lpipe)*Outer.HeatTransfer.Re([1:N])*Outer.HeatTransfer.PR([1:N]))^0.8)/(1+0.117*((Outer.HeatTransfer.Dh/Lpipe)*Outer.HeatTransfer.Re([1:N])*Outer.HeatTransfer.PR([1:N]))^0.467))),
				:(Outer.HeatTransfer.Nu([1:N]) = (49.027896+4.173281*Outer.HeatTransfer.Re([1:N])*Outer.HeatTransfer.PR([1:N])*(Outer.HeatTransfer.Dh/Lpipe))^(1/3)),
				:(Outer.HeatTransfer.fi([1:N]) = 1/(0.79*ln(Outer.HeatTransfer.Re([1:N]))-1.64)^2),
				:(Outer.HeatTransfer.Nu([1:N])*(1+(12.7*sqrt(0.125*Outer.HeatTransfer.fi([1:N]))*((Outer.HeatTransfer.PR([1:N]))^(2/3) -1))) = 0.125*Outer.HeatTransfer.fi([1:N])*(Outer.HeatTransfer.Re([1:N])-1000)*Outer.HeatTransfer.PR([1:N])),
				:(Outer.HeatTransfer.Nu([1:N]) = 0.116*(Outer.HeatTransfer.Re([1:N])^(0.667)-125)*Outer.HeatTransfer.PR([1:N])^(0.333)*(1+(Outer.HeatTransfer.Dh/Lpipe)^0.667)),
				:(Outer.HeatTransfer.fi([1:N]) = 1/(0.79*ln(Outer.HeatTransfer.Re([1:N]))-1.64)^2),
				:(Outer.HeatTransfer.fi([1:N]) = 1/(1.82*log(Outer.HeatTransfer.Re([1:N]))-1.64)^2),
				:(Outer.HeatTransfer.Nu([1:N])*(1.07+(12.7*sqrt(0.125*Outer.HeatTransfer.fi([1:N]))*((Outer.HeatTransfer.PR([1:N]))^(2/3) -1))) = 0.125*Outer.HeatTransfer.fi([1:N])*Outer.HeatTransfer.Re([1:N])*Outer.HeatTransfer.PR([1:N])),
				:(Outer.HeatTransfer.Nu([1:N]) = 0.027*(Outer.HeatTransfer.PR([1:N]))^(1/3)*(Outer.HeatTransfer.Re([1:N]))^(4/5)),
				:(Outer.HeatTransfer.fi([1:N]) = 1/(1.82*log(Outer.HeatTransfer.Re([1:N]))-1.64)^2),
				:(Inner.HeatTransfer.Enth([2:N]) = (1-InletInner.v)*PP.LiquidEnthalpy(Inner.HeatTransfer.Tlocal([2:N]), Inner.PressureDrop.Plocal([2:N]), InletInner.z) + InletInner.v*PP.VapourEnthalpy(Inner.HeatTransfer.Tlocal([2:N]), Inner.PressureDrop.Plocal([2:N]), InletInner.z)),
				:(Outer.HeatTransfer.Enth([2:N]) = (1-InletOuter.v)*PP.LiquidEnthalpy(Outer.HeatTransfer.Tlocal([2:N]), Outer.PressureDrop.Plocal([2:N]), InletOuter.z) + InletOuter.v*PP.VapourEnthalpy(Outer.HeatTransfer.Tlocal([2:N]), Outer.PressureDrop.Plocal([2:N]), InletOuter.z)),
				:(Inner.HeatTransfer.hcoeff = (Inner.HeatTransfer.Nu*Inner.Properties.Average.K/DiInner)*Inner.HeatTransfer.Phi),
				:(Outer.HeatTransfer.hcoeff= (Outer.HeatTransfer.Nu*Outer.Properties.Average.K/Outer.HeatTransfer.Dh)*Outer.HeatTransfer.Phi),
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
				:(Details.Uc*((DoInner/(sum(Inner.HeatTransfer.hcoeff)/N*DiInner) )+(DoInner*ln(DoInner/DiInner)/(2*Kwall))+(1/(sum(Outer.HeatTransfer.hcoeff)/N)))=1),
				:(Details.Ud=1/(Rfi*(DoInner/DiInner) + Rfo + (DoInner/(Inner.HeatTransfer.hcoeff*DiInner) )+(DoInner*ln(DoInner/DiInner)/(2*Kwall))+(1/(Outer.HeatTransfer.hcoeff)))),
				:(Details.Qtotal = sum(Details.Q)),
			],
			[
				"Outer	Stream Average Temperature","Inner Stream Average Temperature","Outer Stream Average Pressure","Inner Stream Average Pressure","Inner Stream Wall Temperature","Outer Stream Wall Temperature","Outer Stream Average Molecular Weight","Inner Stream Average Molecular Weight","Inlet Mass Density Inner Stream","Outlet Mass Density Inner Stream","Inlet Mass Density Inner Stream","Outlet Mass Density Inner Stream","Inlet Mass Density Outer Stream","Outlet Mass Density Outer Stream","Inlet Mass Density Outer Stream","Outlet Mass Density Outer Stream","Average Heat Capacity Inner Stream","Average Mass Density Inner Stream","Average Viscosity Inner Stream","Average	Conductivity Inner Stream","Viscosity Inner Stream at wall temperature","Average Heat Capacity InnerStream","Average Mass Density Inner Stream","Average Viscosity Inner Stream","Average Conductivity Inner Stream","Viscosity Inner Stream at wall temperature","Average Heat Capacity Outer Stream","Average Mass Density Outer Stream","Average Viscosity Outer Stream","Average Conductivity Outer Stream","Viscosity Outer Stream at wall temperature","Average Heat Capacity Outer Stream","Average Mass Density Outer Stream","Average Viscosity Outer Stream","Average Conductivity Outer Stream","Viscosity Outer Stream at wall temperature","Flow Mass Inlet Inner Stream","Flow Mass Outlet Inner Stream","Flow Mass Inlet Outer Stream","Flow Mass Outlet Outer Stream","Molar Balance Outer Stream","Molar Balance Inner Stream","Outer Stream Molar Fraction Constraint","InnerStream Molar Fraction Constraint","Total Exchange Surface Area for one segment of pipe","Pipe Initial Length from Left to Right","Incremental Length","Inner Side Friction Factor for Pressure Drop - laminar Flow","using Turbulent Flow - to be implemented","Inner Side Friction Factor - Turbulent Flow","Outer Side Friction Factor - laminar Flow","using Turbulent Flow - Transition Flow must be implemented","Outer Side Friction Factor - Turbulent Flow","Inner Side Friction Factor for Heat Transfer - laminar Flow","Nusselt Number","Nusselt Number","Inner Side Friction Factor for Heat Transfer - transition Flow","Nusselt Number","Nusselt Number","Inner Side Friction Factor for Heat Transfer - turbulent Flow","Nusselt Number","Nusselt Number","Inner Side Friction Factor for Heat Transfer - turbulent Flow","Outer Side Friction Factor for Heat Transfer - laminar Flow","Nusselt Number","Nusselt Number","Outer Side Friction Factor for Heat Transfer - transition Flow","Nusselt Number","Nusselt Number","Outer Side Friction Factor for Heat Transfer - transition Flow","Outer Side Friction Factor for Heat Transfer - turbulent Flow","Nusselt Number","Nusselt Number","Outer Side Friction Factor for Heat Transfer - turbulent Flow","Incremental Enthalpy Inner Stream","Incremental Enthalpy Outer Stream","Inner Pipe Film Coefficient","Outer Pipe Film Coefficient","Outer Pipe Phi correction","Inner Pipe Phi correction","Outer Pipe Prandtl Number","Inner Pipe Prandtl Number","Outer Pipe Reynolds Number for Heat Transfer","Outer Pipe Reynolds Number for Pressure Drop","Inner Pipe Reynolds Number for Heat Transfer","Inner Pipe Reynolds Number for Pressure Drop","Outer Pipe Velocity","Inner Pipe Velocity","Average Overall Heat Transfer Coefficient Clean","Overall Heat Transfer Coefficient Dirty","Total Duty",
			],
			[:PP,:NComp,:N,:Npoints,:M,:HotSide,:innerFlowRegime,:outerFlowRegime,:InnerLaminarCorrelation,:InnerTransitionCorrelation,:InnerTurbulentCorrelation,:OuterLaminarCorrelation,:OuterTransitionCorrelation,:OuterTurbulentCorrelation,:Pi,:DoInner,:DiInner,:DiOuter,:Lpipe,:Kwall,:Rfi,:Rfo,],
			[:InletInner,:InletOuter,:OutletInner,:OutletOuter,:Details,:Inner,:Outer,:Lincr,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	N::DanaInteger 
	Npoints::DanaInteger 
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
	Pi::constant 
	DoInner::length 
	DiInner::length 
	DiOuter::length 
	Lpipe::length 
	Kwall::conductivity 
	Rfi::positive 
	Rfo::positive 
	InletInner::stream 
	InletOuter::stream 
	OutletInner::streamPH 
	OutletOuter::streamPH 
	Details::Details_Main 
	Inner::Main_Hairpin 
	Outer::Main_Hairpin 
	Lincr::Array{length }
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export HairpinIncr_basic
function set(in::HairpinIncr_basic)
	#"Component Molecular Weight"
	M = PP.MolecularWeight()
	 #"Inner Pipe Cross Sectional Area for Flow"
	Inner.HeatTransfer.As=0.25*Pi*DiInner*DiInner
	 #"Outer Pipe Cross Sectional Area for Flow"
	Outer.HeatTransfer.As=0.25*Pi*(DiOuter*DiOuter - DoInner*DoInner)
	 #"Inner Pipe Hydraulic Diameter for Heat Transfer"
	Inner.HeatTransfer.Dh=DiInner
	 #"Outer Pipe Hydraulic Diameter for Heat Transfer"
	Outer.HeatTransfer.Dh=(DiOuter*DiOuter-DoInner*DoInner)/DoInner
	 #"Inner Pipe Hydraulic Diameter for Pressure Drop"
	Inner.PressureDrop.Dh=DiInner
	 #"Outer Pipe Hydraulic Diameter for Pressure Drop"
	Outer.PressureDrop.Dh=DiOuter-DoInner
	 
end
function setEquationFlow(in::HairpinIncr_basic)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
	addEquation(7)
	addEquation(8)
	if InletInner.v == 0 
		addEquation(9)
		addEquation(10)
	else
		addEquation(11)
		addEquation(12)
	end
	if InletOuter.v == 0 
		addEquation(13)
		addEquation(14)
	else
		addEquation(15)
		addEquation(16)
	end
	if InletInner.v == 0 
		addEquation(17)
		addEquation(18)
		addEquation(19)
		addEquation(20)
		addEquation(21)
	else
		addEquation(22)
		addEquation(23)
		addEquation(24)
		addEquation(25)
		addEquation(26)
	end
	if InletOuter.v == 0 
		addEquation(27)
		addEquation(28)
		addEquation(29)
		addEquation(30)
		addEquation(31)
	else
		addEquation(32)
		addEquation(33)
		addEquation(34)
		addEquation(35)
		addEquation(36)
	end
	addEquation(37)
	addEquation(38)
	addEquation(39)
	addEquation(40)
	addEquation(41)
	addEquation(42)
	addEquation(43)
	addEquation(44)
	addEquation(45)
	addEquation(46)
	addEquation(47)
	let switch=innerFlowRegime
		if innerFlowRegime==Inner.PressureDrop.Re(i) > 2300
			set(switch,"transition")
		end
		if innerFlowRegime==Inner.PressureDrop.Re(i) < 2300
			set(switch,"laminar")
		end
		if innerFlowRegime==Inner.PressureDrop.Re(i) > 10000
			set(switch,"turbulent")
		end
		if innerFlowRegime==Inner.PressureDrop.Re(i) < 10000
			set(switch,"transition")
		end
		if switch=="laminar"
			addEquation(48)
		elseif switch=="transition"
			addEquation(49)
		elseif switch=="turbulent"
			addEquation(50)
		end
	end
	let switch=outerFlowRegime
		if outerFlowRegime==Outer.PressureDrop.Re(i) > 2300
			set(switch,"transition")
		end
		if outerFlowRegime==Outer.PressureDrop.Re(i) < 2300
			set(switch,"laminar")
		end
		if outerFlowRegime==Outer.PressureDrop.Re(i) > 10000
			set(switch,"turbulent")
		end
		if outerFlowRegime==Outer.PressureDrop.Re(i) < 10000
			set(switch,"transition")
		end
		if switch=="laminar"
			addEquation(51)
		elseif switch=="transition"
			addEquation(52)
		elseif switch=="turbulent"
			addEquation(53)
		end
	end
	let switch=innerFlowRegime
		if innerFlowRegime==Inner.HeatTransfer.Re(i) > 2300
			set(switch,"transition")
		end
		if innerFlowRegime==Inner.HeatTransfer.Re(i) < 2300
			set(switch,"laminar")
		end
		if innerFlowRegime==Inner.HeatTransfer.Re(i) > 10000
			set(switch,"turbulent")
		end
		if innerFlowRegime==Inner.HeatTransfer.Re(i) < 10000
			set(switch,"transition")
		end
		if switch=="laminar"
			addEquation(54)
			let switch=InnerLaminarCorrelation
				if switch=="Hausen"
					addEquation(55)
				elseif switch=="Schlunder"
					addEquation(56)
				end
			end
		elseif switch=="transition"
			addEquation(57)
			let switch=InnerTransitionCorrelation
				if switch=="Gnielinski"
					addEquation(58)
				elseif switch=="Hausen"
					addEquation(59)
				end
			end
		elseif switch=="turbulent"
			let switch=InnerTurbulentCorrelation
				if switch=="Petukhov"
					addEquation(60)
					addEquation(61)
				elseif switch=="SiederTate"
					addEquation(62)
					addEquation(63)
				end
			end
		end
	end
	let switch=outerFlowRegime
		if outerFlowRegime==Outer.HeatTransfer.Re(i) > 2300
			set(switch,"transition")
		end
		if outerFlowRegime==Outer.HeatTransfer.Re(i) < 2300
			set(switch,"laminar")
		end
		if outerFlowRegime==Outer.HeatTransfer.Re(i) > 10000
			set(switch,"turbulent")
		end
		if outerFlowRegime==Outer.HeatTransfer.Re(i) < 10000
			set(switch,"transition")
		end
		if switch=="laminar"
			addEquation(64)
			let switch=OuterLaminarCorrelation
				if switch=="Hausen"
					addEquation(65)
				elseif switch=="Schlunder"
					addEquation(66)
				end
			end
		elseif switch=="transition"
			let switch=OuterTransitionCorrelation
				if switch=="Gnielinski"
					addEquation(67)
					addEquation(68)
				elseif switch=="Hausen"
					addEquation(69)
					addEquation(70)
				end
			end
		elseif switch=="turbulent"
			let switch=OuterTurbulentCorrelation
				if switch=="Petukhov"
					addEquation(71)
					addEquation(72)
				elseif switch=="SiederTate"
					addEquation(73)
					addEquation(74)
				end
			end
		end
	end
	addEquation(75)
	addEquation(76)
	addEquation(77)
	addEquation(78)
	addEquation(79)
	addEquation(80)
	addEquation(81)
	addEquation(82)
	addEquation(83)
	addEquation(84)
	addEquation(85)
	addEquation(86)
	addEquation(87)
	addEquation(88)
	addEquation(89)
	addEquation(90)
	addEquation(91)
end
function atributes(in::HairpinIncr_basic,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Incremental Hairpin Heat Exchanger. "
	fields[:Info]="Incremental approach for Hairpin heat exchanger. "
	drive!(fields,_)
	return fields
end
HairpinIncr_basic(_::Dict{Symbol,Any})=begin
	newModel=HairpinIncr_basic()
	newModel.attributes=atributes(newModel,_)
	newModel
end
