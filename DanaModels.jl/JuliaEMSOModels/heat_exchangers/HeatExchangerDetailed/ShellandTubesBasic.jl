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
#* $Id: HeatExchangerDetailed.mso 197 2007-03-08 14:31:57Z bicca $
#*------------------------------------------------------------------
type ShellandTubesBasic
	ShellandTubesBasic()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Hot Side in the Exchanger",
				:Valid=>["shell","tubes"],
				:Default=>"shell"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"TEMA Designation",
				:Valid=>["Eshell","Fshell"],
				:Default=>"Eshell"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Tube Layout Characteristic Angle",
				:Valid=>["Triangle","Rotated Square","Square"],
				:Default=>"Triangle"
			]),
			Tube_Side_Main ((Symbol=>Any)[
				:Brief=>"Tube Side Section" ,
				:Symbol=>"^{tube}"
			]),
			Shell_Side_Main ((Symbol=>Any)[
				:Brief=>"Shell Side Section" ,
				:Symbol=>"^{shell}"
			]),
			Baffles_Main ((Symbol=>Any)[
				:Brief=>"Baffle Section",
				:Symbol=>" "
			]),
			Clearances_Main ((Symbol=>Any)[
				:Brief=>"Diametral Clearances",
				:Symbol=>" "
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet Tube Stream",
				:PosX=>0.08,
				:PosY=>0,
				:Symbol=>"_{in }^{tube}"
			]),
			streamPH ((Symbol=>Any)[
				:Brief=>"Outlet Tube Stream",
				:PosX=>0.08,
				:PosY=>1,
				:Symbol=>"_{out }^{tube}"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet Shell Stream",
				:PosX=>0.2237,
				:PosY=>0,
				:Symbol=>"_{in }^{shell}"
			]),
			streamPH ((Symbol=>Any)[
				:Brief=>"Outlet Shell Stream",
				:PosX=>0.8237,
				:PosY=>1,
				:Symbol=>"_{out }^{shell}"
			]),
			Details_Main ((Symbol=>Any)[
				:Brief=>"Details in Heat Exchanger",
				:Symbol=>" "
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Number of Tube rows Crossed in one Crossflow Section",
				:Hidden=>true,
				:Lower=>1
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Number of Effective Crossflow rows in Each Window",
				:Hidden=>true,
				:Lower=>1
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Variable for calculating Ji heat transfer correction Factor",
				:Hidden=>true,
				:Lower=>1e-3
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Variable for calculating shell side pressure drop friction Factor",
				:Hidden=>true,
				:Lower=>1e-3
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"ByPass Correction Factor for Pressure Drop",
				:Hidden=>true,
				:Lower=>1e-3
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Correction Factor for Pressure Drop",
				:Hidden=>true,
				:Lower=>1e-3
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Pressure Drop Correction Factor for Unequal Baffle Spacing",
				:Hidden=>true,
				:Lower=>1e-3
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Mass Velocity in Window Zone",
				:Hidden=>true,
				:Unit=>"kg/m^2/s"
			]),
			constant ((Symbol=>Any)[
				:Brief=>"Shell Side Ji Factor",
				:Symbol=>"J_i",
				:Hidden=>true,
				:Default=>0.05
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Shell Side Jr Factor",
				:Symbol=>"J_r",
				:Hidden=>true,
				:Lower=>10e-6
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Shell Side Jl Factor",
				:Symbol=>"J_l",
				:Hidden=>true,
				:Lower=>10e-6
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Shell Side Jb Factor",
				:Symbol=>"J_b",
				:Hidden=>true,
				:Lower=>10e-6
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Shell Side Jc Factor",
				:Symbol=>"J_c",
				:Hidden=>true,
				:Lower=>10e-6
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Shell Side Js Factor",
				:Symbol=>"J_s",
				:Hidden=>true,
				:Lower=>10e-6
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Shell Side Jtotal Factor",
				:Symbol=>"J_{total}",
				:Hidden=>true,
				:Lower=>10e-6
			]),
			area ((Symbol=>Any)[
				:Brief=>"Shell Side Cross Flow Area",
				:Symbol=>"S_m",
				:Hidden=>true,
				:Default=>0.05,
				:Lower=>10e-6
			]),
			DanaPlugin ((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of Components"
			]),
			fill(molweight ((Symbol=>Any)[
				:Brief=>"Component Mol Weight"
			]),(NComp)),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Tube Side Flow Regime ",
				:Valid=>["laminar","transition","turbulent"],
				:Default=>"laminar"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Shell Side Flow Regime ",
				:Valid=>["deep laminar","laminar","turbulent"],
				:Default=>"deep laminar"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Shell Side Flow Regime Range for Correction Factor",
				:Valid=>["range1","range2","range3", "range4","range5"],
				:Default=>"range1"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Flag for Fluid Alocation ",
				:Valid=>["shell","tubes"],
				:Default=>"shell"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Tube Heat Transfer Correlation in Laminar Flow",
				:Valid=>["Hausen","Schlunder"],
				:Default=>"Hausen"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Tube Heat Transfer Correlation in Transition Flow",
				:Valid=>["Gnielinski","ESDU"],
				:Default=>"Gnielinski"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Tube Heat Transfer Correlation in Turbulent Flow",
				:Valid=>["Petukhov","SiederTate"],
				:Default=>"Petukhov"
			]),
			constant ((Symbol=>Any)[
				:Brief=>"Pi Number",
				:Hidden=>true,
				:Default=>3.14159265,
				:Symbol=>"\\pi"
			]),
			area ((Symbol=>Any)[
				:Brief=>"Shell Outlet Nozzle Area",
				:Hidden=>true,
				:Lower=>1E-6 ,
				:Symbol=>"A_{nozzle\\_out }^{shell}"
			]),
			area ((Symbol=>Any)[
				:Brief=>"Shell Inlet Nozzle Area",
				:Hidden=>true,
				:Lower=>1E-6 ,
				:Symbol=>"A_{nozzle\\_in }^{shell}"
			]),
			area ((Symbol=>Any)[
				:Brief=>"Shell Outlet Escape Area Under Nozzle",
				:Hidden=>true,
				:Lower=>1E-6 ,
				:Symbol=>"Aescape_{nozzle\\_out }^{shell}"
			]),
			area ((Symbol=>Any)[
				:Brief=>"Shell Inlet Escape Area Under Nozzle",
				:Hidden=>true,
				:Lower=>1E-6 ,
				:Symbol=>"Aescape_{nozzle\\_in }^{shell}"
			]),
			area ((Symbol=>Any)[
				:Brief=>"Tube Outlet Nozzle Area",
				:Hidden=>true,
				:Lower=>1E-6 ,
				:Symbol=>"A_{nozzle\\_out }^{tube}"
			]),
			area ((Symbol=>Any)[
				:Brief=>"Tube Inlet Nozzle Area",
				:Hidden=>true,
				:Lower=>1E-6 ,
				:Symbol=>"A_{nozzle\\_in }^{tube}"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Tube Inlet Nozzle Pressure Loss Coeff",
				:Hidden=>true,
				:Default=>1.1,
				:Symbol=>"K_{in }^{tube}"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Tube Outlet Nozzle Pressure Loss Coeff",
				:Hidden=>true,
				:Default=>0.7,
				:Symbol=>"K_{out }^{tube}"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Baffle cut angle in degrees",
				:Symbol=>"\\theta _{ds}",
				:Hidden=>true
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Baffle cut angle relative to the centerline in degrees",
				:Symbol=>"\\theta _{ctl}",
				:Hidden=>true
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Fraction of number of tubes in baffle window",
				:Symbol=>"F _{tw}",
				:Hidden=>true
			]),
			area ((Symbol=>Any)[
				:Brief=>"Shell to baffle leakage area",
				:Symbol=>"S _{cd}",
				:Hidden=>true
			]),
			area ((Symbol=>Any)[
				:Brief=>"Tube to baffle hole leakage area",
				:Symbol=>"S _{td}",
				:Hidden=>true
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Ratio of the shell to baffle leakage area",
				:Symbol=>"R_s",
				:Hidden=>true
			]),
			length ((Symbol=>Any)[
				:Brief=>"Hydraulic diameter of the baffle window",
				:Symbol=>"D _w",
				:Hidden=>true
			]),
			[
				:(Shell.Properties.Average.T = 0.5*InletShell.T + 0.5*OutletShell.T),
				:(Tubes.Properties.Average.T = 0.5*InletTube.T + 0.5*OutletTube.T),
				:(Shell.Properties.Average.P = 0.5*InletShell.P+0.5*OutletShell.P),
				:(Tubes.Properties.Average.P = 0.5*InletTube.P+0.5*OutletTube.P),
				:(Shell.Properties.Average.Mw = sum(M*InletShell.z)),
				:(Tubes.Properties.Average.Mw = sum(M*OutletTube.z)),
				:(Tubes.Properties.Average.Cp = PP.LiquidCp(Tubes.Properties.Average.T,Tubes.Properties.Average.P,OutletTube.z)),
				:(Tubes.Properties.Average.rho = PP.LiquidDensity(Tubes.Properties.Average.T,Tubes.Properties.Average.P,OutletTube.z)),
				:(Tubes.Properties.Inlet.rho = PP.LiquidDensity(OutletTube.T,OutletTube.P,OutletTube.z)),
				:(Tubes.Properties.Outlet.rho = PP.LiquidDensity(OutletTube.T,OutletTube.P,OutletTube.z)),
				:(Tubes.Properties.Average.Mu = PP.LiquidViscosity(Tubes.Properties.Average.T,Tubes.Properties.Average.P,OutletTube.z)),
				:(Tubes.Properties.Average.K = PP.LiquidThermalConductivity(Tubes.Properties.Average.T,Tubes.Properties.Average.P,OutletTube.z)),
				:(Tubes.Properties.Wall.Mu = PP.LiquidViscosity(Tubes.Properties.Wall.Twall,Tubes.Properties.Average.P,OutletTube.z)),
				:(Tubes.Properties.Average.Cp = PP.VapourCp(Tubes.Properties.Average.T,Tubes.Properties.Average.P,OutletTube.z)),
				:(Tubes.Properties.Average.rho = PP.VapourDensity(Tubes.Properties.Average.T,Tubes.Properties.Average.P,OutletTube.z)),
				:(Tubes.Properties.Inlet.rho = PP.VapourDensity(OutletTube.T,OutletTube.P,OutletTube.z)),
				:(Tubes.Properties.Outlet.rho = PP.VapourDensity(OutletTube.T,OutletTube.P,OutletTube.z)),
				:(Tubes.Properties.Average.Mu = PP.VapourViscosity(Tubes.Properties.Average.T,Tubes.Properties.Average.P,OutletTube.z)),
				:(Tubes.Properties.Average.K = PP.VapourThermalConductivity(Tubes.Properties.Average.T,Tubes.Properties.Average.P,OutletTube.z)),
				:(Tubes.Properties.Wall.Mu = PP.VapourViscosity(Tubes.Properties.Wall.Twall,Tubes.Properties.Average.P,OutletTube.z)),
				:(Shell.Properties.Average.Cp = PP.LiquidCp(Shell.Properties.Average.T,Shell.Properties.Average.P,InletShell.z)),
				:(Shell.Properties.Average.rho = PP.LiquidDensity(Shell.Properties.Average.T,Shell.Properties.Average.P,InletShell.z)),
				:(Shell.Properties.Inlet.rho = PP.LiquidDensity(InletShell.T,InletShell.P,InletShell.z)),
				:(Shell.Properties.Outlet.rho = PP.LiquidDensity(OutletShell.T,OutletShell.P,OutletShell.z)),
				:(Shell.Properties.Average.Mu = PP.LiquidViscosity(Shell.Properties.Average.T,Shell.Properties.Average.P,InletShell.z)),
				:(Shell.Properties.Average.K = PP.LiquidThermalConductivity(Shell.Properties.Average.T,Shell.Properties.Average.P,InletShell.z)),
				:(Shell.Properties.Wall.Mu = PP.LiquidViscosity(Shell.Properties.Wall.Twall,Shell.Properties.Average.P,InletShell.z)),
				:(Shell.Properties.Average.Cp = PP.VapourCp(Shell.Properties.Average.T,Shell.Properties.Average.P,InletShell.z)),
				:(Shell.Properties.Average.rho = PP.VapourDensity(Shell.Properties.Average.T,Shell.Properties.Average.P,InletShell.z)),
				:(Shell.Properties.Inlet.rho = PP.VapourDensity(InletShell.T,InletShell.P,InletShell.z)),
				:(Shell.Properties.Outlet.rho = PP.VapourDensity(OutletShell.T,OutletShell.P,OutletShell.z)),
				:(Shell.Properties.Average.Mu = PP.VapourViscosity(Shell.Properties.Average.T,Shell.Properties.Average.P,InletShell.z)),
				:(Shell.Properties.Average.K = PP.VapourThermalConductivity(Shell.Properties.Average.T,Shell.Properties.Average.P,InletShell.z)),
				:(Shell.Properties.Wall.Mu = PP.VapourViscosity(Shell.Properties.Wall.Twall,Shell.Properties.Average.P,InletShell.z)),
				:(Details.Q = InletShell.F*(InletShell.h-OutletShell.h)),
				:(Details.Q =-InletTube.F*(InletTube.h-OutletTube.h)),
				:(Details.Q = InletTube.F*(InletTube.h-OutletTube.h)),
				:(Details.Q =-InletShell.F*(InletShell.h-OutletShell.h)),
				:(Tubes.Properties.Inlet.Fw = sum(M*InletTube.z)*InletTube.F),
				:(Tubes.Properties.Outlet.Fw = sum(M*OutletTube.z)*OutletTube.F),
				:(Shell.Properties.Inlet.Fw = sum(M*InletShell.z)*InletShell.F),
				:(Shell.Properties.Outlet.Fw = sum(M*OutletShell.z)*OutletShell.F),
				:(OutletShell.F = InletShell.F),
				:(OutletTube.F = InletTube.F),
				:(OutletShell.z=InletShell.z),
				:(OutletTube.z=InletTube.z),
				:(Jc = 0.55+0.72*(1-2*Ftw)),
				:(Jl = 0.44*(1-Rs)+(1-0.44*(1-Rs))*exp(-2.2*(Scd + Std)/Sm)),
				:(Jtotal = Jc*Jl*Jb*Jr*Js),
				:(mw = Shell.Properties.Inlet.Fw/sqrt(abs(Sm*abs((Pi*Shell.ShellID*Shell.ShellID*((Ods/360)-sin(Ods*Pi/180)/(2*Pi))/4)-(Tubes.NumberOfTubes*Pi*Tubes.TubeOD*Tubes.TubeOD*Ftw/4))))),
				:(Tubes.HeatTransfer.fi = 16/Tubes.HeatTransfer.Re),
				:(Tubes.PressureDrop.FricFactor = 16/Tubes.HeatTransfer.Re),
				:(Tubes.HeatTransfer.Nu = 3.665 + ((0.19*((Tubes.TubeID/Tubes.TubeLength)*Tubes.HeatTransfer.Re*Tubes.HeatTransfer.PR)^0.8)/(1+0.117*((Tubes.TubeID/Tubes.TubeLength)*Tubes.HeatTransfer.Re*Tubes.HeatTransfer.PR)^0.467))),
				:(Tubes.HeatTransfer.Nu = (49.027896+4.173281*Tubes.HeatTransfer.Re*Tubes.HeatTransfer.PR*(Tubes.TubeID/Tubes.TubeLength))^(1/3)),
				:(Tubes.HeatTransfer.fi = 1/(0.79*ln(Tubes.HeatTransfer.Re)-1.64)^2),
				:(Tubes.PressureDrop.FricFactor = 0.0122),
				:(Tubes.HeatTransfer.Nu*(1+(12.7*sqrt(0.125*Tubes.HeatTransfer.fi)*((Tubes.HeatTransfer.PR)^(2/3) -1))) = 0.125*Tubes.HeatTransfer.fi*(Tubes.HeatTransfer.Re-1000)*Tubes.HeatTransfer.PR),
				:(Tubes.HeatTransfer.Nu =1),
				:(Tubes.HeatTransfer.fi = 1/(1.82*log(Tubes.HeatTransfer.Re)-1.64)^2),
				:(Tubes.PressureDrop.FricFactor = 0.0035 + 0.264*Tubes.HeatTransfer.Re^(-0.42)),
				:(Tubes.HeatTransfer.Nu*(1.07+(12.7*sqrt(0.125*Tubes.HeatTransfer.fi)*((Tubes.HeatTransfer.PR)^(2/3) -1))) = 0.125*Tubes.HeatTransfer.fi*Tubes.HeatTransfer.Re*Tubes.HeatTransfer.PR),
				:(Tubes.HeatTransfer.Nu = 0.027*(Tubes.HeatTransfer.PR)^(1/3)*(Tubes.HeatTransfer.Re)^(4/5)),
				:(Sm= Baffles.Central_Spacing*(Clearances.BundleToShell+((Shell.ShellID-Clearances.BundleToShell-Tubes.TubeOD)/Tubes.TubePitch)*(Tubes.TubePitch-Tubes.TubeOD))),
				:(Nc = Shell.ShellID*(1-0.02*Baffles.BaffleCut)/(0.866*Tubes.TubePitch)),
				:(Ncw = 0.8*(Shell.ShellID*0.01*Baffles.BaffleCut-(Clearances.BundleToShell + Tubes.TubeOD)*0.5)/(0.866*Tubes.TubePitch)),
				:(a = 1.45/(1+0.14*Shell.HeatTransfer.Re^0.519)),
				:(b=7/(1+0.14*Shell.HeatTransfer.Re^0.5)),
				:(Rss = Clearances.SealStrip/(Shell.ShellID*(1-0.02*Baffles.BaffleCut)/(0.866*Tubes.TubePitch))),
				:(Shell.PressureDrop.Ideal= 2*Shell.PressureDrop.FricFactor*(Shell.ShellID*(1-0.02*Baffles.BaffleCut)/(0.866*Tubes.TubePitch))*(Shell.Properties.Inlet.Fw/Sm)^2/(Shell.Properties.Average.rho*Shell.HeatTransfer.Phi)),
				:(Shell.PressureDrop.EndZones = Shell.PressureDrop.Ideal*(1+ (Ncw/(Shell.ShellID*(1-0.02*Baffles.BaffleCut)/(0.866*Tubes.TubePitch))))*Rb*Rspd),
				:(Ji =1.40*((1.33*Tubes.TubeOD/Tubes.TubePitch)^a)*Shell.HeatTransfer.Re^0.667),
				:(Shell.PressureDrop.FricFactor=48*((1.33*Tubes.TubeOD/Tubes.TubePitch)^b)*Shell.HeatTransfer.Re^-1),
				:(Ji =1.36*((1.33*Tubes.TubeOD/Tubes.TubePitch)^a)*Shell.HeatTransfer.Re^-0.657),
				:(Shell.PressureDrop.FricFactor=45.10*((1.33*Tubes.TubeOD/Tubes.TubePitch)^b)*Shell.HeatTransfer.Re^-0.973),
				:(Ji =0.593*((1.33*Tubes.TubeOD/Tubes.TubePitch)^a)*Shell.HeatTransfer.Re^-0.477),
				:(Shell.PressureDrop.FricFactor=4.570*((1.33*Tubes.TubeOD/Tubes.TubePitch)^b)*Shell.HeatTransfer.Re^-0.476),
				:(Ji =0.321*((1.33*Tubes.TubeOD/Tubes.TubePitch)^a)*Shell.HeatTransfer.Re^-0.388),
				:(Shell.PressureDrop.FricFactor=0.486*((1.33*Tubes.TubeOD/Tubes.TubePitch)^b)*Shell.HeatTransfer.Re^-0.152),
				:(Ji =0.321*((1.33*Tubes.TubeOD/Tubes.TubePitch)^a)*Shell.HeatTransfer.Re^-0.388),
				:(Shell.PressureDrop.FricFactor=0.372*((1.33*Tubes.TubeOD/Tubes.TubePitch)^b)*Shell.HeatTransfer.Re^-0.123),
				:(Sm= Baffles.Central_Spacing*(Clearances.BundleToShell+((Shell.ShellID-Clearances.BundleToShell-Tubes.TubeOD)/(0.707*Tubes.TubePitch))*(Tubes.TubePitch-Tubes.TubeOD))),
				:(Nc = Shell.ShellID*(1-0.02*Baffles.BaffleCut)/(0.707*Tubes.TubePitch)),
				:(Ncw = 0.8*(Shell.ShellID*0.01*Baffles.BaffleCut-(Clearances.BundleToShell + Tubes.TubeOD)*0.5)/(0.707*Tubes.TubePitch)),
				:(a = 1.930/(1+0.14*Shell.HeatTransfer.Re^0.500)),
				:(b=6.59/(1+0.14*Shell.HeatTransfer.Re^0.52)),
				:(Rss = Clearances.SealStrip/(Shell.ShellID*(1-0.02*Baffles.BaffleCut)/(0.707*Tubes.TubePitch))),
				:(Shell.PressureDrop.Ideal= 2*Shell.PressureDrop.FricFactor*(Shell.ShellID*(1-0.02*Baffles.BaffleCut)/(0.707*Tubes.TubePitch))*(Shell.Properties.Inlet.Fw/Sm)^2/(Shell.Properties.Average.rho*Shell.HeatTransfer.Phi)),
				:(Shell.PressureDrop.EndZones = Shell.PressureDrop.Ideal*(1+ (Ncw/(Shell.ShellID*(1-0.02*Baffles.BaffleCut)/(0.707*Tubes.TubePitch))))*Rb*Rspd),
				:(Ji =1.550*((1.33*Tubes.TubeOD/Tubes.TubePitch)^a)*Shell.HeatTransfer.Re^0.667),
				:(Shell.PressureDrop.FricFactor=32*((1.33*Tubes.TubeOD/Tubes.TubePitch)^b)*Shell.HeatTransfer.Re^-1),
				:(Ji =0.498*((1.33*Tubes.TubeOD/Tubes.TubePitch)^a)*Shell.HeatTransfer.Re^0.656),
				:(Shell.PressureDrop.FricFactor=26.20*((1.33*Tubes.TubeOD/Tubes.TubePitch)^b)*Shell.HeatTransfer.Re^-0.913),
				:(Ji =0.730*((1.33*Tubes.TubeOD/Tubes.TubePitch)^a)*Shell.HeatTransfer.Re^0.500),
				:(Shell.PressureDrop.FricFactor=3.50*((1.33*Tubes.TubeOD/Tubes.TubePitch)^b)*Shell.HeatTransfer.Re^-0.476),
				:(Ji =0.370*((1.33*Tubes.TubeOD/Tubes.TubePitch)^a)*Shell.HeatTransfer.Re^-0.396),
				:(Shell.PressureDrop.FricFactor=0.333*((1.33*Tubes.TubeOD/Tubes.TubePitch)^b)*Shell.HeatTransfer.Re^-0.136),
				:(Ji =0.370*((1.33*Tubes.TubeOD/Tubes.TubePitch)^a)*Shell.HeatTransfer.Re^-0.396),
				:(Shell.PressureDrop.FricFactor=0.303*((1.33*Tubes.TubeOD/Tubes.TubePitch)^b)*Shell.HeatTransfer.Re^-0.126),
				:(Sm= Baffles.Central_Spacing*(Clearances.BundleToShell+((Shell.ShellID-Clearances.BundleToShell-Tubes.TubeOD)/Tubes.TubePitch)*(Tubes.TubePitch-Tubes.TubeOD))),
				:(Nc = Shell.ShellID*(1-0.02*Baffles.BaffleCut)/Tubes.TubePitch),
				:(Ncw = 0.8*(Shell.ShellID*0.01*Baffles.BaffleCut-(Clearances.BundleToShell + Tubes.TubeOD)*0.5)/Tubes.TubePitch),
				:(a = 1.187/(1+0.14*Shell.HeatTransfer.Re^0.370)),
				:(b=6.30/(1+0.14*Shell.HeatTransfer.Re^0.38)),
				:(Rss = Clearances.SealStrip/(Shell.ShellID*(1-0.02*Baffles.BaffleCut)/Tubes.TubePitch)),
				:(Shell.PressureDrop.Ideal= 2*Shell.PressureDrop.FricFactor*(Shell.ShellID*(1-0.02*Baffles.BaffleCut)/Tubes.TubePitch)*(Shell.Properties.Inlet.Fw/Sm)^2/(Shell.Properties.Average.rho*Shell.HeatTransfer.Phi)),
				:(Shell.PressureDrop.EndZones = Shell.PressureDrop.Ideal*(1+ (Ncw/(Shell.ShellID*(1-0.02*Baffles.BaffleCut)/Tubes.TubePitch)))*Rb*Rspd),
				:(Ji =0.970*((1.33*Tubes.TubeOD/Tubes.TubePitch)^a)*Shell.HeatTransfer.Re^-0.667),
				:(Shell.PressureDrop.FricFactor=35*((1.33*Tubes.TubeOD/Tubes.TubePitch)^b)*Shell.HeatTransfer.Re^-1),
				:(Ji =0.900*((1.33*Tubes.TubeOD/Tubes.TubePitch)^a)*Shell.HeatTransfer.Re^-0.631),
				:(Shell.PressureDrop.FricFactor=32.10*((1.33*Tubes.TubeOD/Tubes.TubePitch)^b)*Shell.HeatTransfer.Re^-0.963),
				:(Ji =0.408*((1.33*Tubes.TubeOD/Tubes.TubePitch)^a)*Shell.HeatTransfer.Re^-0.460),
				:(Shell.PressureDrop.FricFactor=6.090*((1.33*Tubes.TubeOD/Tubes.TubePitch)^b)*Shell.HeatTransfer.Re^-0.602),
				:(Ji =0.107*((1.33*Tubes.TubeOD/Tubes.TubePitch)^a)*Shell.HeatTransfer.Re^-0.266),
				:(Shell.PressureDrop.FricFactor=0.0815*((1.33*Tubes.TubeOD/Tubes.TubePitch)^b)*Shell.HeatTransfer.Re^0.022),
				:(Ji =0.370*((1.33*Tubes.TubeOD/Tubes.TubePitch)^a)*Shell.HeatTransfer.Re^-0.395),
				:(Shell.PressureDrop.FricFactor=0.391*((1.33*Tubes.TubeOD/Tubes.TubePitch)^b)*Shell.HeatTransfer.Re^-0.148),
				:(Jr = (10/((Nc +Ncw)*(Baffles.NumberOfBaffles+1)))^0.18),
				:(Js = (Baffles.NumberOfBaffles-1+(Baffles.Inlet_Spacing/Baffles.Central_Spacing)^0.7 + (Baffles.Outlet_Spacing/Baffles.Central_Spacing)^0.7)/(Baffles.NumberOfBaffles-1+(Baffles.Inlet_Spacing/Baffles.Central_Spacing) + (Baffles.Outlet_Spacing/Baffles.Central_Spacing))),
				:(Jb = exp(-1.35*( Clearances.BundleToShell+ Tubes.TubeOD)*Baffles.Central_Spacing/Sm*(1-(2*(Clearances.SealStrip/Nc)^(1/3))))),
				:(Rb = exp(-4.7*((Clearances.BundleToShell + Tubes.TubeOD)*Baffles.Central_Spacing/Sm)*(1-(2*Rss)^(1/3)))),
				:(Rspd = (Baffles.Central_Spacing/Baffles.Outlet_Spacing) + (Baffles.Central_Spacing/Baffles.Inlet_Spacing)),
				:(Shell.PressureDrop.Window = Baffles.NumberOfBaffles*((26/Shell.Properties.Average.rho)*mw*Shell.Properties.Average.Mu*(Ncw/(Tubes.TubePitch-Tubes.TubeOD)+ Baffles.Central_Spacing/(Dw*Dw))+ 0.5*mw*mw/Shell.Properties.Average.rho)*exp(-1.33*(1+Rs)*((Scd + Std)/Sm)^(-0.15*(1+Rs) + 0.8))),
				:(Jr = (10/((Nc +Ncw)*(Baffles.NumberOfBaffles+1)))^0.18 + (0.25-0.0125*Shell.HeatTransfer.Re)*((10/((Nc +Ncw)*(Baffles.NumberOfBaffles+1)))^0.18 - 1)),
				:(Js = (Baffles.NumberOfBaffles-1+(Baffles.Inlet_Spacing/Baffles.Central_Spacing)^0.7 + (Baffles.Outlet_Spacing/Baffles.Central_Spacing)^0.7)/(Baffles.NumberOfBaffles-1+(Baffles.Inlet_Spacing/Baffles.Central_Spacing) + (Baffles.Outlet_Spacing/Baffles.Central_Spacing))),
				:(Jb = exp(-1.35*( Clearances.BundleToShell+ Tubes.TubeOD)*Baffles.Central_Spacing/Sm*(1-(2*(Clearances.SealStrip/Nc)^(1/3))))),
				:(Rb = exp(-4.7*((Clearances.BundleToShell+ Tubes.TubeOD)*Baffles.Central_Spacing/Sm)*(1-(2*Rss)^(1/3)))),
				:(Rspd = (Baffles.Central_Spacing/Baffles.Outlet_Spacing) + (Baffles.Central_Spacing/Baffles.Inlet_Spacing)),
				:(Shell.PressureDrop.Window = Baffles.NumberOfBaffles*((26/Shell.Properties.Average.rho)*mw*Shell.Properties.Average.Mu*(Ncw/(Tubes.TubePitch-Tubes.TubeOD)+ Baffles.Central_Spacing/(Dw*Dw))+ 0.5*mw*mw/Shell.Properties.Average.rho)*exp(-1.33*(1+Rs)*((Scd + Std)/Sm)^(-0.15*(1+Rs) + 0.8))),
				:(Jr = 1),
				:(Js = (Baffles.NumberOfBaffles-1+(Baffles.Inlet_Spacing/Baffles.Central_Spacing)^0.4 + (Baffles.Outlet_Spacing/Baffles.Central_Spacing)^0.4)/(Baffles.NumberOfBaffles-1+(Baffles.Inlet_Spacing/Baffles.Central_Spacing) + (Baffles.Outlet_Spacing/Baffles.Central_Spacing))),
				:(Jb = exp(-1.25*( Clearances.BundleToShell+ Tubes.TubeOD)*Baffles.Central_Spacing/Sm*(1-(2*(Clearances.SealStrip/Nc)^(1/3))))),
				:(Rb = exp(-3.7*((Clearances.BundleToShell + Tubes.TubeOD)*Baffles.Central_Spacing/Sm)*(1-(2*Rss)^(1/3)))),
				:(Rspd = (Baffles.Central_Spacing/Baffles.Outlet_Spacing)^1.8 + (Baffles.Central_Spacing/Baffles.Inlet_Spacing)^1.8),
				:(Shell.PressureDrop.Window = Baffles.NumberOfBaffles*((2+0.6*Ncw)*0.5*mw*mw/Shell.Properties.Average.rho)*exp(-1.33*(1+Rs)*((Scd + Std)/Sm)^(-0.15*(1+Rs) + 0.8))),
				:(Shell.PressureDrop.CrossFlow= Shell.PressureDrop.Ideal*Rb*(Baffles.NumberOfBaffles-1)*exp(-1.33*(1+Rs)*((Scd + Std)/Sm)^(-0.15*(1+Rs) + 0.8))),
				:(Shell.HeatTransfer.Phi = (Shell.Properties.Average.Mu/Shell.Properties.Wall.Mu)^0.14),
				:(Tubes.HeatTransfer.Phi = (Tubes.Properties.Average.Mu/Tubes.Properties.Wall.Mu)^0.14),
				:(Shell.PressureDrop.RVsquare_in = Shell.Properties.Inlet.rho*(Shell.PressureDrop.Vnozzle_in)^2),
				:(Shell.PressureDrop.RVsquare_out = Shell.Properties.Outlet.rho*(Shell.PressureDrop.Vnozzle_out)^2),
				:(Tubes.PressureDrop.TubeFriction = 2*Tubes.PressureDrop.FricFactor*Tubes.TubeLength*Tubes.Properties.Average.rho*(Tubes.HeatTransfer.Vtube^2)*Tubes.Tubepasses/(Tubes.TubeID*Tubes.HeatTransfer.Phi)),
				:(Tubes.PressureDrop.InletNozzle = 0.5*Kinlet_Tube*Tubes.Properties.Inlet.rho*Tubes.PressureDrop.Vnozzle_in^2),
				:(Tubes.PressureDrop.Vnozzle_in = Tubes.Properties.Inlet.Fw/(Tubes.Properties.Inlet.rho*Ainozzle_Tube)),
				:(Tubes.PressureDrop.OutletNozzle = 0.5*Koutlet_Tube*Tubes.Properties.Outlet.rho*Tubes.PressureDrop.Vnozzle_out^2),
				:(Tubes.PressureDrop.Vnozzle_out = Tubes.Properties.Inlet.Fw/(Tubes.Properties.Outlet.rho*Aonozzle_Tube)),
				:(Shell.PressureDrop.InletNozzle = (0.5*Shell.Properties.Inlet.Fw^2/Shell.Properties.Inlet.rho)*((1/Ainozzle_Shell^2)+(1/Aeinozzle_Shell^2))),
				:(Shell.PressureDrop.Vnozzle_in = Shell.Properties.Inlet.Fw/(Shell.Properties.Inlet.rho*Ainozzle_Shell)),
				:(Shell.PressureDrop.OutletNozzle = (0.5*Shell.Properties.Outlet.Fw^2/Shell.Properties.Outlet.rho)*((1/Ainozzle_Shell^2)+(1/Aeinozzle_Shell^2))),
				:(Shell.PressureDrop.Vnozzle_out = Shell.Properties.Outlet.Fw/(Shell.Properties.Outlet.rho*Aonozzle_Shell)),
				:(OutletShell.P = InletShell.P - Shell.PressureDrop.Total),
				:(OutletTube.P = InletTube.P - Tubes.PressureDrop.Total),
				:(Shell.Properties.Wall.Twall = (Shell.Properties.Average.T+Tubes.Properties.Average.T)/2),
				:(Tubes.Properties.Wall.Twall = (Shell.Properties.Average.T+Tubes.Properties.Average.T)/2),
				:(Tubes.HeatTransfer.Vtube = Tubes.Properties.Inlet.Fw*Tubes.Tubepasses/((Pi*Tubes.TubeID*Tubes.TubeID/4)*Tubes.Properties.Average.rho*Tubes.NumberOfTubes)),
				:(Tubes.HeatTransfer.Re = (Tubes.Properties.Average.rho*Tubes.HeatTransfer.Vtube*Tubes.TubeID)/Tubes.Properties.Average.Mu),
				:(Tubes.HeatTransfer.PR = ((Tubes.Properties.Average.Cp/Tubes.Properties.Average.Mw)*Tubes.Properties.Average.Mu)/Tubes.Properties.Average.K),
				:(Tubes.HeatTransfer.htube= (Tubes.HeatTransfer.Nu*Tubes.Properties.Average.K/Tubes.TubeID)*Tubes.HeatTransfer.Phi),
				:(Shell.HeatTransfer.PR = ((Shell.Properties.Average.Cp/Shell.Properties.Average.Mw)*Shell.Properties.Average.Mu)/Shell.Properties.Average.K),
				:(Details.Ud=1/(Tubes.TubeOD/(Tubes.HeatTransfer.htube*Tubes.TubeID)+Shell.Fouling+Tubes.Fouling*(Tubes.TubeOD/Tubes.TubeID)+(Tubes.TubeOD*ln(Tubes.TubeOD/Tubes.TubeID)/(2*Tubes.Kwall))+(1/(Shell.HeatTransfer.hshell)))),
				:(Details.Uc=1/(Tubes.TubeOD/(Tubes.HeatTransfer.htube*Tubes.TubeID)+(Tubes.TubeOD*ln(Tubes.TubeOD/Tubes.TubeID)/(2*Tubes.Kwall))+(1/(Shell.HeatTransfer.hshell)))),
				:(Details.A=Pi*Tubes.TubeOD*Tubes.NumberOfTubes*Tubes.TubeLength),
				:(Tubes.TubeLength = Baffles.Inlet_Spacing+Baffles.Outlet_Spacing+Baffles.Central_Spacing*(Baffles.NumberOfBaffles-1)),
				:(Shell.HeatTransfer.Re = (Tubes.TubeOD*Shell.Properties.Inlet.Fw/Sm)/Shell.Properties.Average.Mu),
				:(Shell.HeatTransfer.hshell = Ji*(Shell.Properties.Average.Cp/Shell.Properties.Average.Mw)*(Shell.Properties.Inlet.Fw/Sm)*(Shell.HeatTransfer.PR^(-2/3))*Jtotal*Shell.HeatTransfer.Phi),
			],
			[
				"Shell Stream Average Temperature","Tube Stream Average Temperature","Shell Stream Average Pressure","Tube Stream Average Pressure","Shell Stream Average Molecular Weight","Tube Stream Average Molecular Weight","Tube Stream Average Heat Capacity","Tube Stream Average Mass Density","Tube Stream Inlet Mass Density","Tube Stream Outlet Mass Density","TubeStream Average Viscosity","Tube Stream Average Conductivity","Tube Stream Viscosity at Wall Temperature","Tube Stream Average Heat Capacity","Tube Stream Average Mass Density","Tube Stream Inlet Mass Density","Tube Stream Outlet Mass Density","Tube Stream Average Viscosity ","Tube Stream Average Conductivity ","Tube Stream Viscosity at Wall Temperature","Shell Stream Average Heat Capacity","Shell Stream Average Mass Density","ShellStream Inlet Mass Density","Shell Stream Outlet Mass Density","Shell Stream Average Viscosity","Shell Stream Average Conductivity","ShellStream Viscosity  at Wall Temperature","Shell Stream Average Heat Capacity","Shell Stream Average Mass Density","Shell Stream Inlet Mass Density","Shell Stream Outlet Mass Density","Shell Stream Average Viscosity","Shell Stream Average Conductivity","Shell Stream Viscosity at Wall Temperature","Energy Balance Hot Stream","Energy Balance Cold Stream","Energy Balance Hot Stream","Energy Balance Cold Stream","Flow Mass Inlet Tube Stream","Flow Mass Outlet Tube Stream","Flow Mass Inlet Shell Stream","Flow Mass Outlet Shell Stream","Molar Balance Shell Stream","Molar Balance Tube Stream","Shell	Stream Molar Fraction Constraint","Tube Stream Molar Fraction Constraint","Jc Factor","Jl Factor","Total J Factor","Mass Velocity in Window Zone","Friction Factor for heat Transfer: Not Necessary in Laminar Correlation - Use any one equation that you want","Friction Factor for Pressure Drop in Laminar Flow","Nusselt Number in Laminar Flow - Hausen Equation","Nusselt Number in Laminar Flow - Schlunder Equation","Friction Factor for heat Transfer : for use in Gnielinski Equation","Friction Factor for Pressure Drop in Transition Flow","Nusselt Number in Transition Flow - Gnielinski Equation","Nusselt Number in Transition Flow - ESDU Equation","Friction Factor for heat Transfer : for use in Petukhov Equation","Friction Factor for Pressure Drop in Turbulent Flow","Nusselt Number in Turbulent Flow - Petukhov Equation","Nusselt Number in Transition Flow - Sieder Tate Equation","Shell Side Cross Flow Area","Number of Tube rows Crossed in one Crossflow Section","Number of Effective Crossflow rows in Each Window","Variable for calculating Ji heat transfer correction Factor","Variable for calculating Shell Side Pressure Drop Friction Factor","Correction Factor for Pressure Drop","Ideal Shell Side Pressure Drop","Shell Pressure End Zones","Ji Factor","Shell Side Pressure Drop Friction Factor","Ji Factor","Shell Side Pressure Drop Friction Factor","Ji Factor","Shell Side Pressure Drop Friction Factor","Ji Factor","Shell Side Pressure Drop Friction Factor","Ji Factor","Shell Side Pressure Drop Friction Factor","Shell Side Cross Flow Area","Number of Tube rows Crossed in one Crossflow Section","Number of Effective Crossflow rows in Each Window","Variable for calculating Ji heat transfer correction Factor","Variable for calculating Shell Side Pressure Drop Friction Factor","Correction Factor for Pressure Drop","Ideal Shell Side Pressure Drop","Shell Pressure End Zones","Ji Factor","Shell Side Pressure Drop Friction Factor","Ji Factor","Shell Side Pressure Drop Friction Factor","Ji Factor","Shell Side Pressure Drop Friction Factor","Ji Factor","Shell Side Pressure Drop Friction Factor","Ji Factor","Shell Side Pressure Drop Friction Factor","Shell Side Cross Flow Area","Number of Tube rows Crossed in one Crossflow Section","Number of Effective Crossflow rows in Each Window","Variable for calculating Ji heat transfer correction Factor","Variable for calculating Shell Side Pressure Drop Friction Factor","Correction Factor for Pressure Drop","Ideal Shell Side Pressure Drop","Shell Pressure End Zones","Ji Factor","Shell Side Pressure Drop Friction Factor","Ji Factor","Shell Side Pressure Drop Friction Factor","Ji Factor","Shell Side Pressure Drop Friction Factor","Ji Factor","Shell Side Pressure Drop Friction Factor","Ji Factor","Shell Side Pressure Drop Friction Factor","Jr Factor","Js Factor","Jb Factor","ByPass Correction Factor for Pressure Drop","Pressure Drop Correction Factor for Unequal Baffle Spacing","Shell Pressure Drop Baffle Window","Jr Factor","Js Factor","Jb Factor","ByPass Correction Factor for Pressure Drop","Pressure Drop Correction Factor for Unequal Baffle Spacing","Shell Pressure Drop Baffle Window","Jr Factor","Js Factor","Jb Factor","ByPass Correction Factor for Pressure Drop","Pressure Drop Correction Factor for Unequal Baffle Spacing","Shell Pressure Drop Baffle Window","Shell Pressure Drop Cross Flow","Shell Side Phi correction","Tube Side Phi correction","Shell Side inlet Nozzle rho-V^2","Shell Side Outlet Nozzle rho-V^2","Tube Side Pressure Drop","Pressure Drop Tube Side Inlet Nozzle","Velocity Tube Side Inlet Nozzle","Pressure Drop Tube Side Outlet Nozzle","Velocity Tube Side Outlet Nozzle","Shell Pressure Drop Inlet Nozzle","Velocity Shell Side Inlet Nozzle","Shell Pressure Drop Outlet Nozzle","Velocity Shell Side Outlet Nozzle","Pressure Drop Shell Stream","Pressure Drop Tube Stream","Shell Wall Temperature","Tube Wall Temperature","Tube Side Velocity","Tube Side Reynolds Number","Tube Side Prandtl Number","Tube Side Film Coefficient","Shell Side Prandtl Number","Overall Heat Transfer Coefficient Dirty","Overall Heat Transfer Coefficient Clean","Exchange Surface Area","Baffle Spacing Constraint","Shell Side Reynolds Number","Shell Heat Transfer Coefficient",
			],
			[:HotSide,:ShellType,:Pattern,:PP,:NComp,:M,:TubeFlowRegime,:ShellFlowRegime,:ShellRange,:Side,:LaminarCorrelation,:TransitionCorrelation,:TurbulentCorrelation,:Pi,:Aonozzle_Shell,:Ainozzle_Shell,:Aeonozzle_Shell,:Aeinozzle_Shell,:Aonozzle_Tube,:Ainozzle_Tube,:Kinlet_Tube,:Koutlet_Tube,:Ods,:Octl,:Ftw,:Scd,:Std,:Rs,:Dw,],
			[:Tubes,:Shell,:Baffles,:Clearances,:InletTube,:OutletTube,:InletShell,:OutletShell,:Details,:Nc,:Ncw,:a,:b,:Rb,:Rss,:Rspd,:mw,:Ji,:Jr,:Jl,:Jb,:Jc,:Js,:Jtotal,:Sm,]
		)
	end
	HotSide::DanaSwitcher 
	ShellType::DanaSwitcher 
	Pattern::DanaSwitcher 
	Tubes::Tube_Side_Main 
	Shell::Shell_Side_Main 
	Baffles::Baffles_Main 
	Clearances::Clearances_Main 
	InletTube::stream 
	OutletTube::streamPH 
	InletShell::stream 
	OutletShell::streamPH 
	Details::Details_Main 
	Nc::DanaReal 
	Ncw::DanaReal 
	a::DanaReal 
	b::DanaReal 
	Rb::DanaReal 
	Rss::DanaReal 
	Rspd::DanaReal 
	mw::DanaReal 
	Ji::constant 
	Jr::positive 
	Jl::positive 
	Jb::positive 
	Jc::positive 
	Js::positive 
	Jtotal::positive 
	Sm::area 
	PP::DanaPlugin 
	NComp::DanaInteger 
	M::Array{molweight }
	TubeFlowRegime::DanaSwitcher 
	ShellFlowRegime::DanaSwitcher 
	ShellRange::DanaSwitcher 
	Side::DanaSwitcher 
	LaminarCorrelation::DanaSwitcher 
	TransitionCorrelation::DanaSwitcher 
	TurbulentCorrelation::DanaSwitcher 
	Pi::constant 
	Aonozzle_Shell::area 
	Ainozzle_Shell::area 
	Aeonozzle_Shell::area 
	Aeinozzle_Shell::area 
	Aonozzle_Tube::area 
	Ainozzle_Tube::area 
	Kinlet_Tube::positive 
	Koutlet_Tube::positive 
	Ods::DanaReal 
	Octl::DanaReal 
	Ftw::DanaReal 
	Scd::area 
	Std::area 
	Rs::DanaReal 
	Dw::length 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export ShellandTubesBasic
function set(in::ShellandTubesBasic)
	#"Molecular weight"
	M = PP.MolecularWeight()
	 #"Pi Number"
	Pi = 3.14159265
	 #"Baffle cut angle in degrees"
	Ods = (360/Pi)*acos(1-0.02*Baffles.BaffleCut)
	 #"Baffle cut angle relative to the centerline"
	Octl = (360/Pi)*acos((Shell.ShellID/(Shell.ShellID - Clearances.BundleToShell - Tubes.TubeOD))*(1-0.02*Baffles.BaffleCut))
	 #"Fraction of number of tubes in baffle window"
	Ftw = (Octl/360)-sin(Octl*Pi/180)/(2*Pi)
	 #"Shell to baffle leakage area"
	Scd = Pi*Shell.ShellID*Clearances.BaffleToShell *((360-Ods)/720)
	 #"Tube to baffle hole leakage area"
	Std = Pi*0.25*((Clearances.TubeToBaffle + Tubes.TubeOD)^2-Tubes.TubeOD*Tubes.TubeOD)*Tubes.NumberOfTubes*(1-Ftw)
	 #"comments"
	Rs = Scd/(Scd+Std)
	 #"comments"
	Dw = (4*abs((Pi*Shell.ShellID*Shell.ShellID*((Ods/360)-sin(Ods*Pi/180)/(2*Pi))/4)-(Tubes.NumberOfTubes*Pi*Tubes.TubeOD*Tubes.TubeOD*Ftw/4)))/(Pi*Tubes.TubeOD*Tubes.NumberOfTubes*Ftw+ Pi*Shell.ShellID*Ods/360)
	 #"Tube Side Inlet Nozzle Area"
	Ainozzle_Tube = 0.25*Pi*Tubes.InletNozzleID^2
	 #"Tube Side Outlet Nozzle Area"
	Aonozzle_Tube = 0.25*Pi*Tubes.OutletNozzleID^2
	 #"Tube Inlet Nozzle Pressure Loss Coeff"
	Kinlet_Tube = 1.1
	 #"Tube Outlet Nozzle Pressure Loss Coeff"
	Koutlet_Tube = 0.7
	 #"Shell Outlet Nozzle Area"
	Aonozzle_Shell = 0.25*Pi*Shell.OutletNozzleID^2
	 #"Shell Inlet Nozzle Area"
	Ainozzle_Shell = 0.25*Pi*Shell.InletNozzleID^2
	 #"Shell Outlet Escape Area Under Nozzle"
	Aeonozzle_Shell = Pi*Shell.OutletNozzleID*Clearances.Honozzle_Shell + 0.6*Aonozzle_Shell*(1-(Tubes.TubeOD/Tubes.TubePitch))
	 #"Shell Inlet Escape Area Under Nozzle"
	Aeinozzle_Shell = Pi*Shell.InletNozzleID*Clearances.Hinozzle_Shell + 0.6*Ainozzle_Shell*(1-(Tubes.TubeOD/Tubes.TubePitch))
	 
end
function setEquationFlow(in::ShellandTubesBasic)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
	if InletTube.v == 0 
		addEquation(7)
		addEquation(8)
		addEquation(9)
		addEquation(10)
		addEquation(11)
		addEquation(12)
		addEquation(13)
	else
		addEquation(14)
		addEquation(15)
		addEquation(16)
		addEquation(17)
		addEquation(18)
		addEquation(19)
		addEquation(20)
	end
	if InletShell.v == 0 
		addEquation(21)
		addEquation(22)
		addEquation(23)
		addEquation(24)
		addEquation(25)
		addEquation(26)
		addEquation(27)
	else
		addEquation(28)
		addEquation(29)
		addEquation(30)
		addEquation(31)
		addEquation(32)
		addEquation(33)
		addEquation(34)
	end
	let switch=Side
		if Side==InletTube.T > InletShell.T
			set(switch,"tubes")
		end
		if Side==InletTube.T < InletShell.T
			set(switch,"shell")
		end
		if switch=="shell"
			addEquation(35)
			addEquation(36)
		elseif switch=="tubes"
			addEquation(37)
			addEquation(38)
		end
	end
	addEquation(39)
	addEquation(40)
	addEquation(41)
	addEquation(42)
	addEquation(43)
	addEquation(44)
	addEquation(45)
	addEquation(46)
	addEquation(47)
	addEquation(48)
	addEquation(49)
	addEquation(50)
	let switch=TubeFlowRegime
		if TubeFlowRegime==Tubes.HeatTransfer.Re > 2300
			set(switch,"transition")
		end
		if TubeFlowRegime==Tubes.HeatTransfer.Re < 2300
			set(switch,"laminar")
		end
		if TubeFlowRegime==Tubes.HeatTransfer.Re > 10000
			set(switch,"turbulent")
		end
		if TubeFlowRegime==Tubes.HeatTransfer.Re < 10000
			set(switch,"transition")
		end
		if switch=="laminar"
			addEquation(51)
			addEquation(52)
			let switch=LaminarCorrelation
				if switch=="Hausen"
					addEquation(53)
				elseif switch=="Schlunder"
					addEquation(54)
				end
			end
		elseif switch=="transition"
			addEquation(55)
			addEquation(56)
			let switch=TransitionCorrelation
				if switch=="Gnielinski"
					addEquation(57)
				elseif switch=="ESDU"
					addEquation(58)
					#to be implemented
					
				end
			end
		elseif switch=="turbulent"
			addEquation(59)
			addEquation(60)
			let switch=TurbulentCorrelation
				if switch=="Petukhov"
					addEquation(61)
				elseif switch=="SiederTate"
					addEquation(62)
				end
			end
		end
	end
	let switch=Pattern
		if switch=="Triangle"
			addEquation(63)
			addEquation(64)
			addEquation(65)
			addEquation(66)
			addEquation(67)
			addEquation(68)
			addEquation(69)
			addEquation(70)
			let switch=ShellRange
				if ShellRange==Shell.HeatTransfer.Re > 10
					set(switch,"range2")
				end
				if ShellRange==Shell.HeatTransfer.Re > 100
					set(switch,"range3")
				end
				if ShellRange==Shell.HeatTransfer.Re > 1000
					set(switch,"range4")
				end
				if ShellRange==Shell.HeatTransfer.Re > 10000
					set(switch,"range5")
				end
				if ShellRange==Shell.HeatTransfer.Re < 10000
					set(switch,"range4")
				end
				if switch=="range1"
					addEquation(71)
					addEquation(72)
				elseif switch=="range2"
					addEquation(73)
					addEquation(74)
				elseif switch=="range3"
					addEquation(75)
					addEquation(76)
				elseif switch=="range4"
					addEquation(77)
					addEquation(78)
				elseif switch=="range5"
					addEquation(79)
					addEquation(80)
				end
			end
		elseif switch=="Rotated Square"
			addEquation(81)
			addEquation(82)
			addEquation(83)
			addEquation(84)
			addEquation(85)
			addEquation(86)
			addEquation(87)
			addEquation(88)
			let switch=ShellRange
				if ShellRange==Shell.HeatTransfer.Re > 10
					set(switch,"range2")
				end
				if ShellRange==Shell.HeatTransfer.Re > 100
					set(switch,"range3")
				end
				if ShellRange==Shell.HeatTransfer.Re > 1000
					set(switch,"range4")
				end
				if ShellRange==Shell.HeatTransfer.Re > 10000
					set(switch,"range5")
				end
				if ShellRange==Shell.HeatTransfer.Re < 10000
					set(switch,"range4")
				end
				if switch=="range1"
					addEquation(89)
					addEquation(90)
				elseif switch=="range2"
					addEquation(91)
					addEquation(92)
				elseif switch=="range3"
					addEquation(93)
					addEquation(94)
				elseif switch=="range4"
					addEquation(95)
					addEquation(96)
				elseif switch=="range5"
					addEquation(97)
					addEquation(98)
				end
			end
		elseif switch=="Square"
			addEquation(99)
			addEquation(100)
			addEquation(101)
			addEquation(102)
			addEquation(103)
			addEquation(104)
			addEquation(105)
			addEquation(106)
			let switch=ShellRange
				if ShellRange==Shell.HeatTransfer.Re > 10
					set(switch,"range2")
				end
				if ShellRange==Shell.HeatTransfer.Re > 100
					set(switch,"range3")
				end
				if ShellRange==Shell.HeatTransfer.Re > 1000
					set(switch,"range4")
				end
				if ShellRange==Shell.HeatTransfer.Re > 10000
					set(switch,"range5")
				end
				if ShellRange==Shell.HeatTransfer.Re < 10000
					set(switch,"range4")
				end
				if switch=="range1"
					addEquation(107)
					addEquation(108)
				elseif switch=="range2"
					addEquation(109)
					addEquation(110)
				elseif switch=="range3"
					addEquation(111)
					addEquation(112)
				elseif switch=="range4"
					addEquation(113)
					addEquation(114)
				elseif switch=="range5"
					addEquation(115)
					addEquation(116)
				end
			end
		end
	end
	let switch=ShellFlowRegime
		if ShellFlowRegime==Shell.HeatTransfer.Re > 20
			set(switch,"laminar")
		end
		if ShellFlowRegime==Shell.HeatTransfer.Re < 20
			set(switch,"deep laminar")
		end
		if ShellFlowRegime==Shell.HeatTransfer.Re > 100
			set(switch,"turbulent")
		end
		if ShellFlowRegime==Shell.HeatTransfer.Re < 100
			set(switch,"laminar")
		end
		if switch=="deep laminar"
			addEquation(117)
			addEquation(118)
			addEquation(119)
			addEquation(120)
			addEquation(121)
			addEquation(122)
		elseif switch=="laminar"
			addEquation(123)
			addEquation(124)
			addEquation(125)
			addEquation(126)
			addEquation(127)
			addEquation(128)
		elseif switch=="turbulent"
			addEquation(129)
			addEquation(130)
			addEquation(131)
			addEquation(132)
			addEquation(133)
			addEquation(134)
		end
	end
	addEquation(135)
	addEquation(136)
	addEquation(137)
	addEquation(138)
	addEquation(139)
	addEquation(140)
	addEquation(141)
	addEquation(142)
	addEquation(143)
	addEquation(144)
	addEquation(145)
	addEquation(146)
	addEquation(147)
	addEquation(148)
	addEquation(149)
	addEquation(150)
	addEquation(151)
	addEquation(152)
	addEquation(153)
	addEquation(154)
	addEquation(155)
	addEquation(156)
	addEquation(157)
	addEquation(158)
	addEquation(159)
	addEquation(160)
	addEquation(161)
	addEquation(162)
	addEquation(163)
end
function atributes(in::ShellandTubesBasic,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Basic Model for Detailed Shell and Tube Heat Exchanger."
	fields[:Info]="to be documented.
	
== Assumptions ==
* to be documented

== Specify ==
* to be documented

== Setting Parameters ==
* to be documented

== References ==
[1] E.A.D. Saunders, Heat Exchangers: Selection, Design and
 Construction, Longman, Harlow, 1988. 

[2] Taborek, J., Shell-and-tube heat exchangers, in Heat Exchanger Design Handbook, Vol. 3
 Hemisphere Publishing Corp., New York, 1988. 

[3] Bell, K. J., Mueller, A. C., Wolverine Engineering Data Book II. Wolverine Tube, Inc., <www.wlv.com>, 2001. 

[4] Fakheri, A. , Alternative approach for determining log mean temperature difference correction factor 
 and number of shells of shell and tube heat exchangers, Journal of Enhanced Heat Transfer, v. 10, p. 407- 420, 2003. 

[5] Gnielinski, V., Forced convection in ducts, in Heat Exchanger Design Handbook, Vol. 2
 Hemisphere Publishing Corp., New York, 1988."
	drive!(fields,_)
	return fields
end
ShellandTubesBasic(_::Dict{Symbol,Any})=begin
	newModel=ShellandTubesBasic()
	newModel.attributes=atributes(newModel,_)
	newModel
end
