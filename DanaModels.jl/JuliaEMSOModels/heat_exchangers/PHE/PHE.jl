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
#* $Id: PHE.mso 250 2007-04-27 16:32:02Z bicca $
#*------------------------------------------------------------------
type PHE
	PHE()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin ((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of Chemical Components"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Chevron Corrugation Inclination Angle in Degrees ",
				:Valid=>["A30_Deg","A45_Deg","A50_Deg","A60_Deg","A65_Deg"],
				:Default=>"A30_Deg"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Fluid Alocation in the Side I - (The odd channels)",
				:Valid=>["hot","cold"],
				:Default=>"hot"
			]),
			PHE_Geometry ((Symbol=>Any)[
				:Brief=>"Plate Heat Exchanger Geometrical Parameters",
				:Symbol=>" "
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet Hot Stream",
				:PosX=>0,
				:PosY=>0.75,
				:Symbol=>"^{inHot}"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet Cold Stream",
				:PosX=>0,
				:PosY=>0.25,
				:Symbol=>"^{inCold}"
			]),
			streamPH ((Symbol=>Any)[
				:Brief=>"Outlet Hot Stream",
				:PosX=>1,
				:PosY=>0.25,
				:Symbol=>"^{outHot}"
			]),
			streamPH ((Symbol=>Any)[
				:Brief=>"Outlet Cold Stream",
				:PosX=>1,
				:PosY=>0.75,
				:Symbol=>"^{outCold}"
			]),
			Main_PHE ((Symbol=>Any)[
				:Brief=>"Plate Heat Exchanger Hot Side",
				:Symbol=>"_{hot}"
			]),
			Main_PHE ((Symbol=>Any)[
				:Brief=>"Plate Heat Exchanger Cold Side",
				:Symbol=>"_{cold}"
			]),
			Thermal_PHE ((Symbol=>Any)[
				:Brief=>"Thermal Results",
				:Symbol=>" "
			]),
			[
				:(HotSide.Properties.Average.T = 0.5*InletHot.T + 0.5*OutletHot.T),
				:(ColdSide.Properties.Average.T = 0.5*InletCold.T + 0.5*OutletCold.T),
				:(HotSide.Properties.Average.P = 0.5*InletHot.P+0.5*OutletHot.P),
				:(ColdSide.Properties.Average.P = 0.5*InletCold.P+0.5*OutletCold.P),
				:(ColdSide.Properties.Wall.Twall = 0.5*HotSide.Properties.Average.T + 0.5*ColdSide.Properties.Average.T),
				:(HotSide.Properties.Wall.Twall = 0.5*HotSide.Properties.Average.T + 0.5*ColdSide.Properties.Average.T),
				:(HotSide.Properties.Average.Mw = sum(Geometry.M*InletHot.z)),
				:(ColdSide.Properties.Average.Mw = sum(Geometry.M*InletCold.z)),
				:(ColdSide.Properties.Average.Cp = PP.LiquidCp(ColdSide.Properties.Average.T,ColdSide.Properties.Average.P,InletCold.z)),
				:(ColdSide.Properties.Average.rho = PP.LiquidDensity(ColdSide.Properties.Average.T,ColdSide.Properties.Average.P,InletCold.z)),
				:(ColdSide.Properties.Inlet.rho = PP.LiquidDensity(InletCold.T,InletCold.P,InletCold.z)),
				:(ColdSide.Properties.Outlet.rho = PP.LiquidDensity(OutletCold.T,OutletCold.P,OutletCold.z)),
				:(ColdSide.Properties.Average.Mu = PP.LiquidViscosity(ColdSide.Properties.Average.T,ColdSide.Properties.Average.P,InletCold.z)),
				:(ColdSide.Properties.Average.K = PP.LiquidThermalConductivity(ColdSide.Properties.Average.T,ColdSide.Properties.Average.P,InletCold.z)),
				:(ColdSide.Properties.Wall.Mu = PP.LiquidViscosity(ColdSide.Properties.Wall.Twall,ColdSide.Properties.Average.P,InletCold.z)),
				:(ColdSide.Properties.Average.Cp = PP.VapourCp(ColdSide.Properties.Average.T,ColdSide.Properties.Average.P,InletCold.z)),
				:(ColdSide.Properties.Average.rho = PP.VapourDensity(ColdSide.Properties.Average.T,ColdSide.Properties.Average.P,InletCold.z)),
				:(ColdSide.Properties.Inlet.rho = PP.VapourDensity(InletCold.T,InletCold.P,InletCold.z)),
				:(ColdSide.Properties.Outlet.rho = PP.VapourDensity(OutletCold.T,OutletCold.P,OutletCold.z)),
				:(ColdSide.Properties.Average.Mu = PP.VapourViscosity(ColdSide.Properties.Average.T,ColdSide.Properties.Average.P,InletCold.z)),
				:(ColdSide.Properties.Average.K = PP.VapourThermalConductivity(ColdSide.Properties.Average.T,ColdSide.Properties.Average.P,InletCold.z)),
				:(ColdSide.Properties.Wall.Mu = PP.VapourViscosity(ColdSide.Properties.Wall.Twall,ColdSide.Properties.Average.P,InletCold.z)),
				:(HotSide.Properties.Average.Cp = PP.LiquidCp(HotSide.Properties.Average.T,HotSide.Properties.Average.P,InletHot.z)),
				:(HotSide.Properties.Average.rho = PP.LiquidDensity(HotSide.Properties.Average.T,HotSide.Properties.Average.P,InletHot.z)),
				:(HotSide.Properties.Inlet.rho = PP.LiquidDensity(InletHot.T,InletHot.P,InletHot.z)),
				:(HotSide.Properties.Outlet.rho = PP.LiquidDensity(OutletHot.T,OutletHot.P,OutletHot.z)),
				:(HotSide.Properties.Average.Mu = PP.LiquidViscosity(HotSide.Properties.Average.T,HotSide.Properties.Average.P,InletHot.z)),
				:(HotSide.Properties.Average.K = PP.LiquidThermalConductivity(HotSide.Properties.Average.T,HotSide.Properties.Average.P,InletHot.z)),
				:(HotSide.Properties.Wall.Mu = PP.LiquidViscosity(HotSide.Properties.Wall.Twall,HotSide.Properties.Average.P,InletHot.z)),
				:(HotSide.Properties.Average.Cp = PP.VapourCp(HotSide.Properties.Average.T,HotSide.Properties.Average.P,InletHot.z)),
				:(HotSide.Properties.Average.rho = PP.VapourDensity(HotSide.Properties.Average.T,HotSide.Properties.Average.P,InletHot.z)),
				:(HotSide.Properties.Inlet.rho = PP.VapourDensity(InletHot.T,InletHot.P,InletHot.z)),
				:(HotSide.Properties.Outlet.rho = PP.VapourDensity(OutletHot.T,OutletHot.P,OutletHot.z)),
				:(HotSide.Properties.Average.Mu = PP.VapourViscosity(HotSide.Properties.Average.T,HotSide.Properties.Average.P,InletHot.z)),
				:(HotSide.Properties.Average.K = PP.VapourThermalConductivity(HotSide.Properties.Average.T,HotSide.Properties.Average.P,InletHot.z)),
				:(HotSide.Properties.Wall.Mu = PP.VapourViscosity(HotSide.Properties.Wall.Twall,HotSide.Properties.Average.P,InletHot.z)),
				:(Thermal.Q = InletHot.F*(InletHot.h-OutletHot.h)),
				:(Thermal.Q = InletCold.F*(OutletCold.h - InletCold.h)),
				:(ColdSide.Properties.Inlet.Fw = sum(Geometry.M*InletCold.z)*InletCold.F),
				:(ColdSide.Properties.Outlet.Fw = sum(Geometry.M*OutletCold.z)*OutletCold.F),
				:(HotSide.Properties.Inlet.Fw = sum(Geometry.M*InletHot.z)*InletHot.F),
				:(HotSide.Properties.Outlet.Fw = sum(Geometry.M*OutletHot.z)*OutletHot.F),
				:(OutletHot.F = InletHot.F),
				:(OutletCold.F = InletCold.F),
				:(OutletHot.z=InletHot.z),
				:(OutletCold.z=InletCold.z),
				:(ColdSide.PressureDrop.Npassage = (2*Geometry.Nchannels+1+(-1)^(Geometry.Nchannels+1))/(4*Geometry.NpassCold)),
				:(HotSide.PressureDrop.Npassage = (2*Geometry.Nchannels-1+(-1)^(Geometry.Nchannels))/(4*Geometry.NpassHot)),
				:(HotSide.PressureDrop.Npassage = (2*Geometry.Nchannels+1+(-1)^(Geometry.Nchannels+1))/(4*Geometry.NpassHot)),
				:(ColdSide.PressureDrop.Npassage = (2*Geometry.Nchannels-1+(-1)^(Geometry.Nchannels))/(4*Geometry.NpassCold)),
				:(HotSide.HeatTransfer.Gchannel=HotSide.Properties.Inlet.Fw/(HotSide.PressureDrop.Npassage*Geometry.Achannel)),
				:(HotSide.HeatTransfer.Gports=HotSide.Properties.Inlet.Fw/Geometry.Aports),
				:(ColdSide.HeatTransfer.Gports=ColdSide.Properties.Inlet.Fw/Geometry.Aports),
				:(ColdSide.HeatTransfer.Gchannel=ColdSide.Properties.Inlet.Fw/(ColdSide.PressureDrop.Npassage*Geometry.Achannel)),
				:(HotSide.PressureDrop.DPports =1.5*Geometry.NpassHot*HotSide.HeatTransfer.Gports^2/(2*HotSide.Properties.Average.rho)),
				:(ColdSide.PressureDrop.DPports =1.5*Geometry.NpassCold*ColdSide.HeatTransfer.Gports^2/(2*ColdSide.Properties.Average.rho)),
				:(HotSide.PressureDrop.DPchannel =2*HotSide.PressureDrop.fi*Geometry.NpassHot*Geometry.Lv*HotSide.HeatTransfer.Gchannel^2/(HotSide.Properties.Average.rho*Geometry.Dh*HotSide.HeatTransfer.Phi^0.17)),
				:(ColdSide.PressureDrop.DPchannel =2*ColdSide.PressureDrop.fi*Geometry.NpassCold*Geometry.Lv*ColdSide.HeatTransfer.Gchannel^2/(ColdSide.Properties.Average.rho*Geometry.Dh*ColdSide.HeatTransfer.Phi^0.17)),
				:(HotSide.PressureDrop.Pdrop =HotSide.PressureDrop.DPchannel+HotSide.PressureDrop.DPports),
				:(ColdSide.PressureDrop.Pdrop =ColdSide.PressureDrop.DPchannel+ColdSide.PressureDrop.DPports),
				:(HotSide.PressureDrop.fi = Geometry.Kp1(1)/HotSide.HeatTransfer.Re^Geometry.Kp2(1)),
				:(ColdSide.PressureDrop.fi = Geometry.Kp1(1)/ColdSide.HeatTransfer.Re^Geometry.Kp2(1)),
				:(HotSide.PressureDrop.fi = Geometry.Kp1(2)/HotSide.HeatTransfer.Re^Geometry.Kp2(2)),
				:(ColdSide.PressureDrop.fi = Geometry.Kp1(2)/ColdSide.HeatTransfer.Re^Geometry.Kp2(2)),
				:(HotSide.PressureDrop.fi = Geometry.Kp1(3)/HotSide.HeatTransfer.Re^Geometry.Kp2(3)),
				:(ColdSide.PressureDrop.fi = Geometry.Kp1(3)/ColdSide.HeatTransfer.Re^Geometry.Kp2(3)),
				:(HotSide.PressureDrop.fi = Geometry.Kp1(4)/HotSide.HeatTransfer.Re^Geometry.Kp2(4)),
				:(ColdSide.PressureDrop.fi = Geometry.Kp1(4)/ColdSide.HeatTransfer.Re^Geometry.Kp2(4)),
				:(HotSide.PressureDrop.fi = Geometry.Kp1(5)/HotSide.HeatTransfer.Re^Geometry.Kp2(5)),
				:(ColdSide.PressureDrop.fi = Geometry.Kp1(5)/ColdSide.HeatTransfer.Re^Geometry.Kp2(5)),
				:(HotSide.PressureDrop.fi = Geometry.Kp1(6)/HotSide.HeatTransfer.Re^Geometry.Kp2(6)),
				:(ColdSide.PressureDrop.fi = Geometry.Kp1(6)/ColdSide.HeatTransfer.Re^Geometry.Kp2(6)),
				:(HotSide.PressureDrop.fi = Geometry.Kp1(7)/HotSide.HeatTransfer.Re^Geometry.Kp2(7)),
				:(ColdSide.PressureDrop.fi = Geometry.Kp1(7)/ColdSide.HeatTransfer.Re^Geometry.Kp2(7)),
				:(HotSide.PressureDrop.fi = Geometry.Kp1(8)/HotSide.HeatTransfer.Re^Geometry.Kp2(8)),
				:(ColdSide.PressureDrop.fi = Geometry.Kp1(8)/ColdSide.HeatTransfer.Re^Geometry.Kp2(8)),
				:(HotSide.PressureDrop.fi = Geometry.Kp1(9)/HotSide.HeatTransfer.Re^Geometry.Kp2(9)),
				:(ColdSide.PressureDrop.fi = Geometry.Kp1(9)/ColdSide.HeatTransfer.Re^Geometry.Kp2(9)),
				:(HotSide.PressureDrop.fi = Geometry.Kp1(10)/HotSide.HeatTransfer.Re^Geometry.Kp2(10)),
				:(ColdSide.PressureDrop.fi = Geometry.Kp1(10)/ColdSide.HeatTransfer.Re^Geometry.Kp2(10)),
				:(HotSide.PressureDrop.fi = Geometry.Kp1(11)/HotSide.HeatTransfer.Re^Geometry.Kp2(11)),
				:(ColdSide.PressureDrop.fi = Geometry.Kp1(11)/ColdSide.HeatTransfer.Re^Geometry.Kp2(11)),
				:(HotSide.PressureDrop.fi = Geometry.Kp1(12)/HotSide.HeatTransfer.Re^Geometry.Kp2(12)),
				:(ColdSide.PressureDrop.fi = Geometry.Kp1(12)/ColdSide.HeatTransfer.Re^Geometry.Kp2(12)),
				:(HotSide.PressureDrop.fi = Geometry.Kp1(13)/HotSide.HeatTransfer.Re^Geometry.Kp2(13)),
				:(ColdSide.PressureDrop.fi = Geometry.Kp1(13)/ColdSide.HeatTransfer.Re^Geometry.Kp2(13)),
				:(HotSide.PressureDrop.fi = Geometry.Kp1(14)/HotSide.HeatTransfer.Re^Geometry.Kp2(14)),
				:(ColdSide.PressureDrop.fi = Geometry.Kp1(14)/ColdSide.HeatTransfer.Re^Geometry.Kp2(14)),
				:(HotSide.PressureDrop.fi = Geometry.Kp1(15)/HotSide.HeatTransfer.Re^Geometry.Kp2(15)),
				:(ColdSide.PressureDrop.fi = Geometry.Kp1(15)/ColdSide.HeatTransfer.Re^Geometry.Kp2(15)),
				:(HotSide.HeatTransfer.hcoeff=(HotSide.Properties.Average.K*HotSide.HeatTransfer.PR^(1/3)*HotSide.HeatTransfer.Phi^0.17*Geometry.Kc1(1)*HotSide.HeatTransfer.Re^Geometry.Kc2(1))/Geometry.Dh),
				:(ColdSide.HeatTransfer.hcoeff =(ColdSide.Properties.Average.K*ColdSide.HeatTransfer.PR^(1/3)*ColdSide.HeatTransfer.Phi^0.17*Geometry.Kc1(1)*ColdSide.HeatTransfer.Re^Geometry.Kc2(1))/Geometry.Dh),
				:(HotSide.HeatTransfer.hcoeff=(HotSide.Properties.Average.K*HotSide.HeatTransfer.PR^(1/3)*HotSide.HeatTransfer.Phi^0.17*Geometry.Kc1(2)*HotSide.HeatTransfer.Re^Geometry.Kc2(2))/Geometry.Dh),
				:(ColdSide.HeatTransfer.hcoeff =(ColdSide.Properties.Average.K*ColdSide.HeatTransfer.PR^(1/3)*ColdSide.HeatTransfer.Phi^0.17*Geometry.Kc1(2)*ColdSide.HeatTransfer.Re^Geometry.Kc2(2))/Geometry.Dh),
				:(HotSide.HeatTransfer.hcoeff=(HotSide.Properties.Average.K*HotSide.HeatTransfer.PR^(1/3)*HotSide.HeatTransfer.Phi^0.17*Geometry.Kc1(3)*HotSide.HeatTransfer.Re^Geometry.Kc2(3))/Geometry.Dh),
				:(ColdSide.HeatTransfer.hcoeff =(ColdSide.Properties.Average.K*ColdSide.HeatTransfer.PR^(1/3)*ColdSide.HeatTransfer.Phi^0.17*Geometry.Kc1(3)*ColdSide.HeatTransfer.Re^Geometry.Kc2(3))/Geometry.Dh),
				:(HotSide.HeatTransfer.hcoeff=(HotSide.Properties.Average.K*HotSide.HeatTransfer.PR^(1/3)*HotSide.HeatTransfer.Phi^0.17*Geometry.Kc1(4)*HotSide.HeatTransfer.Re^Geometry.Kc2(4))/Geometry.Dh),
				:(ColdSide.HeatTransfer.hcoeff =(ColdSide.Properties.Average.K*ColdSide.HeatTransfer.PR^(1/3)*ColdSide.HeatTransfer.Phi^0.17*Geometry.Kc1(4)*ColdSide.HeatTransfer.Re^Geometry.Kc2(4))/Geometry.Dh),
				:(HotSide.HeatTransfer.hcoeff=(HotSide.Properties.Average.K*HotSide.HeatTransfer.PR^(1/3)*HotSide.HeatTransfer.Phi^0.17*Geometry.Kc1(5)*HotSide.HeatTransfer.Re^Geometry.Kc2(5))/Geometry.Dh),
				:(ColdSide.HeatTransfer.hcoeff =(ColdSide.Properties.Average.K*ColdSide.HeatTransfer.PR^(1/3)*ColdSide.HeatTransfer.Phi^0.17*Geometry.Kc1(5)*ColdSide.HeatTransfer.Re^Geometry.Kc2(5))/Geometry.Dh),
				:(HotSide.HeatTransfer.hcoeff=(HotSide.Properties.Average.K*HotSide.HeatTransfer.PR^(1/3)*HotSide.HeatTransfer.Phi^0.17*Geometry.Kc1(6)*HotSide.HeatTransfer.Re^Geometry.Kc2(6))/Geometry.Dh),
				:(ColdSide.HeatTransfer.hcoeff =(ColdSide.Properties.Average.K*ColdSide.HeatTransfer.PR^(1/3)*ColdSide.HeatTransfer.Phi^0.17*Geometry.Kc1(6)*ColdSide.HeatTransfer.Re^Geometry.Kc2(6))/Geometry.Dh),
				:(HotSide.HeatTransfer.hcoeff=(HotSide.Properties.Average.K*HotSide.HeatTransfer.PR^(1/3)*HotSide.HeatTransfer.Phi^0.17*Geometry.Kc1(7)*HotSide.HeatTransfer.Re^Geometry.Kc2(7))/Geometry.Dh),
				:(ColdSide.HeatTransfer.hcoeff =(ColdSide.Properties.Average.K*ColdSide.HeatTransfer.PR^(1/3)*ColdSide.HeatTransfer.Phi^0.17*Geometry.Kc1(7)*ColdSide.HeatTransfer.Re^Geometry.Kc2(7))/Geometry.Dh),
				:(HotSide.HeatTransfer.hcoeff=(HotSide.Properties.Average.K*HotSide.HeatTransfer.PR^(1/3)*HotSide.HeatTransfer.Phi^0.17*Geometry.Kc1(8)*HotSide.HeatTransfer.Re^Geometry.Kc2(8))/Geometry.Dh),
				:(ColdSide.HeatTransfer.hcoeff =(ColdSide.Properties.Average.K*ColdSide.HeatTransfer.PR^(1/3)*ColdSide.HeatTransfer.Phi^0.17*Geometry.Kc1(8)*ColdSide.HeatTransfer.Re^Geometry.Kc2(8))/Geometry.Dh),
				:(HotSide.HeatTransfer.hcoeff=(HotSide.Properties.Average.K*HotSide.HeatTransfer.PR^(1/3)*HotSide.HeatTransfer.Phi^0.17*Geometry.Kc1(9)*HotSide.HeatTransfer.Re^Geometry.Kc2(9))/Geometry.Dh),
				:(ColdSide.HeatTransfer.hcoeff =(ColdSide.Properties.Average.K*ColdSide.HeatTransfer.PR^(1/3)*ColdSide.HeatTransfer.Phi^0.17*Geometry.Kc1(9)*ColdSide.HeatTransfer.Re^Geometry.Kc2(9))/Geometry.Dh),
				:(HotSide.HeatTransfer.hcoeff=(HotSide.Properties.Average.K*HotSide.HeatTransfer.PR^(1/3)*HotSide.HeatTransfer.Phi^0.17*Geometry.Kc1(10)*HotSide.HeatTransfer.Re^Geometry.Kc2(10))/Geometry.Dh),
				:(ColdSide.HeatTransfer.hcoeff =(ColdSide.Properties.Average.K*ColdSide.HeatTransfer.PR^(1/3)*ColdSide.HeatTransfer.Phi^0.17*Geometry.Kc1(10)*ColdSide.HeatTransfer.Re^Geometry.Kc2(10))/Geometry.Dh),
				:(HotSide.HeatTransfer.hcoeff=(HotSide.Properties.Average.K*HotSide.HeatTransfer.PR^(1/3)*HotSide.HeatTransfer.Phi^0.17*Geometry.Kc1(11)*HotSide.HeatTransfer.Re^Geometry.Kc2(11))/Geometry.Dh),
				:(ColdSide.HeatTransfer.hcoeff =(ColdSide.Properties.Average.K*ColdSide.HeatTransfer.PR^(1/3)*ColdSide.HeatTransfer.Phi^0.17*Geometry.Kc1(11)*ColdSide.HeatTransfer.Re^Geometry.Kc2(11))/Geometry.Dh),
				:(HotSide.HeatTransfer.hcoeff=(HotSide.Properties.Average.K*HotSide.HeatTransfer.PR^(1/3)*HotSide.HeatTransfer.Phi^0.17*Geometry.Kc1(12)*HotSide.HeatTransfer.Re^Geometry.Kc2(12))/Geometry.Dh),
				:(ColdSide.HeatTransfer.hcoeff =(ColdSide.Properties.Average.K*ColdSide.HeatTransfer.PR^(1/3)*ColdSide.HeatTransfer.Phi^0.17*Geometry.Kc1(12)*ColdSide.HeatTransfer.Re^Geometry.Kc2(12))/Geometry.Dh),
				:(HotSide.HeatTransfer.hcoeff=(HotSide.Properties.Average.K*HotSide.HeatTransfer.PR^(1/3)*HotSide.HeatTransfer.Phi^0.17*Geometry.Kc1(13)*HotSide.HeatTransfer.Re^Geometry.Kc2(13))/Geometry.Dh),
				:(ColdSide.HeatTransfer.hcoeff =(ColdSide.Properties.Average.K*ColdSide.HeatTransfer.PR^(1/3)*ColdSide.HeatTransfer.Phi^0.17*Geometry.Kc1(13)*ColdSide.HeatTransfer.Re^Geometry.Kc2(13))/Geometry.Dh),
				:(HotSide.HeatTransfer.hcoeff=(HotSide.Properties.Average.K*HotSide.HeatTransfer.PR^(1/3)*HotSide.HeatTransfer.Phi^0.17*Geometry.Kc1(14)*HotSide.HeatTransfer.Re^Geometry.Kc2(14))/Geometry.Dh),
				:(ColdSide.HeatTransfer.hcoeff =(ColdSide.Properties.Average.K*ColdSide.HeatTransfer.PR^(1/3)*ColdSide.HeatTransfer.Phi^0.17*Geometry.Kc1(14)*ColdSide.HeatTransfer.Re^Geometry.Kc2(14))/Geometry.Dh),
				:(HotSide.PressureDrop.Vchannel =HotSide.HeatTransfer.Gchannel/HotSide.Properties.Average.rho),
				:(ColdSide.PressureDrop.Vchannel =ColdSide.HeatTransfer.Gchannel/ColdSide.Properties.Average.rho),
				:(HotSide.PressureDrop.Vports =HotSide.Properties.Inlet.Fw/(Geometry.Aports*HotSide.Properties.Inlet.rho)),
				:(ColdSide.PressureDrop.Vports =ColdSide.Properties.Inlet.Fw/(Geometry.Aports*ColdSide.Properties.Inlet.rho)),
				:(HotSide.HeatTransfer.Re =Geometry.Dh*HotSide.HeatTransfer.Gchannel/HotSide.Properties.Average.Mu),
				:(ColdSide.HeatTransfer.Re =Geometry.Dh*ColdSide.HeatTransfer.Gchannel/ColdSide.Properties.Average.Mu),
				:(HotSide.HeatTransfer.PR= ((HotSide.Properties.Average.Cp/HotSide.Properties.Average.Mw)*HotSide.Properties.Average.Mu)/HotSide.Properties.Average.K),
				:(ColdSide.HeatTransfer.PR = ((ColdSide.Properties.Average.Cp/ColdSide.Properties.Average.Mw)*ColdSide.Properties.Average.Mu)/ColdSide.Properties.Average.K),
				:(HotSide.HeatTransfer.Phi= HotSide.Properties.Average.Mu/HotSide.Properties.Wall.Mu),
				:(ColdSide.HeatTransfer.Phi= ColdSide.Properties.Average.Mu/ColdSide.Properties.Wall.Mu),
				:(OutletHot.P = InletHot.P - HotSide.PressureDrop.Pdrop),
				:(OutletCold.P = InletCold.P - ColdSide.PressureDrop.Pdrop),
				:(Thermal.Uc/HotSide.HeatTransfer.hcoeff +Thermal.Uc*Geometry.pt/Geometry.Kwall+Thermal.Uc/ColdSide.HeatTransfer.hcoeff=1),
				:(Thermal.Ud*(1/HotSide.HeatTransfer.hcoeff +Geometry.pt/Geometry.Kwall+1/ColdSide.HeatTransfer.hcoeff + Geometry.Rfc + Geometry.Rfh)=1),
				:(Thermal.Q = Thermal.Eft*Thermal.Cmin*(InletHot.T-InletCold.T)),
				:(Thermal.Cr =Thermal.Cmin/Thermal.Cmax),
				:(Thermal.Cmin = min([HotSide.HeatTransfer.WCp,ColdSide.HeatTransfer.WCp])),
				:(Thermal.Cmax = max([HotSide.HeatTransfer.WCp,ColdSide.HeatTransfer.WCp])),
				:(HotSide.HeatTransfer.WCp = InletHot.F*HotSide.Properties.Average.Cp),
				:(ColdSide.HeatTransfer.WCp = InletCold.F*ColdSide.Properties.Average.Cp),
				:(Thermal.NTU = max([HotSide.HeatTransfer.NTU,ColdSide.HeatTransfer.NTU])),
				:(HotSide.HeatTransfer.NTU*HotSide.HeatTransfer.WCp = Thermal.Ud*Geometry.Atotal),
				:(ColdSide.HeatTransfer.NTU*ColdSide.HeatTransfer.WCp = Thermal.Ud*Geometry.Atotal),
				:(Thermal.Eft = 1),
				:(Thermal.NTU*(Thermal.Cr-1.00001) = ln(abs((Thermal.Eft-1.00001))) - ln(abs((Thermal.Cr*Thermal.Eft-1.00001)))),
			],
			[
				"Hot	Stream Average Temperature","Cold Stream Average Temperature","Hot Stream Average Pressure","Cold Stream Average Pressure","Cold Stream Wall Temperature","Hot Stream Wall Temperature","Hot Stream Average Molecular Weight","Cold Stream Average Molecular Weight","Average Heat Capacity Cold Stream","Average Mass Density Cold Stream","Inlet Mass Density Cold Stream","Outlet Mass Density Cold Stream","Average Viscosity Cold Stream","Average	Conductivity Cold Stream","Viscosity Cold Stream at wall temperature","Average Heat Capacity ColdStream","Average Mass Density Cold Stream","Inlet Mass Density Cold Stream","Outlet Mass Density Cold Stream","Average Viscosity Cold Stream","Average Conductivity Cold Stream","Viscosity Cold Stream at wall temperature","Average Heat Capacity Hot Stream","Average Mass Density Hot Stream","Inlet Mass Density Hot Stream","Outlet Mass Density Hot Stream","Average Viscosity Hot Stream","Average Conductivity Hot Stream","Viscosity Hot Stream at wall temperature","Average Heat Capacity Hot Stream","Average Mass Density Hot Stream","Inlet Mass Density Hot Stream","Outlet Mass Density Hot Stream","Average Viscosity Hot Stream","Average Conductivity Hot Stream","Viscosity Hot Stream at wall temperature","Energy Balance Hot Stream","Energy Balance Cold Stream","Flow Mass Inlet Cold Stream","Flow Mass Outlet Cold Stream","Flow Mass Inlet Hot Stream","Flow Mass Outlet Hot Stream","Molar Balance Hot Stream","Molar Balance Cold Stream","Hot Stream Molar Fraction Constraint","Cold Stream Molar Fraction Constraint","Total Number of  Passages Cold Side","Total Number of  Passages Hot Side","Total Number of  Passages Cold Side","Total Number of  Passages Hot Side","Hot Stream Mass Flux in the Channel","Hot Stream Mass Flux in the Ports","Cold Stream Mass Flux in the Ports","Cold Stream Mass Flux in the Channel","Hot Stream Pressure Drop in Ports","Cold Stream Pressure Drop in Ports","Hot Stream Pressure Drop in Channels","Cold Stream Pressure Drop in Channels","Hot Stream Total Pressure Drop","Cold Stream Total Pressure Drop","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","Hot Stream Velocity in Channels","Cold Stream Velocity in Channels","Hot Stream Velocity in Ports","Cold Stream Velocity in Ports","Hot Stream Reynolds Number","Cold Stream Reynolds Number","Hot Stream Prandtl Number","Cold Stream Prandtl Number","Hot Stream Viscosity Correction","Cold Stream Viscosity Correction","Hot Stream Outlet Pressure","Cold Stream Outlet Pressure","Overall Heat Transfer Coefficient Clean","Overall Heat Transfer Coefficient Dirty","Duty","Heat Capacity Ratio","Minimum Heat Capacity","Maximum Heat Capacity","Hot Stream Heat Capacity","Cold Stream Heat Capacity","Number of Units Transference for the Whole Heat Exchanger","Number of Units Transference for Hot Side","Number of Units Transference for Cold Side","Effectiveness in Counter Flow","Effectiveness in Counter Flow",
			],
			[:PP,:NComp,:ChevronAngle,:SideOne,],
			[:Geometry,:InletHot,:InletCold,:OutletHot,:OutletCold,:HotSide,:ColdSide,:Thermal,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	ChevronAngle::DanaSwitcher 
	SideOne::DanaSwitcher 
	Geometry::PHE_Geometry 
	InletHot::stream 
	InletCold::stream 
	OutletHot::streamPH 
	OutletCold::streamPH 
	HotSide::Main_PHE 
	ColdSide::Main_PHE 
	Thermal::Thermal_PHE 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export PHE
function setEquationFlow(in::PHE)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
	addEquation(7)
	addEquation(8)
	if InletCold.v == 0 
		addEquation(9)
		addEquation(10)
		addEquation(11)
		addEquation(12)
		addEquation(13)
		addEquation(14)
		addEquation(15)
	else
		addEquation(16)
		addEquation(17)
		addEquation(18)
		addEquation(19)
		addEquation(20)
		addEquation(21)
		addEquation(22)
	end
	if InletHot.v == 0 
		addEquation(23)
		addEquation(24)
		addEquation(25)
		addEquation(26)
		addEquation(27)
		addEquation(28)
		addEquation(29)
	else
		addEquation(30)
		addEquation(31)
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
	let switch=SideOne
		if switch=="cold"
			addEquation(47)
			addEquation(48)
		elseif switch=="hot"
			addEquation(49)
			addEquation(50)
		end
	end
	addEquation(51)
	addEquation(52)
	addEquation(53)
	addEquation(54)
	addEquation(55)
	addEquation(56)
	addEquation(57)
	addEquation(58)
	addEquation(59)
	addEquation(60)
	let switch=ChevronAngle
		#Pressure Drop Friction Factor According to kumar's (1984)
		if switch=="A30_Deg"
			#	ChevronAngle <= 30
			if HotSide.HeatTransfer.Re < 10 
				addEquation(61)
				addEquation(62)
			else
				if HotSide.HeatTransfer.Re < 100 
					addEquation(63)
					addEquation(64)
				else
					addEquation(65)
					addEquation(66)
				end
			end
		elseif switch=="A45_Deg"
			if HotSide.HeatTransfer.Re < 15 
				addEquation(67)
				addEquation(68)
			else
				if HotSide.HeatTransfer.Re < 300 
					addEquation(69)
					addEquation(70)
				else
					addEquation(71)
					addEquation(72)
				end
			end
		elseif switch=="A50_Deg"
			if HotSide.HeatTransfer.Re < 20 
				addEquation(73)
				addEquation(74)
			else
				if HotSide.HeatTransfer.Re < 300 
					addEquation(75)
					addEquation(76)
				else
					addEquation(77)
					addEquation(78)
				end
			end
		elseif switch=="A60_Deg"
			if HotSide.HeatTransfer.Re < 40 
				addEquation(79)
				addEquation(80)
			else
				if HotSide.HeatTransfer.Re < 400 
					addEquation(81)
					addEquation(82)
				else
					addEquation(83)
					addEquation(84)
				end
			end
		elseif switch=="A65_Deg"
			#	ChevronAngle >= 65
			if HotSide.HeatTransfer.Re < 50 
				addEquation(85)
				addEquation(86)
			else
				if HotSide.HeatTransfer.Re < 500 
					addEquation(87)
					addEquation(88)
				else
					addEquation(89)
					addEquation(90)
				end
			end
		end
	end
	let switch=ChevronAngle
		# Heat Transfer Coefficient According to kumar's (1984)
		if switch=="A30_Deg"
			#	ChevronAngle <= 30
			if HotSide.HeatTransfer.Re < 10 
				addEquation(91)
				addEquation(92)
			else
				addEquation(93)
				addEquation(94)
			end
		elseif switch=="A45_Deg"
			if HotSide.HeatTransfer.Re < 10 
				addEquation(95)
				addEquation(96)
			else
				if HotSide.HeatTransfer.Re < 100 
					addEquation(97)
					addEquation(98)
				else
					addEquation(99)
					addEquation(100)
				end
			end
		elseif switch=="A50_Deg"
			if HotSide.HeatTransfer.Re < 20 
				addEquation(101)
				addEquation(102)
			else
				if HotSide.HeatTransfer.Re < 300 
					addEquation(103)
					addEquation(104)
				else
					addEquation(105)
					addEquation(106)
				end
			end
		elseif switch=="A60_Deg"
			if HotSide.HeatTransfer.Re < 20 
				addEquation(107)
				addEquation(108)
			else
				if HotSide.HeatTransfer.Re < 400 
					addEquation(109)
					addEquation(110)
				else
					addEquation(111)
					addEquation(112)
				end
			end
		elseif switch=="A65_Deg"
			#	ChevronAngle >= 65
			if HotSide.HeatTransfer.Re < 20 
				addEquation(113)
				addEquation(114)
			else
				if HotSide.HeatTransfer.Re < 500 
					addEquation(115)
					addEquation(116)
				else
					addEquation(117)
					addEquation(118)
				end
			end
		end
	end
	addEquation(119)
	addEquation(120)
	addEquation(121)
	addEquation(122)
	addEquation(123)
	addEquation(124)
	addEquation(125)
	addEquation(126)
	addEquation(127)
	addEquation(128)
	addEquation(129)
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
	if Thermal.Eft >= 1 #To be Fixed: Effectiveness in true counter flow !
	
		addEquation(142)
	else
		addEquation(143)
	end
end
function atributes(in::PHE,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Icon]="icon/phe"
	fields[:Pallete]=true
	fields[:Brief]="Shortcut model  for Plate and Frame heat exchanger."
	fields[:Info]="Model of a gasketed plate heat exchanger.
The heat transfer and pressure loss calculations are based on Kumar [1] work.
The following assumptions are considered in order to derive the mathematical model [2]:

== Assumptions ==
* Steady-State operation;
* No phase changes;
* No heat loss to the surroundings.
* Uniform distribution of flow through the channels of a pass.

== Specify ==
* The Inlet streams: Hot and Cold;

== Setting The PHE Parameters ==
*ChevronAngle
*Nplates
*NpassHot
*NpassCold
*Dports
*PhiFactor
*Lv
*Lw
*pitch
*pt
*Kwall
*Rfc
*Rfh

== Setting The PHE Option Parameters ==
*SideOne: cold or hot

== References ==

[1] E.A.D. Saunders, Heat Exchangers: Selection, Design and
 Construction, Longman, Harlow, 1988.

[2] J.A.W. Gut, J.M. Pinto, Modeling of plate heat exchangers
 with generalized configurations, Int. J. Heat Mass Transfer
 46 (14) (2003) 2571\\2585.
"
	drive!(fields,_)
	return fields
end
PHE(_::Dict{Symbol,Any})=begin
	newModel=PHE()
	newModel.attributes=atributes(newModel,_)
	newModel
end
