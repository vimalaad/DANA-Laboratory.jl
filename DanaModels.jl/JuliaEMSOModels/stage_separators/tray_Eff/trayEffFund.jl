#-------------------------------------------------------------------
#* Models of tray with Efficiency Prediction
#* Author: Josias J. Junges
#*-------------------------------------------------------------------
type trayEffFund
	trayEffFund()=begin
		iLK=outers.iLK
		iHK=outers.iHK
		new(
			tray(),
			length ((Symbol=>Any)[
				:Brief=>"Tray Diameter"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Hole Diameter"
			]),
			area ((Symbol=>Any)[
				:Brief=>"Case Downcomer: Active Area or Bubbling Area = Atray - 2*Adowncomer. Case dualflow: total tray area"
			]),
			area ((Symbol=>Any)[
				:Brief=>"Area of Holes"
			]),
			fraction ((Symbol=>Any)[
				:Brief=>"Fractional perforated tray area(hole area/ bubbling area)"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Tray spacing"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Tray thickness"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Valid=>["Dualflow", "Downcomer"],
				:Default=>"Downcomer"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Pseudo-binary ligth key index"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Pseudo-binary heavy key index"
			]),
			flow_vol ((Symbol=>Any)[
				:Brief=>"Vapour volumetric flow"
			]),
			flow_vol ((Symbol=>Any)[
				:Brief=>"Liquid volumetric flow"
			]),
			flow_mass ((Symbol=>Any)[
				:Brief=>"Vapour mass flow"
			]),
			flow_mass ((Symbol=>Any)[
				:Brief=>"Liquid mass flow"
			]),
			viscosity ((Symbol=>Any)[
				:Brief=>"Vapour viscosity"
			]),
			viscosity ((Symbol=>Any)[
				:Brief=>"Liquid viscosity"
			]),
			diffusivity ((Symbol=>Any)[
				:Brief=>"Diffusivity on Liquid Phase"
			]),
			diffusivity ((Symbol=>Any)[
				:Brief=>"Diffusivity on Vapour Phase"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Stripping factor or ratio of slope of equilibrium line to slope of operating line"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Slope of equilibrium line"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Pseudo-binary key "
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Pseudo-binary key"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Pseudo-binary key"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Pseudo-binary key"
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"Superficial velocity based on Ap"
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"Superficial velocity based on Aa"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Superficial factor",
				:Unit=>"kg^.5/m^.5/s"
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"Vapour velocity through holes"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Flow Parameter"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Clear Liquid Height"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Dynamic liquid head at tray floor"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Froth Height"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Porosity"
			]),
			positive((Symbol=>Any)[
				:Brief=>"Capacity Factor"
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"Flood velocity"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Flood factor"
			]),
			surf_tens ((Symbol=>Any)[
				:Brief=>"Surface Tension"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"General Factor in equations of Units of Mass Transfer",
				:Unit=>"cm/s^.5"
			]),
			fraction ((Symbol=>Any)[
				:Brief=>"Fraction of holes with vapour flow"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Jet Diameter"
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"Jet velocity"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Reynolds number for vapour flow through hole"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Jet lenght"
			]),
			time_sec ((Symbol=>Any)[
				:Brief=>"Residence time in Zone One"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Number of liquid phase transfer units in Zone One"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Small bubble diameter"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Large bubble diameter"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Surface tension correction"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Liquid viscosity correction"
			]),
			positive(),
			length ((Symbol=>Any)[
				:Brief=>"Small bubble Sauter diameter"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Large bubble Sauterdiameter"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Etvos number"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Morton number"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Constant h"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Constant j"
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"Terminal velocity of small bubbles"
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"Terminal velocity of small bubbles using Sauter diameter"
			]),
			fraction ((Symbol=>Any)[
				:Brief=>"Fraction of small bubbles in froth"
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"Terminal velocity of large bubbles"
			]),
			time_sec ((Symbol=>Any)[
				:Brief=>"Residence time of small bubbles in Zone Two"
			]),
			time_sec ((Symbol=>Any)[
				:Brief=>"Residence time of large bubbles in Zone Two"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Number of liquid phase transfer units of small bubbles in Zone Two"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Number of liquid phase transfer units of large bubbles in Zone Two"
			]),
			time_sec ((Symbol=>Any)[
				:Brief=>"Residence time in Zone Three"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Number of liquid phase transfer units in Zone Three"
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"Terminal velocity of large bubbles in Zone Three"
			]),
			time_sec ((Symbol=>Any)[
				:Brief=>"Residence time of small bubbles in Zone Four"
			]),
			time_sec ((Symbol=>Any)[
				:Brief=>"Residence time of large bubbles in Zone Four"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Number of liquid phase transfer units of small bubbles in Zone Four"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Number of liquid phase transfer units of large bubbles in Zone Four"
			]),
			time_sec ((Symbol=>Any)[
				:Brief=>"Residence time in Zone Five"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Number of liquid phase transfer units in Zone Five"
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"Superficial velocity based on Aa in the transition point of froth regime to spay regime"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Fraction of active holes that are in jetting"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Fraction of active holes that are producing small bubbles"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Fraction of active holes that are producing large bubbles"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"General Factor in equations of Units of Mass Transfer"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Reynolds number of jet"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Schmidt number of vapour phase"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Liquid phase mass transfer coefficient in Zone One"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Vapour phase mass transfer coefficient in Zone One"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Number of vapour phase transfer units in Zone One"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Peclet number of small bubbles in Zone Two"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Peclet number of large bubbles in Zone Two"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Peclet number in Zone Three"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Peclet number of small bubbles in Zone Four"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Peclet number of large bubbles in Zone Four"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Peclet number in Zone Five"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Sherwood number of small bubbles in Zone Two"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Sherwood number of large bubbles in Zone Two"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Sherwood number in Zone Three"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Sherwood number of small bubbles in Zone Four"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Sherwood number of large bubbles in Zone Four"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Sherwood number in Zone Five"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Vapour phase mass transfer coefficient of small bubbles in Zone Two"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Vapour phase mass transfer coefficient of large bubbles in Zone Two"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Vapour phase mass transfer coefficient in Zone Three"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Vapour phase mass transfer coefficient of small bubbles in Zone Four"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Vapour phase mass transfer coefficient of large bubbles in Zone Four"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Vapour phase mass transfer coefficient in Zone Five"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Liquid phase mass transfer coefficient of small bubbles in Zone Two"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Liquid phase mass transfer coefficient of large bubbles in Zone Two"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Liquid phase mass transfer coefficient in Zone Three"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Liquid phase mass transfer coefficient of small bubbles in Zone Four"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Liquid phase mass transfer coefficient of large bubbles in Zone Four"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Liquid phase mass transfer coefficient in Zone Five"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Number of Vapour phase transfer units of small bubbles in Zone Two"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Number of Vapour phase transfer units of large bubbles in Zone Two"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Number of Vapour phase transfer units in Zone Three"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Number of Vapour phase transfer units of small bubbles in Zone Four"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Number of Vapour phase transfer units of large bubbles in Zone Four"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Number of Vapour phase transfer units in Zone Five"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Number of Vapour phase transfer units of jetting"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Number of Vapour phase transfer units of large bubbles"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Point Efficiency"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Eddy diffusivity for liquid mixing"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Peclet Number"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Constant"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Murphree tray efficiency"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Correction factor of liquid entrainment in dualflow trays"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Correction factor of weeping in dualflow trays"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Height on spray regime"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Fraction of entrained liquid"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Apparent Murphree tray efficiency"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Apparent Murphree tray efficiency"
			]),
			[
				:(Qv=_P1._P1.OutletV.F*_P1._P1.vV),
				:(Ql=_P1._P1.OutletL.F*_P1._P1.vL),
				:(Mv=Qv*rhoV),
				:(Ml=Ql*rhoL),
				:(Miv=_P1._P1.PP.VapourViscosity(_P1._P1.OutletL.T, _P1._P1.OutletL.P, _P1._P1.OutletL.z)),
				:(Mil=_P1._P1.PP.LiquidViscosity(_P1._P1.OutletL.T, _P1._P1.OutletL.P, _P1._P1.OutletL.z)),
				:(VinLK=_P1._P1.InletV.z(iLK)/(_P1._P1.InletV.z(iLK)+_P1._P1.InletV.z(iHK))),
				:(VoutLk=_P1._P1.OutletV.z(iLK)/(_P1._P1.OutletV.z(iLK)+_P1._P1.OutletV.z(iHK))),
				:(LinLK=_P1._P1.InletL.z(iLK)/(_P1._P1.InletL.z(iLK)+_P1._P1.InletL.z(iHK))),
				:(LoutLk=_P1._P1.OutletL.z(iLK)/(_P1._P1.OutletL.z(iLK)+_P1._P1.OutletL.z(iHK))),
				:(VinLK=1),
				:(VoutLk=1),
				:(LinLK=1),
				:(LoutLk=1),
				:(lambda=m*(_P1._P1.OutletV.F/_P1._P1.OutletL.F)),
				:(us=Qv/_P1._P1.Ap),
				:(ua=Qv/Aa),
				:(fs=ua*rhoV^.5),
				:(uh=Qv/_P1.Ah),
				:((fp*Mv)^2*rhoL=Ml^2*rhoV),
				:(hcl=0.42*(Ql*"1/m"/(_P1.lw*ua)*(rhoL/rhoV)^.5)^.33*(_P1.hw*"1/m")^.67*"m"),
				:(hcl=(0.01728*((Ml*"1/(kg/s)")^(4.3*(fi^1.5))*(ua*"1/(m/s)"*(rhoV/rhoL)^.5)^1))/(rhoL*"1/(kg/m^3)"*fi^1.5*(T/(dh*1000*1000))^.42)*"m"),
				:(hcld=hcl-ua*rhoV*(uh-ua)/(rhoL*g)),
				:(hf=0.076*"m"+32.6*"m"*(fs*"1/(kg^.5/m^.5/s)")^2/((rhoL-rhoV)*"m^3/kg")+0.82*hcld),
				:(e=1-hcl/hf),
				:(csb=(0.0744*Ts*"1/m"+0.0117)*(log(abs(1/fp)))+0.0304*Ts*"1/m"+0.0153),
				:(csb=(0.1317*fp^2-0.1747*fp+0.1124)*(0.6649*Ts*"1/m"+0.5667)),
				:(uf = csb*(sigma*"1/(N/m)"/0.02)^.2*(abs((rhoL-rhoV)/rhoV))^.5*(fi/.1)^.44*"m/s"),
				:(ff=us/uf),
				:(ff=ua/uf),
				:(ftm=(rhoL*Mv*Dl^.5)/(3.1416^.5*rhoV*Ml)),
				:(xf=0.9),
				:(xf=0.4668*(fi/0.2)^.8*(Ts*"1/m"/0.61)^.2*exp(-0.35*(abs(ff*100-90)/45))),
				:(dj=1.1*dh+0.25*hcl),
				:(uj=(uh*dh^2)/(xf*dj^2)),
				:(Reh=dh*uh*rhoV/Miv),
				:(hj=1.1e-3*(dh*"1/m")^.2*Reh^.46*"m"),
				:(tg1=hj/uj),
				:(NL1=(8*ftm*tg1^.5)/dj),
				:(dbs=3.34/(ua*"s/m"*9.8)^.4*(sigma*"m/N"/(rhoL*"m^3/kg"))^.6*(Mil/Miv)^.1*"m"),
				:(dbl=dbs*(0.83+41.5*((sigma*"m/N")^.6*(Mil*"1/cP"/(rhoV*"m^3/kg"))^.1))),
				:(sigCSB=1),
				:(sigCSB=3*(sigma*"m/N")^.6),
				:(MilCSB=4.13*(Mil*"1/cP")^1.5),
				:(MilCSB=1),
				:(fi3=1*MilCSB*sigCSB),
				:(dbls=fi3*.605*(dh*"1/m")^.84*(uh*"s/m")^.18/((Ql*"s/m^3")/(_P1.lw*"1/m")^.07)*"m"),
				:(dbss=fi3*.660*(dh*"1/m")^.84*(uh*"s/m")^.085/((Ql*"s/m^3")/(_P1.lw*"1/m")^.08)*"m"),
				:(eo=g*(rhoL-rhoV)*dbs^2/sigma),
				:(mo=g*Mil^4*(rhoL-rhoV)/(rhoL^2*sigma^3)),
				:(h=4/3*eo*mo^-0.149*((Mil*"1/cP")/9.12e-4)^-.14),
				:(j=3.42*h^.441),
				:(j=0.94*h^.757),
				:(usb=Mil/(rhoL*dbs)*mo^-.149*(j-0.857)),
				:(ubss=Mil/(rhoL*dbs)*mo^-.149*(j-0.857)),
				:(aj=1-0.463*((sigma*"m/N")/0.07282)^0.6*((Mil/9.12e-4)*(1.845e-5/Miv))^0.1*(994.7/(rhoL*"m^3/kg"))^0.6*(1.183/(rhoV*"m^3/kg"))^0.1),
				:(ulb = us/((1 - aj)*e) - usb*aj/(1-aj)),
				:(tg2s = (hf-hj)/usb),
				:(tg2l = (hf-hj)/ulb),
				:(tg2s = hf/usb),
				:(tg2l = hf/ulb),
				:(NL2S = 12*ftm*tg2s^0.5/dbs),
				:(NL2L = 12*ftm*tg2l^0.5/dbl),
				:(ulb3 = us/e),
				:(tg3 = dbls/ulb3),
				:(NL3 = 12*ftm*tg3^0.5/dbls),
				:(tg4s = (hf-dbls)/usb),
				:(tg4l = (hf-dbls)/ulb),
				:(tg4s = hf/usb),
				:(tg4l = hf/ulb),
				:(NL4S=12*ftm*tg4s^0.5/dbs),
				:(NL4L=12*ftm*tg4l^0.5/dbl),
				:(tg5=hf/ulb3),
				:(NL5=12*ftm*tg5^0.5/dbss),
				:(uatp=((0.04302*(rhoV*"m^3/kg")^(-0.5)*(rhoL*"m^3/kg")^0.692*(sigma*"m/N")^0.06*fi^0.25*((Ql*"s/m^3")/(_P1.lw*"1/m"))^.05*(dh*"1/m")^(-0.1))*(2.58717*(_P1.hw*"1/m")+0.86))*"m/s"),
				:(fj=ua*0.6/uatp),
				:(fsb=165.65*(dh*"1/m")^1.32*fi^1.33),
				:(flb=1-fj-fsb),
				:(ftmg=(Ml*rhoV)/(Mv*rhoL)),
				:(Rej=uj*dj*rhoV/Miv),
				:(Scg=Miv/(rhoV*Dv)),
				:(kg1=0.046*((Dv*"s/m^2")/(dj*"1/m"))*Rej^0.96*Scg^0.44),
				:(kl1=1.13*((Dl*"s/m^2")/(tg1*"1/s"))^0.5),
				:(NG1=ftmg*kg1*NL1/kl1),
				:(Peg2s=dbs*usb/Dv),
				:(Peg2l=dbl*ulb/Dv),
				:(Peg3=dbls*ulb3/Dv),
				:(Peg4s=dbs*usb/Dv),
				:(Peg4l=dbl*ulb/Dv),
				:(Peg5=dbss*ubss/Dv),
				:(Sh2s=17.9),
				:(Sh2s=-11.878+25.879*log(Peg2s)-5.640*(log(Peg2s))^2),
				:(Sh2l=17.9),
				:(Sh2l=-11.878+25.879*log(Peg2l)-5.640*(log(Peg2l))^2),
				:(Sh3=17.9),
				:(Sh3=-11.878+25.879*log(Peg3)-5.640*(log(Peg3))^2),
				:(Sh4s=17.9),
				:(Sh4s=-11.878+25.879*log(Peg4s)-5.640*(log(Peg4s))^2),
				:(Sh4l=17.9),
				:(Sh4l=-11.878+25.879*log(Peg4l)-5.640*(log(Peg4l))^2),
				:(Sh5=17.9),
				:(Sh5=-11.878+25.879*log(Peg5)-5.640*(log(Peg5))^2),
				:(kg2s=Sh2s*(Dv*"s/m^2")/(dbs*"1/m")),
				:(kg2l=Sh2l*(Dv*"s/m^2")/(dbl*"1/m")),
				:(kg3=Sh3*(Dv*"s/m^2")/(dbls*"1/m")),
				:(kg4s=Sh4s*(Dv*"s/m^2")/(dbs*"1/m")),
				:(kg4l=Sh4l*(Dv*"s/m^2")/(dbl*"1/m")),
				:(kg5=Sh5*(Dv*"s/m^2")/(dbss*"1/m")),
				:(kl2s=1.13*((Dl*"s/m^2")/(tg2s*"1/s"))^0.5),
				:(kl2l=1.13*((Dl*"s/m^2")/(tg2l*"1/s"))^0.5),
				:(kl3=1.13*((Dl*"s/m^2")/(tg3*"1/s"))^0.5),
				:(kl4s=1.13*((Dl*"s/m^2")/(tg4s*"1/s"))^0.5),
				:(kl4l=1.13*((Dl*"s/m^2")/(tg4l*"1/s"))^0.5),
				:(kl5=1.13*((Dl*"s/m^2")/(tg5*"1/s"))^0.5),
				:(NG2S=ftmg*kg2s*NL2S/kl2s),
				:(NG2L=ftmg*kg2l*NL2L/kl2l),
				:(NG3=ftmg*kg3*NL3/kl3),
				:(NG4S=ftmg*kg4s*NL4S/kl4s),
				:(NG4L=ftmg*kg4l*NL4L/kl4l),
				:(NG5=ftmg*kg5*NL5/kl5),
				:(NGFJ=NG1-ln(1e-8+abs(1-(aj*(1-exp(-NG2S))+(1-aj)*(1-exp(-NG2L)))))),
				:(NGFLB= NG3-ln(1e-8+abs(1-(aj*(1-exp(-NG4S))+(1-aj)*(1-exp(-NG4L)))))),
				:(EOG=fj*(1-exp(-NGFJ))+flb*(1-exp(-NGFLB))+fsb*(1-exp(-NG5))),
				:(De=(0.0005+0.01285*ua*"s/m"+6.32*(Ql*"s/m^3"/(_P1.lw*"1/m"))+0.312*_P1.hw*"1/m")^2),
				:(Pe=(_P1._P1.OutletL.F*d)/(_P1.lw*hcl*(1/_P1._P1.vL)*De*"m^2/s")),
				:(n=Pe/2*((1+4*lambda*EOG/Pe)^.5-1)),
				:(Emv1=EOG),
				:(Emv1/EOG=(1-exp(-(n+Pe)))/((n+Pe)*(1+(n+Pe)/n))+(exp(n)-1)/(n*(1+n/(n+Pe)))),
				:(lambda*Emv1=(exp(lambda*EOG)-1)),
				:(hb=hcl*(265*((ua/(g*hcl)^.5)*(rhoV/rhoL)^.5)^1.7+1)),
				:(l=1e-8*(hb/Ts)^3*(uh/(Ql/Aa))^2),
				:(Emv1=Emv2*(1+l*Emv1)),
				:(Emv1=Emv2*(1+Emv1*psi/(1-psi))),
				:(Emv2=Emv3),
				:(Emv2=Emv3*(1+Emv2*psi1/(1-psi1))),
				:(_P1._P1.Emv=Emv3),
			],
			[
				"Vapour volumetric flow","Liquid volumetric flow","Vapour mass flow","Liquid mass flow","Vapour viscosity","Liquid viscosity","Pseudo-binary Approach","","","","","","","","Stripping factor or ratio of slope of equilibrium line to slope of operating line","Superficial velocity based on Ap","Superficial velocity based on Aa","Superficial factor","Vapour velocity through holes","Flow parameter","Clear Liquid Height","Clear Liquid Height","Dynamic liquid head at tray floor","Froth Height","Porosity","Capacity factor","Capacity factor","Flood velocity","Flood Factor","Flood Factor","General Factor in equations of Units of Mass Transfer","Fraction of holes with vapour flow","Fraction of holes with vapour flow","Jet diameter","Jet velocity","Reynolds number for vapour flow through hole","Jet Height","Residence time in Zone One","Number of vapour phase transfer units in Zone One","Small Bubble Diameter","Large Bubble Diameter","","","","","","Sauter diameters","","Eotvos Number","Morton Number","Constant h","","","Terminal velocity of small bubbles","Terminal velocity of small bubbles using Sauter diameter","Fraction of small bubbles in froth","Terminal velocity of large bubbles","","","","","Number of liquid phase transfer units in Zone Two","","Terminal velocity of large bubbles in Zone Three","Residence time in Zone Three","Number of liquid phase transfer units in Zone Three","","","","","Number of liquid phase transfer units in Zone Four","","Residence time in Zone Five","Number of liquid phase transfer units in Zone Five","Superficial velocity based on Aa in the transition point of froth regime to spay regime","Fraction of active holes that are in jetting","Fraction of active holes that are producing small bubbles","Fraction of active holes that are producing large bubbles","General Factor in equations of Units of Mass Transfer","Reynolds number of jet","Schimdt number on vapour phase","Vapour phase mass transfer coefficient in Zone One","Liquid phase mass transfer coefficient in Zone One","Number of vapour phase transfer units in Zone One","Peclet number","","","","","","","","","","","","","","","","","","Vapour phase mass transfer coefficient","","","","","","Liquid phase mass transfer coefficient","","","","","","Number of vapour phase transfer units","","","","","","Number of Vapour phase transfer units of jetting","Number of Vapour phase transfer units of large bubbles","Point Efficiency","Eddy diffusivity for liquid mixing","Peclet Number","Constant n","","","","Height on spray regime","Fraction of entrained liquid","Apparent Murphree tray efficiency","Apparent Murphree tray efficiency","Apparent Murphree tray efficiency","Apparent Murphree tray efficiency","",
			],
			[:d,:dh,:Aa,:Ah,:fi,:Ts,:T,:tray_type,:iLK,:iHK,],
			[:Qv,:Ql,:Mv,:Ml,:Miv,:Mil,:Dl,:Dv,:lambda,:m,:VinLK,:VoutLk,:LinLK,:LoutLk,:us,:ua,:fs,:uh,:fp,:hcl,:hcld,:hf,:e,:csb,:uf,:ff,:sigma,:ftm,:xf,:dj,:uj,:Reh,:hj,:tg1,:NL1,:dbs,:dbl,:sigCSB,:MilCSB,:fi3,:dbss,:dbls,:eo,:mo,:h,:j,:usb,:ubss,:aj,:ulb,:tg2s,:tg2l,:NL2S,:NL2L,:tg3,:NL3,:ulb3,:tg4s,:tg4l,:NL4S,:NL4L,:tg5,:NL5,:uatp,:fj,:flb,:fsb,:ftmg,:Rej,:Scg,:kl1,:kg1,:NG1,:Peg2s,:Peg2l,:Peg3,:Peg4s,:Peg4l,:Peg5,:Sh2s,:Sh2l,:Sh3,:Sh4s,:Sh4l,:Sh5,:kg2s,:kg2l,:kg3,:kg4s,:kg4l,:kg5,:kl2s,:kl2l,:kl3,:kl4s,:kl4l,:kl5,:NG2S,:NG2L,:NG3,:NG4S,:NG4L,:NG5,:NGFJ,:NGFLB,:EOG,:De,:Pe,:n,:Emv1,:psi,:psi1,:hb,:l,:Emv2,:Emv3,]
		)
	end
	_P1::tray
	d::length 
	dh::length 
	Aa::area 
	Ah::area 
	fi::fraction 
	Ts::length 
	T::length 
	tray_type::DanaSwitcher 
	iLK::DanaInteger 
	iHK::DanaInteger 
	Qv::flow_vol 
	Ql::flow_vol 
	Mv::flow_mass 
	Ml::flow_mass 
	Miv::viscosity 
	Mil::viscosity 
	Dl::diffusivity 
	Dv::diffusivity 
	lambda::DanaReal 
	m::DanaReal 
	VinLK::DanaReal 
	VoutLk::DanaReal 
	LinLK::DanaReal 
	LoutLk::DanaReal 
	us::velocity 
	ua::velocity 
	fs::positive 
	uh::velocity 
	fp::positive 
	hcl::length 
	hcld::length 
	hf::length 
	e::positive 
	csb::positive
	uf::velocity 
	ff::positive 
	sigma::surf_tens 
	ftm::DanaReal 
	xf::fraction 
	dj::length 
	uj::velocity 
	Reh::positive 
	hj::length 
	tg1::time_sec 
	NL1::positive 
	dbs::length 
	dbl::length 
	sigCSB::positive 
	MilCSB::positive 
	fi3::positive
	dbss::length 
	dbls::length 
	eo::positive 
	mo::positive 
	h::positive 
	j::positive 
	usb::velocity 
	ubss::velocity 
	aj::fraction 
	ulb::velocity 
	tg2s::time_sec 
	tg2l::time_sec 
	NL2S::positive 
	NL2L::positive 
	tg3::time_sec 
	NL3::positive 
	ulb3::velocity 
	tg4s::time_sec 
	tg4l::time_sec 
	NL4S::positive 
	NL4L::positive 
	tg5::time_sec 
	NL5::positive 
	uatp::velocity 
	fj::positive 
	flb::positive 
	fsb::positive 
	ftmg::positive 
	Rej::positive 
	Scg::positive 
	kl1::positive 
	kg1::positive 
	NG1::positive 
	Peg2s::positive 
	Peg2l::positive 
	Peg3::positive 
	Peg4s::positive 
	Peg4l::positive 
	Peg5::positive 
	Sh2s::positive 
	Sh2l::positive 
	Sh3::positive 
	Sh4s::positive 
	Sh4l::positive 
	Sh5::positive 
	kg2s::positive 
	kg2l::positive 
	kg3::positive 
	kg4s::positive 
	kg4l::positive 
	kg5::positive 
	kl2s::positive 
	kl2l::positive 
	kl3::positive 
	kl4s::positive 
	kl4l::positive 
	kl5::positive 
	NG2S::positive 
	NG2L::positive 
	NG3::positive 
	NG4S::positive 
	NG4L::positive 
	NG5::positive 
	NGFJ::positive 
	NGFLB::positive 
	EOG::positive 
	De::DanaReal 
	Pe::positive 
	n::DanaReal 
	Emv1::positive 
	psi::DanaReal 
	psi1::DanaReal 
	hb::length 
	l::positive 
	Emv2::positive 
	Emv3::positive 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export trayEffFund
function setEquationFlow(in::trayEffFund)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
	if NComp > 2 
		addEquation(7)
		addEquation(8)
		addEquation(9)
		addEquation(10)
	else
		addEquation(11)
		addEquation(12)
		addEquation(13)
		addEquation(14)
	end
	addEquation(15)
	addEquation(16)
	addEquation(17)
	addEquation(18)
	addEquation(19)
	addEquation(20)
	let switch=tray_type
		if switch=="Downcomer"
			addEquation(21)
		elseif switch=="Dualflow"
			addEquation(22)
		end
	end
	addEquation(23)
	addEquation(24)
	addEquation(25)
	let switch=tray_type
		if switch=="Downcomer"
			addEquation(26)
		elseif switch=="Dualflow"
			addEquation(27)
		end
	end
	addEquation(28)
	let switch=tray_type
		if switch=="Downcomer"
			addEquation(29)
		elseif switch=="Dualflow"
			addEquation(30)
		end
	end
	#Prado, Garcia and Fair Model#
	#Liquid Phase#
	addEquation(31)
	#Zone One#
	let switch=tray_type
		if switch=="Downcomer"
			addEquation(32)
		elseif switch=="Dualflow"
			addEquation(33)
		end
	end
	addEquation(34)
	addEquation(35)
	addEquation(36)
	addEquation(37)
	addEquation(38)
	addEquation(39)
	#Zone Two#
	addEquation(40)
	addEquation(41)
	if sigma > 5e-3 
		addEquation(42)
	else
		addEquation(43)
	end
	if Mil > .6e-3 
		addEquation(44)
	else
		addEquation(45)
	end
	addEquation(46)
	addEquation(47)
	addEquation(48)
	addEquation(49)
	addEquation(50)
	addEquation(51)
	if h > 59.3 
		addEquation(52)
	else
		addEquation(53)
	end
	addEquation(54)
	addEquation(55)
	addEquation(56)
	addEquation(57)
	if hf > hj 
		addEquation(58)
		addEquation(59)
	else
		addEquation(60)
		addEquation(61)
	end
	addEquation(62)
	addEquation(63)
	#Zone Three#
	addEquation(64)
	addEquation(65)
	addEquation(66)
	#Zone Four#
	if hf > dbls 
		addEquation(67)
		addEquation(68)
	else
		addEquation(69)
		addEquation(70)
	end
	addEquation(71)
	addEquation(72)
	#Zone Five#
	addEquation(73)
	addEquation(74)
	#Fraction of holes in jet regime estimation
	addEquation(75)
	addEquation(76)
	addEquation(77)
	addEquation(78)
	#Vapour Phase#
	addEquation(79)
	#Zone One#
	addEquation(80)
	addEquation(81)
	addEquation(82)
	addEquation(83)
	addEquation(84)
	#Zones Two,Three, Four and Five#
	addEquation(85)
	addEquation(86)
	addEquation(87)
	addEquation(88)
	addEquation(89)
	addEquation(90)
	if Peg2s > 200 
		addEquation(91)
	else
		addEquation(92)
	end
	if Peg2l > 200 
		addEquation(93)
	else
		addEquation(94)
	end
	if Peg3 > 200 
		addEquation(95)
	else
		addEquation(96)
	end
	if Peg4s > 200 
		addEquation(97)
	else
		addEquation(98)
	end
	if Peg4l > 200 
		addEquation(99)
	else
		addEquation(100)
	end
	if Peg5 > 200 
		addEquation(101)
	else
		addEquation(102)
	end
	addEquation(103)
	addEquation(104)
	addEquation(105)
	addEquation(106)
	addEquation(107)
	addEquation(108)
	addEquation(109)
	addEquation(110)
	addEquation(111)
	addEquation(112)
	addEquation(113)
	addEquation(114)
	addEquation(115)
	addEquation(116)
	addEquation(117)
	addEquation(118)
	addEquation(119)
	addEquation(120)
	addEquation(121)
	addEquation(122)
	addEquation(123)
	#Liquid Mixing Models#
	addEquation(124)
	addEquation(125)
	addEquation(126)
	if Pe == 0 
		addEquation(127)
	else
		if Pe < 20 
			addEquation(128)
		else
			addEquation(129)
		end
	end
	#Entrainment and Weeping Correction#
	addEquation(130)
	addEquation(131)
	let switch=tray_type
		if switch=="Downcomer"
			addEquation(132)
		elseif switch=="Dualflow"
			addEquation(133)
		end
	end
	let switch=tray_type
		if switch=="Downcomer"
			addEquation(134)
		elseif switch=="Dualflow"
			addEquation(135)
		end
	end
	addEquation(136)
end
function atributes(in::trayEffFund,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Icon]="icon/Tray"
	fields[:Brief]="Tray with Efficiency Prediction - Fundamental Model"
	fields[:Info]="==Description==
Prediciton based on Prado(1986), Gracia and Fair(2000,2002) model, with entrainment and weeping correction. 
Multicomponent mixture treated with pseudo-binary approach.

	== Options ==
You can select the tray type: with downcomer or dualflow.
	
	== References ==
*Clear Liquid Height (Downcomer): Dhulesia (1984).
*Clear Liquid Height (Dualflow): Garcia e Fair(2002).
*Froth Height: Todd & Van Winkle (1972).
*Fraction of holes with vapour flow (Downcomer): Prado (1990).
*Fraction of holes with vapour flow (Dualflow): Garcia e Fair (2002).
*Fraction of active holes that are in jetting: Prado (1987), considering fj=60% when ua=uatp.
*Capacity Factor (Downcomer): Treybal(1968).
*Capacity Factor (Dualflow): Garcia e Fair(2002).
*Flood Velocity: Fair(1961).
*Liquid Mixing Models: Lewis(1936).
*Eddy Diffusivity: Molnar(1974).
*Entrainment Correction (Downcomer): Colburn(1936).
*Fraction of entrained liquid (Downcomer): Zuiderweg(1982).

General References:
*GARCIA, J. A.; FAIR, J. R. A Fundamental Model for the Prediction of Distillation Sieve Tray Efficiency. 1. Database Development. Ind. Eng. Chem. Res., v.39, n.6, p. 1809-17,2000.
*GARCIA, J. A.; FAIR, J. R. A Fundamental Model for the Prediction of Distillation Sieve Tray Efficiency. 2. Model Development and Validation. Ind. Eng. Chem. Res., v.39, n.6, p. 1818-25,2000.
*GARCIA, J. A.; FAIR, J. R. Distillation Sieve Trays without Downcomers: Prediction of Performance Characteristics. Ind. Eng. Chem. Res., v.41, n.6, p. 1632-40,2002.
*LOCKETT, M. J. Distillation Tray Fundamentals. Cambridge: Cambridge University Press, 1986.
*PRADO, M.; FAIR, J. R. Fundamental Model for the Prediction of Sieve Tray Efficiency.  Ind. Eng. Chem. Res., v.29, n.6, p. 1031-42,1990.
"
	drive!(fields,_)
	return fields
end
trayEffFund(_::Dict{Symbol,Any})=begin
	newModel=trayEffFund()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(trayEffFund)
