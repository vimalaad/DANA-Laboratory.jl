#-------------------------------------------------------------------
#* Model of a tray with reaction
#*-------------------------------------------------------------------
type trayReact
	trayReact()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin((Symbol=>Any)[
				:Type=>"PP"
			]),
			DanaInteger(),
			volume((Symbol=>Any)[
				:Brief=>"Total Volume of the tray"
			]),
			power ((Symbol=>Any)[
				:Brief=>"Rate of heat supply"
			]),
			area ((Symbol=>Any)[
				:Brief=>"Plate area = Atray - Adowncomer"
			]),
			area ((Symbol=>Any)[
				:Brief=>"Total holes area"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Weir length"
			]),
			acceleration ((Symbol=>Any)[
				:Default=>9.81
			]),
			length ((Symbol=>Any)[
				:Brief=>"Weir height"
			]),
			fraction ((Symbol=>Any)[
				:Brief=>"Aeration fraction"
			]),
			fraction ((Symbol=>Any)[
				:Brief=>"Dry pressure drop coefficient"
			]),
			fill(DanaReal((Symbol=>Any)[
				:Brief=>"Stoichiometric matrix"
			]),(NComp)),
			energy_mol(),
			pressure(),
			DanaSwitcher((Symbol=>Any)[
				:Valid=>["on", "off"],
				:Default=>"off"
			]),
			DanaSwitcher((Symbol=>Any)[
				:Valid=>["on", "off"],
				:Default=>"off"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Feed stream",
				:PosX=>0,
				:PosY=>0.4932,
				:Symbol=>"_{in}"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet liquid stream",
				:PosX=>0.5195,
				:PosY=>0,
				:Symbol=>"_{inL}"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet vapour stream",
				:PosX=>0.4994,
				:PosY=>1,
				:Symbol=>"_{inV}"
			]),
			liquid_stream ((Symbol=>Any)[
				:Brief=>"Outlet liquid stream",
				:PosX=>0.8277,
				:PosY=>1,
				:Symbol=>"_{outL}"
			]),
			vapour_stream ((Symbol=>Any)[
				:Brief=>"Outlet vapour stream",
				:PosX=>0.8043,
				:PosY=>0,
				:Symbol=>"_{outV}"
			]),
			fill(fraction()),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Murphree efficiency"
			]),
			fill(mol ((Symbol=>Any)[
				:Brief=>"Molar Holdup in the tray"
			]),(NComp)),
			mol ((Symbol=>Any)[
				:Brief=>"Molar liquid holdup"
			]),
			mol ((Symbol=>Any)[
				:Brief=>"Molar vapour holdup"
			]),
			energy ((Symbol=>Any)[
				:Brief=>"Total Energy Holdup on tray"
			]),
			volume_mol ((Symbol=>Any)[
				:Brief=>"Liquid Molar Volume"
			]),
			volume_mol ((Symbol=>Any)[
				:Brief=>"Vapour Molar volume"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Height of clear liquid on plate"
			]),
			volume(),
			dens_mass(),
			dens_mass(),
			reaction_mol ((Symbol=>Any)[
				:Brief=>"Reaction resulting ethyl acetate",
				:DisplayUnit=>"mol/l/s"
			]),
			fill(conc_mol ((Symbol=>Any)[
				:Brief=>"Molar concentration",
				:Lower=>-1
			]),(NComp)),
			[
				:(OutletL.z = vL * C),
				:(r3 = exp(-7150*"K"/OutletL.T)*(4.85e4*C(1)*C(2) - 1.23e4*C(3)*C(4))*"l/mol/s"),
				:(diff(M)=Inlet.F*Inlet.z + InletL.F*InletL.z + InletV.F*InletV.z - OutletL.F*OutletL.z - OutletV.F*OutletV.z + stoic*r3*ML*vL),
				:(diff(E) = ( Inlet.F*Inlet.h + InletL.F*InletL.h + InletV.F*InletV.h - OutletL.F*OutletL.h - OutletV.F*OutletV.h + Q ) + Hr * r3 * vL*ML),
				:(M = ML*OutletL.z + MV*OutletV.z),
				:(E = ML*OutletL.h + MV*OutletV.h - OutletL.P*V),
				:(sum(OutletL.z)= 1.0),
				:(vL = PP.LiquidVolume(OutletL.T, OutletL.P, OutletL.z)),
				:(vV = PP.VapourVolume(OutletV.T, OutletV.P, OutletV.z)),
				:(OutletV.T = OutletL.T),
				:(OutletV.P = OutletL.P),
				:(Level = ML*vL/Ap),
				:(Vol = ML*vL),
				:(rhoL = PP.LiquidDensity(OutletL.T, OutletL.P, OutletL.z)),
				:(rhoV = PP.VapourDensity(InletV.T, InletV.P, InletV.z)),
				:(OutletL.F*vL = 1.84*"1/s"*lw*((Level-(beta*hw)+1e-6*"m")/(beta))^2),
				:(OutletL.F = 0 * "mol/h"),
				:(InletV.F*vV = sqrt((InletV.P - OutletV.P - Level*g*rhoL + 1e-8 * "atm")/(rhoV*alfa))*Ah),
				:(InletV.F = 0 * "mol/s"),
				:(PP.LiquidFugacityCoefficient(OutletL.T, OutletL.P, OutletL.z)*OutletL.z = PP.VapourFugacityCoefficient(OutletV.T, OutletV.P, yideal)*yideal),
				:(OutletV.z = Emv * (yideal - InletV.z) + InletV.z),
				:(sum(OutletL.z)= sum(OutletV.z)),
				:(V = ML* vL + MV*vV),
			],
			[
				"Molar Concentration","Reaction","Component Molar Balance","Energy Balance","Molar Holdup","Energy Holdup","Mol fraction normalisation","Liquid Volume","Vapour Volume","Thermal Equilibrium","Mechanical Equilibrium","Level of clear liquid over the weir","","Liquid Density","Vapour Density","Francis Equation","Low level","","","Chemical Equilibrium","","","Geometry Constraint",
			],
			[:PP,:NComp,:V,:Q,:Ap,:Ah,:lw,:g,:hw,:beta,:alfa,:stoic,:Hr,:Pstartup,:VapourFlow,:LiquidFlow,],
			[:Inlet,:InletL,:InletV,:OutletL,:OutletV,:yideal,:Emv,:M,:ML,:MV,:E,:vL,:vV,:Level,:Vol,:rhoL,:rhoV,:r3,:C,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	V::volume
	Q::power 
	Ap::area 
	Ah::area 
	lw::length 
	g::acceleration 
	hw::length 
	beta::fraction 
	alfa::fraction 
	stoic::Array{DanaReal}
	Hr::energy_mol
	Pstartup::pressure
	VapourFlow::DanaSwitcher
	LiquidFlow::DanaSwitcher
	Inlet::stream 
	InletL::stream 
	InletV::stream 
	OutletL::liquid_stream 
	OutletV::vapour_stream 
	yideal::Array{fraction}
	Emv::DanaReal 
	M::Array{mol }
	ML::mol 
	MV::mol 
	E::energy 
	vL::volume_mol 
	vV::volume_mol 
	Level::length 
	Vol::volume
	rhoL::dens_mass
	rhoV::dens_mass
	r3::reaction_mol 
	C::Array{conc_mol }
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export trayReact
function setEquationFlow(in::trayReact)
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
	let switch=LiquidFlow
		if LiquidFlow==Level < (beta * hw)
			set(switch,"off")
		end
		if LiquidFlow==Level > (beta * hw) + 1e-6*"m"
			set(switch,"on")
		end
		if switch=="on"
			addEquation(16)
		elseif switch=="off"
			addEquation(17)
		end
	end
	let switch=VapourFlow
		if VapourFlow==InletV.P < OutletV.P + Level*g*rhoL
			set(switch,"off")
		end
		if VapourFlow==InletV.P > OutletV.P + Level*g*rhoL + 3e-2 * "atm"
			set(switch,"on")
		end
		if switch=="on"
			#InletV.P = OutletV.P + Level*g*rhoL + rhoV*alfa*(InletV.F*vV/Ah)^2;
			addEquation(18)
		elseif switch=="off"
			addEquation(19)
			#when InletV.P > OutletV.P + Level*beta*g*rhoL + 1e-2 * 'atm' switchto "on";
			
		end
	end
	addEquation(20)
	addEquation(21)
	addEquation(22)
	addEquation(23)
end
function atributes(in::trayReact,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Icon]="icon/Tray"
	fields[:Brief]="Model of a tray with reaction."
	fields[:Info]="== Assumptions ==
* both phases (liquid and vapour) exists all the time;
* thermodymanic equilibrium with Murphree plate efficiency;
* no entrainment of liquid or vapour phase;
* no weeping;
* the dymanics in the downcomer are neglected.
	
== Specify ==
* the Feed stream;
* the Liquid inlet stream;
* the Vapour inlet stream;
* the Vapour outlet flow (OutletV.F);
* the reaction related variables.
	
== Initial ==
* the plate temperature (OutletL.T)
* the liquid height (Level) OR the liquid flow OutletL.F
* (NoComps - 1) OutletL compositions
"
	drive!(fields,_)
	return fields
end
trayReact(_::Dict{Symbol,Any})=begin
	newModel=trayReact()
	newModel.attributes=atributes(newModel,_)
	newModel
end
