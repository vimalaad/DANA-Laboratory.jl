#-------------------------------------------------------------------
#* Models of tray with Efficiency Prediction
#* Author: Josias J. Junges
#*-------------------------------------------------------------------
type trayEffEmp
	trayEffEmp()=begin
		iLK=outers.iLK
		iHK=outers.iHK
		new(
			tray(),
			length ((Symbol=>Any)[
				:Brief=>"Liquid flow path length"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Plate Diameter"
			]),
			area ((Symbol=>Any)[
				:Brief=>"Active Area or Bubbling Area = Atray - 2*Adowncomer"
			]),
			fraction ((Symbol=>Any)[
				:Brief=>"Fractional perforated tray area(hole area/ bubbling area)"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Tray spacing"
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
				:Brief=>"Vapour mass flow",
				:Lower=>0
			]),
			flow_mass ((Symbol=>Any)[
				:Brief=>"Liquid mass flow",
				:Lower=>0
			]),
			diffusivity ((Symbol=>Any)[
				:Brief=>"Diffusivity on Vapour Phase"
			]),
			diffusivity ((Symbol=>Any)[
				:Brief=>"Diffusivity on Liquid Phase"
			]),
			surf_tens ((Symbol=>Any)[
				:Brief=>"Surface Tension"
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"Superficial velocity based on Aa"
			]),
			positive((Symbol=>Any)[
				:Brief=>"Superficial factor",
				:Unit=>"kg^.5/m^.5/s"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Constant in eq. of Clear Liquid Height"
			]),
			fraction ((Symbol=>Any)[
				:Brief=>"Effective liquid volume fraction"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Clear Liquid Height"
			]),
			time_sec ((Symbol=>Any)[
				:Brief=>"Mean residence time of vapour in dispersion"
			]),
			time_sec ((Symbol=>Any)[
				:Brief=>"Mean residence time of liquid on tray"
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"Superficial velocity based on Ap"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Flow Parameter"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Capacity Factor"
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"Flood velocity"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Flood factor"
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
			positive ((Symbol=>Any)[
				:Brief=>"Number of vapour phase transfer units"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Number of liquid phase transfer units"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Number of overall vapour phase transfer units"
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
			length ((Symbol=>Any)[
				:Brief=>"Height on spray regime"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Fraction of entrained liquid"
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"Gas velocity through holes"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Apparent Murphree tray efficiency"
			]),
			[
				:(Qv=_P1._P1.OutletV.F*_P1._P1.vV),
				:(Ql=_P1._P1.OutletL.F*_P1._P1.vL),
				:(Mv=Qv*rhoV),
				:(Ml=Ql*rhoL),
				:(ua=Qv/Aa),
				:(fs=ua*rhoV^.5),
				:(c=.5+0.438*exp(-137.8*"1/m"*_P1.hw)),
				:(ae=exp(-12.55*(ua*"s/m"*(rhoV/(rhoL-rhoV))^0.5)^0.91)),
				:(hcl=ae*(_P1.hw*"1/m"+c*((Ql*"s/m^3")/(_P1.lw*"1/m"*ae))^.67)*"m"),
				:(tv=(1-ae)*hcl/(ae*ua)),
				:(tl=hcl*z*_P1.lw/Ql),
				:(us*_P1._P1.Ap=Qv),
				:((fp*Mv)^2*rhoL=Ml^2*rhoV),
				:(csb=(0.0744*Ts*"1/m"+0.0117)*(log(abs(1/fp)))+0.0304*Ts*"1/m"+0.0153),
				:(uf = csb*(sigma*"1/(N/m)"/0.02)^.2*(abs((rhoL-rhoV)/rhoV))^.5*(fi/.1)^.44*"m/s"),
				:(ff*uf=us),
				:(VinLK=_P1._P1.InletV.z(iLK)/(_P1._P1.InletV.z(iLK)+_P1._P1.InletV.z(iHK))),
				:(VoutLk=_P1._P1.OutletV.z(iLK)/(_P1._P1.OutletV.z(iLK)+_P1._P1.OutletV.z(iHK))),
				:(LinLK=_P1._P1.InletL.z(iLK)/(_P1._P1.InletL.z(iLK)+_P1._P1.InletL.z(iHK))),
				:(LoutLk=_P1._P1.OutletL.z(iLK)/(_P1._P1.OutletL.z(iLK)+_P1._P1.OutletL.z(iHK))),
				:(VinLK=1),
				:(VoutLk=1),
				:(LinLK=1),
				:(LoutLk=1),
				:(lambda=m*(_P1._P1.OutletV.F/_P1._P1.OutletL.F)),
				:(NV*(abs(hcl)*"1/m")^.5=(10300-8670*ff)*ff*(Dv*"s/m^2")^0.5*tv*"1/s"),
				:(NL=19700*((Dl*"s/m^2")^.5)*(.4*fs*"1/(kg^.5/m^.5/s)"+.17)*tl*"1/s"),
				:(NV*NL=NOG*(NL+lambda*NV)),
				:(EOG=1-exp(-NOG)),
				:(De=(0.0005+0.01285*ua*"s/m"+6.32*(Ql*"s/m^3"/(_P1.lw*"1/m"))+0.312*_P1.hw*"1/m")^2),
				:(Pe=(_P1._P1.OutletL.F*d)/(_P1.lw*hcl*(1/_P1._P1.vL)*De*"m^2/s")),
				:(n=Pe/2*((1+4*lambda*EOG/Pe)^.5-1)),
				:(Emv1=EOG),
				:(Emv1/EOG=(1-exp(-(n+Pe)))/((n+Pe)*(1+(n+Pe)/n))+(exp(n)-1)/(n*(1+n/(n+Pe)))),
				:(lambda*Emv1=(exp(lambda*EOG)-1)),
				:(hb=hcl*(265*((ua/(g*hcl)^.5)*(rhoV/rhoL)^.5)^1.7+1)),
				:(uh=Qv/_P1.Ah),
				:(l=1e-8*(hb/Ts)^3*(uh/(Ql/Aa))^2),
				:(Emv1=Emv2*(1+l*Emv1)),
				:(_P1._P1.Emv=Emv2),
			],
			[
				"Vapour Volumetric Flow","Liquid Volumetric Flow","Vapour Mass Flow","Liquid Mass Flow","Superficial Velocity","Superficial Factor","Constant c","Effective liquid volume fraction","Clear Liquid Height","Mean residence time of vapour in dispersion","Mean residence time of liquid on tray","Superficial velocity based on Ap","Flow Parameter","Capacity Factor","Flood velocity","Flood Factor","Pseudo-binary Approach","","","","","","","","Stripping factor or ratio of slope of equilibrium line to slope of operating line","Number of vapour phase transfer units","Number of liquid phase transfer units","Number of overall vapour phase transfer units","Point Efficiency","Eddy diffusivity for liquid mixing","Peclet Number","Constant n","","","","Height on spray regime","Gas velocity through hole","Fraction of entrained liquid","Apparent Murphree tray efficiency","",
			],
			[:z,:d,:Aa,:fi,:Ts,:iLK,:iHK,],
			[:Qv,:Ql,:Mv,:Ml,:Dv,:Dl,:sigma,:ua,:fs,:c,:ae,:hcl,:tv,:tl,:us,:fp,:csb,:uf,:ff,:lambda,:m,:VinLK,:VoutLk,:LinLK,:LoutLk,:NV,:NL,:NOG,:EOG,:De,:Pe,:n,:Emv1,:hb,:l,:uh,:Emv2,]
		)
	end
	_P1::tray
	z::length 
	d::length 
	Aa::area 
	fi::fraction 
	Ts::length 
	iLK::DanaInteger 
	iHK::DanaInteger 
	Qv::flow_vol 
	Ql::flow_vol 
	Mv::flow_mass 
	Ml::flow_mass 
	Dv::diffusivity 
	Dl::diffusivity 
	sigma::surf_tens 
	ua::velocity 
	fs::positive
	c::positive 
	ae::fraction 
	hcl::length 
	tv::time_sec 
	tl::time_sec 
	us::velocity 
	fp::positive 
	csb::positive 
	uf::velocity 
	ff::positive 
	lambda::DanaReal 
	m::DanaReal 
	VinLK::DanaReal 
	VoutLk::DanaReal 
	LinLK::DanaReal 
	LoutLk::DanaReal 
	NV::positive 
	NL::positive 
	NOG::positive 
	EOG::positive 
	De::DanaReal 
	Pe::positive 
	n::DanaReal 
	Emv1::positive 
	hb::length 
	l::positive 
	uh::velocity 
	Emv2::positive 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export trayEffEmp
function setEquationFlow(in::trayEffEmp)
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
	if NComp > 2 
		addEquation(17)
		addEquation(18)
		addEquation(19)
		addEquation(20)
	else
		addEquation(21)
		addEquation(22)
		addEquation(23)
		addEquation(24)
	end
	addEquation(25)
	#Chan e Fair(1984) Model#
	addEquation(26)
	addEquation(27)
	addEquation(28)
	addEquation(29)
	#Liquid Mixing Models#
	addEquation(30)
	addEquation(31)
	addEquation(32)
	if Pe == 0 
		addEquation(33)
	else
		if Pe < 20 
			addEquation(34)
		else
			addEquation(35)
		end
	end
	#Entrainment Correction#
	addEquation(36)
	addEquation(37)
	addEquation(38)
	addEquation(39)
	addEquation(40)
end
function atributes(in::trayEffEmp,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Icon]="icon/Tray"
	fields[:Brief]="Tray with Efficiency Prediction - Empiric Model"
	fields[:Info]="==Description==
Prediciton based on Chan e Fair(1984) model, with entrainment correction. 
Multicomponent mixture treated with pseudo-binary approach.
	
	== References ==
*Clear Liquid Height: Bennett et al. (1983).
*Capacity Factor: Treybal(1968).
*Flood Velocity: Fair(1961).
*Liquid Mixing Models: Lewis(1936).
*Eddy Diffusivity: Molnar(1974).
*Entrainment Correction: Colburn(1936).
*Fraction of entrained liquid: Zuiderweg(1982).

General References:
*CHAN, H.;FAIR, J. R. Prediction of Point Efficiencies on Sieve Trays. 1. Binary Systems. Ind. Eng. Chem. Process Des. Dev., v.23, n.4, p.814-9, 1984.
*LOCKETT, M. J. Distillation Tray Fundamentals. Cambridge: Cambridge University Press, 1986.
"
	drive!(fields,_)
	return fields
end
trayEffEmp(_::Dict{Symbol,Any})=begin
	newModel=trayEffEmp()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(trayEffEmp)
