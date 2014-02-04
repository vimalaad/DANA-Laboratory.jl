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
#* $Id: DoublePipeIncr.mso								$
#*------------------------------------------------------------------
type DoublePipeIncr
	DoublePipeIncr()=begin
		PP=outers.PP
		NComp=outers.NComp
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
			fill(molweight ((Symbol=>Any)[
				:Brief=>"Component Mol Weight"
			]),(NComp)),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Flow Direction",
				:Valid=>["counter","cocurrent"],
				:Default=>"cocurrent"
			]),
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
			length ((Symbol=>Any)[
				:Brief=>"Inner Side Outlet Nozzle Diameter",
				:Default=>0.036,
				:Lower=>10e-6
			]),
			length ((Symbol=>Any)[
				:Brief=>"Inner Side Inlet Nozzle Diameter",
				:Default=>0.036,
				:Lower=>10e-6
			]),
			length ((Symbol=>Any)[
				:Brief=>"Outer Side Outlet Nozzle Diameter",
				:Default=>0.036,
				:Lower=>10e-6
			]),
			length ((Symbol=>Any)[
				:Brief=>"Outer Side Inlet Nozzle Diameter",
				:Default=>0.036,
				:Lower=>10e-6
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Inner Side Inlet Nozzle Pressure Loss Coeff",
				:Default=>1.1
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Inner Side Outlet Nozzle Pressure Loss Coeff",
				:Default=>0.7
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Outer Side Inlet Nozzle Pressure Loss Coeff",
				:Default=>1.1
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Outer Side Outlet Nozzle Pressure Loss Coeff",
				:Default=>0.7
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
				:(Details.Q(1:N) = InletOuter.F*(Outer.HeatTransfer.Enth(1:N) - Outer.HeatTransfer.Enth(2:Npoints))),
				:(Details.Q(1:N) = InletOuter.F*(Outer.HeatTransfer.Enth(2:Npoints) - Outer.HeatTransfer.Enth(1:N))),
				:(Details.Q(1:N) = -InletInner.F*(Inner.HeatTransfer.Enth(1:N) - Inner.HeatTransfer.Enth(2:Npoints))),
				:(Details.Q(1:N) = InletInner.F*(Inner.HeatTransfer.Enth(1:N)-Inner.HeatTransfer.Enth(2:Npoints))),
				:(Details.Q(1:N) = -InletOuter.F*(Outer.HeatTransfer.Enth(1:N) - Outer.HeatTransfer.Enth(2:Npoints))),
				:(Details.Q(1:N) = -InletOuter.F*(Outer.HeatTransfer.Enth(2:Npoints) - Outer.HeatTransfer.Enth(1:N))),
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
				:(Details.Uc*((DoInner/(Inner.HeatTransfer.hcoeff*DiInner) )+(DoInner*ln(DoInner/DiInner)/(2*Kwall))+(1/(Outer.HeatTransfer.hcoeff)))=1),
				:(Details.Ud*(Rfi*(DoInner/DiInner) + Rfo + (DoInner/(Inner.HeatTransfer.hcoeff*DiInner) )+(DoInner*ln(DoInner/DiInner)/(2*Kwall))+(1/(Outer.HeatTransfer.hcoeff)))=1),
				:(Details.Qtotal = sum(Details.Q)),
				:(Details.Q = Details.Ud*Pi*DoInner*(Lpipe/N)*(Outer.Properties.Average.T - Inner.Properties.Average.T)),
				:(Details.Q = Details.Ud*Pi*DoInner*(Lpipe/N)*(Inner.Properties.Average.T - Outer.Properties.Average.T)),
				:(Details.Q = Qestimated/N),
				:(Inner.HeatTransfer.Enth([2:N]) = (1-InletInner.v)*PP.LiquidEnthalpy(Inner.HeatTransfer.Tlocal([2:N]), Inner.PressureDrop.Plocal([2:N]), InletInner.z) + InletInner.v*PP.VapourEnthalpy(Inner.HeatTransfer.Tlocal([2:N]), Inner.PressureDrop.Plocal([2:N]), InletInner.z)),
				:(Outer.HeatTransfer.Enth([2:N]) = (1-InletOuter.v)*PP.LiquidEnthalpy(Outer.HeatTransfer.Tlocal([2:N]), Outer.PressureDrop.Plocal([2:N]), InletOuter.z) + InletOuter.v*PP.VapourEnthalpy(Outer.HeatTransfer.Tlocal([2:N]), Outer.PressureDrop.Plocal([2:N]), InletOuter.z)),
				:(Inner.HeatTransfer.Enth(1) = InletInner.h),
				:(Inner.HeatTransfer.Enth(Npoints) = OutletInner.h),
				:(Inner.HeatTransfer.Tlocal(1) = InletInner.T),
				:(Inner.HeatTransfer.Tlocal(Npoints) = OutletInner.T),
				:(Inner.PressureDrop.Plocal(1) = InletInner.P),
				:(Inner.PressureDrop.Plocal(Npoints) = OutletInner.P),
				:(Outer.HeatTransfer.Enth(1) = InletOuter.h),
				:(Outer.HeatTransfer.Enth(Npoints) = OutletOuter.h),
				:(Outer.HeatTransfer.Tlocal(1) = InletOuter.T),
				:(Outer.HeatTransfer.Tlocal(Npoints) = OutletOuter.T),
				:(Outer.PressureDrop.Plocal(1) = InletOuter.P),
				:(Outer.PressureDrop.Plocal(Npoints) = OutletOuter.P),
				:(Outer.HeatTransfer.Enth(Npoints) = InletOuter.h),
				:(Outer.HeatTransfer.Enth(1) = OutletOuter.h),
				:(Outer.HeatTransfer.Tlocal(Npoints) = InletOuter.T),
				:(Outer.HeatTransfer.Tlocal(1) = OutletOuter.T),
				:(Outer.PressureDrop.Plocal(Npoints) = InletOuter.P),
				:(Outer.PressureDrop.Plocal(1) = OutletOuter.P),
				:(Outer.PressureDrop.Pdrop = Outer.PressureDrop.Pd_fric(Npoints)+Outer.PressureDrop.Pdnozzle_in+Outer.PressureDrop.Pdnozzle_out),
				:(Outer.PressureDrop.Pd_fric(2:Npoints) = (2*Outer.PressureDrop.fi*Lincr(2:Npoints)*Outer.Properties.Average.rho*Outer.HeatTransfer.Vmean^2)/(Outer.PressureDrop.Dh*Outer.HeatTransfer.Phi)),
				:(Outer.PressureDrop.Pd_fric(1) = 0*"kPa"),
				:(Outer.PressureDrop.Plocal([1:N]+1) = Outer.PressureDrop.Plocal(1) - Outer.PressureDrop.Pd_fric([1:N]+1)),
				:(Outer.PressureDrop.Pdrop = Outer.PressureDrop.Pd_fric(1)+Outer.PressureDrop.Pdnozzle_in+Outer.PressureDrop.Pdnozzle_out),
				:(Outer.PressureDrop.Pd_fric([1:N]) = (2*Outer.PressureDrop.fi([1:N])*Lincr(1+N-[1:N])*Outer.Properties.Average.rho([1:N])*Outer.HeatTransfer.Vmean([1:N])^2)/(Outer.PressureDrop.Dh*Outer.HeatTransfer.Phi([1:N]))),
				:(Outer.PressureDrop.Pd_fric(Npoints) = 0*"kPa"),
				:(Outer.PressureDrop.Plocal([1:N]) = Outer.PressureDrop.Plocal(Npoints) - Outer.PressureDrop.Pd_fric([1:N]+1)),
				:(Inner.PressureDrop.Pdrop = Inner.PressureDrop.Pd_fric(Npoints)+Inner.PressureDrop.Pdnozzle_in+Inner.PressureDrop.Pdnozzle_out),
				:(Inner.PressureDrop.Pd_fric(2:Npoints) = (2*Inner.PressureDrop.fi*Lincr(2:Npoints)*Inner.Properties.Average.rho*Inner.HeatTransfer.Vmean^2)/(DiInner*Inner.HeatTransfer.Phi)),
				:(Inner.PressureDrop.Pd_fric(1) = 0*"kPa"),
				:(Inner.PressureDrop.Plocal([1:N]+1) = Inner.PressureDrop.Plocal(1) - Inner.PressureDrop.Pd_fric([1:N]+1)),
				:(Inner.PressureDrop.Vnozzle_in = Inner.Properties.Inlet.Fw/(Inner.Properties.Inlet.rho*(0.25*Pi*Dinozzle_Inner^2))),
				:(Inner.PressureDrop.Vnozzle_out = Inner.Properties.Outlet.Fw/(Inner.Properties.Outlet.rho*(0.25*Pi*Donozzle_Inner^2))),
				:(Outer.PressureDrop.Vnozzle_in = Outer.Properties.Inlet.Fw/(Outer.Properties.Inlet.rho*(0.25*Pi*Dinozzle_Outer^2))),
				:(Outer.PressureDrop.Vnozzle_out = Outer.Properties.Outlet.Fw/(Outer.Properties.Outlet.rho*(0.25*Pi*Donozzle_Outer^2))),
				:(Inner.PressureDrop.Pdnozzle_in = 0.5*InnerKinlet*Inner.Properties.Inlet.rho*Inner.PressureDrop.Vnozzle_in^2),
				:(Inner.PressureDrop.Pdnozzle_out = 0.5*InnerKoutlet*Inner.Properties.Outlet.rho*Inner.PressureDrop.Vnozzle_out^2),
				:(Outer.PressureDrop.Pdnozzle_in = 0.5*OuterKinlet*Outer.Properties.Inlet.rho*Outer.PressureDrop.Vnozzle_in^2),
				:(Outer.PressureDrop.Pdnozzle_out = 0.5*OuterKoutlet*Outer.Properties.Outlet.rho*Outer.PressureDrop.Vnozzle_out^2),
				:(Inner.PressureDrop.RVsquare_in = Inner.Properties.Inlet.rho*(Inner.PressureDrop.Vnozzle_in)^2),
				:(Inner.PressureDrop.RVsquare_out = Inner.Properties.Outlet.rho*(Inner.PressureDrop.Vnozzle_out)^2),
				:(Outer.PressureDrop.RVsquare_in = Outer.Properties.Inlet.rho*(Outer.PressureDrop.Vnozzle_in)^2),
				:(Outer.PressureDrop.RVsquare_out = Outer.Properties.Outlet.rho*(Outer.PressureDrop.Vnozzle_out)^2),
			],
			[
				"Outer	Stream Average Temperature","Inner Stream Average Temperature","Outer Stream Average Pressure","Inner Stream Average Pressure","Inner Stream Wall Temperature","Outer Stream Wall Temperature","Outer Stream Average Molecular Weight","Inner Stream Average Molecular Weight","Inlet Mass Density Inner Stream","Outlet Mass Density Inner Stream","Inlet Mass Density Inner Stream","Outlet Mass Density Inner Stream","Inlet Mass Density Outer Stream","Outlet Mass Density Outer Stream","Inlet Mass Density Outer Stream","Outlet Mass Density Outer Stream","Average Heat Capacity Inner Stream","Average Mass Density Inner Stream","Average Viscosity Inner Stream","Average	Conductivity Inner Stream","Viscosity Inner Stream at wall temperature","Average Heat Capacity InnerStream","Average Mass Density Inner Stream","Average Viscosity Inner Stream","Average Conductivity Inner Stream","Viscosity Inner Stream at wall temperature","Average Heat Capacity Outer Stream","Average Mass Density Outer Stream","Average Viscosity Outer Stream","Average Conductivity Outer Stream","Viscosity Outer Stream at wall temperature","Average Heat Capacity Outer Stream","Average Mass Density Outer Stream","Average Viscosity Outer Stream","Average Conductivity Outer Stream","Viscosity Outer Stream at wall temperature","Energy Balance Outer Stream in cocurrent flow","Energy Balance Outer Stream in counter flow","Energy Balance Inner Stream","Energy Balance Hot Stream","Energy Balance Cold Stream in cocurrent flow","Energy Balance Cold Stream in counter flow","Flow Mass Inlet Inner Stream","Flow Mass Outlet Inner Stream","Flow Mass Inlet Outer Stream","Flow Mass Outlet Outer Stream","Molar Balance Outer Stream","Molar Balance Inner Stream","Outer Stream Molar Fraction Constraint","InnerStream Molar Fraction Constraint","Total Exchange Surface Area for one segment of pipe","Pipe Initial Length from Left to Right - OBS: Left: Always Inlet inner side","Incremental Length","Inner Side Friction Factor for Pressure Drop - laminar Flow","using Turbulent Flow - to be implemented","Inner Side Friction Factor - Turbulent Flow","Outer Side Friction Factor - laminar Flow","using Turbulent Flow - Transition Flow must be implemented","Outer Side Friction Factor - Turbulent Flow","Inner Side Friction Factor for Heat Transfer - laminar Flow","Nusselt Number","Nusselt Number","Inner Side Friction Factor for Heat Transfer - transition Flow","Nusselt Number","Nusselt Number","Inner Side Friction Factor for Heat Transfer - turbulent Flow","Nusselt Number","Nusselt Number","Inner Side Friction Factor for Heat Transfer - turbulent Flow","Outer Side Friction Factor for Heat Transfer - laminar Flow","Nusselt Number","Nusselt Number","Outer Side Friction Factor for Heat Transfer - transition Flow","Nusselt Number","Nusselt Number","Outer Side Friction Factor for Heat Transfer - transition Flow","Outer Side Friction Factor for Heat Transfer - turbulent Flow","Nusselt Number","Nusselt Number","Outer Side Friction Factor for Heat Transfer - turbulent Flow","Inner Pipe Film Coefficient","Outer Pipe Film Coefficient","Outer Pipe Phi correction","Inner Pipe Phi correction","Outer Pipe Prandtl Number","Inner Pipe Prandtl Number","Outer Pipe Reynolds Number for Heat Transfer","Outer Pipe Reynolds Number for Pressure Drop","Inner Pipe Reynolds Number for Heat Transfer","Inner Pipe Reynolds Number for Pressure Drop","Outer Pipe Velocity","Inner Pipe Velocity","Overall Heat Transfer Coefficient Clean","Overall Heat Transfer Coefficient Dirty","Total Duty","Incremental Duty","Incremental Duty","Duty","Incremental Enthalpy Inner Stream","Incremental Enthalpy Outer Stream","Enthalpy of Inner Side - Inlet Boundary","Enthalpy of inner Side - Outlet Boundary","Temperature of Inner Side - Inlet Boundary","Temperature of Inner Side - Outlet Boundary","Pressure of Inner Side - Inlet Boundary","Pressure of Inner Side - Outlet Boundary","Enthalpy of Outer Side - Inlet Boundary","Enthalpy of Outer Side - Outlet Boundary","Temperature of Outer Side - Inlet Boundary","Temperature of Outer Side - Outlet Boundary","Pressure of Outer Side - Inlet Boundary","Pressure of Outer Side - Outlet Boundary","Enthalpy of Outer Side - Inlet Boundary","Enthalpy of Outer Side - Outlet Boundary","Temperature of Outer Side - Inlet Boundary","Temperature of Outer Side - Outlet Boundary","Pressure of Outer Side - Inlet Boundary","Pressure of Outer Side - Outlet Boundary","Total Pressure Drop Outer Stream","Outer Pipe Pressure Drop for friction","Outer Pipe Pressure Drop for friction","Outer Pipe Local Pressure","Total Pressure Drop Outer Stream","Outer Pipe Pressure Drop for friction","Outer Pipe Pressure Drop for friction","Outer Pipe Local Pressure","Total Pressure Drop Inner Stream","Inner Pipe Pressure Drop for friction","Inner Pipe Pressure Drop for friction","Inner Pipe Local Pressure","Velocity Inner Side Inlet Nozzle","Velocity Inner Side Outlet Nozzle","Velocity Outer Side Inlet Nozzle","Velocity Outer Side Outlet Nozzle","Pressure Drop Inner Side Inlet Nozzle","Pressure Drop Inner Side Outlet Nozzle","Pressure Drop Outer Side Inlet Nozzle","Pressure Drop Outer Side Outlet Nozzle","Inner Side Inlet Nozzle rho-V^2","Inner Side Outlet Nozzle rho-V^2","Outer Side Inlet Nozzle rho-V^2","Outer Side Outlet Nozzle rho-V^2",
			],
			[:PP,:NComp,:N,:Npoints,:CalculationApproach,:Qestimated,:M,:FlowDirection,:HotSide,:innerFlowRegime,:outerFlowRegime,:InnerLaminarCorrelation,:InnerTransitionCorrelation,:InnerTurbulentCorrelation,:OuterLaminarCorrelation,:OuterTransitionCorrelation,:OuterTurbulentCorrelation,:Pi,:DoInner,:DiInner,:DiOuter,:Lpipe,:Kwall,:Rfi,:Rfo,:Donozzle_Inner,:Dinozzle_Inner,:Donozzle_Outer,:Dinozzle_Outer,:InnerKinlet,:InnerKoutlet,:OuterKinlet,:OuterKoutlet,],
			[:InletInner,:InletOuter,:OutletInner,:OutletOuter,:Details,:Inner,:Outer,:Lincr,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	N::DanaInteger 
	Npoints::DanaInteger 
	CalculationApproach::DanaSwitcher 
	Qestimated::power 
	M::Array{molweight }
	FlowDirection::DanaSwitcher 
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
	Donozzle_Inner::length 
	Dinozzle_Inner::length 
	Donozzle_Outer::length 
	Dinozzle_Outer::length 
	InnerKinlet::positive 
	InnerKoutlet::positive 
	OuterKinlet::positive 
	OuterKoutlet::positive 
	InletInner::stream 
	InletOuter::stream 
	OutletInner::streamPH 
	OutletOuter::streamPH 
	Details::Details_Main 
	Inner::Main_DoublePipe 
	Outer::Main_DoublePipe 
	Lincr::Array{length }
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export DoublePipeIncr
function set(in::DoublePipeIncr)
	#"Number of incremental points"
	Npoints = N+1
	 #"Component Molecular Weight"
	M = PP.MolecularWeight()
	 #"Pi Number"
	Pi = 3.14159265
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
function setEquationFlow(in::DoublePipeIncr)
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
	let switch=HotSide
		if HotSide==InletInner.T > InletOuter.T
			set(switch,"inner")
		end
		if HotSide==InletInner.T < InletOuter.T
			set(switch,"outer")
		end
		if switch=="outer"
			let switch=FlowDirection
				if switch=="cocurrent"
					addEquation(37)
				elseif switch=="counter"
					addEquation(38)
				end
			end
			addEquation(39)
		elseif switch=="inner"
			addEquation(40)
			let switch=FlowDirection
				if switch=="cocurrent"
					addEquation(41)
				elseif switch=="counter"
					addEquation(42)
				end
			end
		end
	end
	addEquation(43)
	addEquation(44)
	addEquation(45)
	addEquation(46)
	addEquation(47)
	addEquation(48)
	addEquation(49)
	addEquation(50)
	addEquation(51)
	addEquation(52)
	addEquation(53)
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
			addEquation(54)
		elseif switch=="transition"
			addEquation(55)
		elseif switch=="turbulent"
			addEquation(56)
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
			addEquation(57)
		elseif switch=="transition"
			addEquation(58)
		elseif switch=="turbulent"
			addEquation(59)
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
			addEquation(60)
			let switch=InnerLaminarCorrelation
				if switch=="Hausen"
					addEquation(61)
				elseif switch=="Schlunder"
					addEquation(62)
				end
			end
		elseif switch=="transition"
			addEquation(63)
			let switch=InnerTransitionCorrelation
				if switch=="Gnielinski"
					addEquation(64)
				elseif switch=="Hausen"
					addEquation(65)
				end
			end
		elseif switch=="turbulent"
			let switch=InnerTurbulentCorrelation
				if switch=="Petukhov"
					addEquation(66)
					addEquation(67)
				elseif switch=="SiederTate"
					addEquation(68)
					addEquation(69)
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
			addEquation(70)
			let switch=OuterLaminarCorrelation
				if switch=="Hausen"
					addEquation(71)
				elseif switch=="Schlunder"
					addEquation(72)
				end
			end
		elseif switch=="transition"
			let switch=OuterTransitionCorrelation
				if switch=="Gnielinski"
					addEquation(73)
					addEquation(74)
				elseif switch=="Hausen"
					addEquation(75)
					addEquation(76)
				end
			end
		elseif switch=="turbulent"
			let switch=OuterTurbulentCorrelation
				if switch=="Petukhov"
					addEquation(77)
					addEquation(78)
				elseif switch=="SiederTate"
					addEquation(79)
					addEquation(80)
				end
			end
		end
	end
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
	addEquation(92)
	addEquation(93)
	addEquation(94)
	addEquation(95)
	let switch=CalculationApproach
		if switch=="Full"
			let switch=HotSide
				if HotSide==InletInner.T > InletOuter.T
					set(switch,"inner")
				end
				if HotSide==InletInner.T < InletOuter.T
					set(switch,"outer")
				end
				if switch=="outer"
					addEquation(96)
				elseif switch=="inner"
					addEquation(97)
				end
			end
		elseif switch=="Simplified"
			addEquation(98)
		end
	end
	addEquation(99)
	addEquation(100)
	addEquation(101)
	addEquation(102)
	addEquation(103)
	addEquation(104)
	addEquation(105)
	addEquation(106)
	let switch=FlowDirection
		if switch=="cocurrent"
			addEquation(107)
			addEquation(108)
			addEquation(109)
			addEquation(110)
			addEquation(111)
			addEquation(112)
		elseif switch=="counter"
			addEquation(113)
			addEquation(114)
			addEquation(115)
			addEquation(116)
			addEquation(117)
			addEquation(118)
		end
	end
	let switch=FlowDirection
		if switch=="cocurrent"
			addEquation(119)
			addEquation(120)
			addEquation(121)
			# FIXME: NOZZLE PRESSURE DROP MUST BE ADDED
			addEquation(122)
		elseif switch=="counter"
			addEquation(123)
			addEquation(124)
			addEquation(125)
			# FIXME: NOZZLE PRESSURE DROP MUST BE ADDED
			addEquation(126)
		end
	end
	addEquation(127)
	addEquation(128)
	addEquation(129)
	# FIXME: NOZZLE PRESSURE DROP MUST BE ADDED
	addEquation(130)
	addEquation(131)
	addEquation(132)
	addEquation(133)
	addEquation(134)
	addEquation(135)
	addEquation(136)
	addEquation(137)
	addEquation(138)
	addEquation(139)
	addEquation(140)
	addEquation(141)
	addEquation(142)
end
function atributes(in::DoublePipeIncr,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/DoublePipe"
	fields[:Brief]="Incremental Double Pipe Heat Exchanger. "
	fields[:Info]="Incremental approach for a single double pipe heat exchanger. "
	drive!(fields,_)
	return fields
end
DoublePipeIncr(_::Dict{Symbol,Any})=begin
	newModel=DoublePipeIncr()
	newModel.attributes=atributes(newModel,_)
	newModel
end
