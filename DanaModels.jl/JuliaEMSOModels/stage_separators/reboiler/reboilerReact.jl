#-------------------------------------------------------------------
#* Model of a dynamic reboiler with reaction
#*-------------------------------------------------------------------
type reboilerReact
	reboilerReact()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin((Symbol=>Any)[
				:Type=>"PP"
			]),
			DanaInteger(),
			area ((Symbol=>Any)[
				:Brief=>"Cross Section Area of reboiler"
			]),
			volume ((Symbol=>Any)[
				:Brief=>"Total volume of reboiler"
			]),
			fill(DanaReal((Symbol=>Any)[
				:Brief=>"Stoichiometric matrix"
			]),(NComp)),
			energy_mol(),
			pressure(),
			stream((Symbol=>Any)[
				:Brief=>"Feed Stream",
				:PosX=>0.8127,
				:PosY=>0,
				:Symbol=>"_{in}"
			]),
			stream((Symbol=>Any)[
				:Brief=>"Liquid inlet stream",
				:PosX=>0,
				:PosY=>0.5254,
				:Symbol=>"_{inL}"
			]),
			liquid_stream((Symbol=>Any)[
				:Brief=>"Liquid outlet stream",
				:PosX=>0.2413,
				:PosY=>1,
				:Symbol=>"_{outL}"
			]),
			vapour_stream((Symbol=>Any)[
				:Brief=>"Vapour outlet stream",
				:PosX=>0.5079,
				:PosY=>0,
				:Symbol=>"_{outV}"
			]),
			energy_stream ((Symbol=>Any)[
				:Brief=>"Heat supplied",
				:PosX=>1,
				:PosY=>0.6123,
				:Symbol=>"_{in}"
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
				:Brief=>"Level of liquid phase"
			]),
			volume(),
			DanaReal(),
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
				:(r3 = exp(-7150*"K"/OutletL.T)*(4.85e4*C(1)*C(2) - 1.23e4*C(3)*C(4)) * "l/mol/s"),
				:(diff(M)= Inlet.F*Inlet.z + InletL.F*InletL.z - OutletL.F*OutletL.z - OutletV.F*OutletV.z + stoic*r3*ML*vL),
				:(diff(E) = Inlet.F*Inlet.h + InletL.F*InletL.h - OutletL.F*OutletL.h - OutletV.F*OutletV.h + InletQ.Q + Hr * r3 * vL*ML),
				:(M = ML*OutletL.z + MV*OutletV.z),
				:(E = ML*OutletL.h + MV*OutletV.h - OutletL.P*V),
				:(sum(OutletL.z)=1.0),
				:(vL = PP.LiquidVolume(OutletL.T, OutletL.P, OutletL.z)),
				:(vV = PP.VapourVolume(OutletV.T, OutletV.P, OutletV.z)),
				:(rhoV = PP.VapourDensity(OutletV.T, OutletV.P, OutletV.z)),
				:(Level = ML*vL/Across),
				:(Vol = ML*vL),
				:(OutletL.P = OutletV.P),
				:(OutletL.T = OutletV.T),
				:(V = ML*vL + MV*vV),
				:(PP.LiquidFugacityCoefficient(OutletL.T, OutletL.P, OutletL.z)*OutletL.z = PP.VapourFugacityCoefficient(OutletV.T, OutletV.P, OutletV.z)*OutletV.z),
				:(sum(OutletL.z)=sum(OutletV.z)),
			],
			[
				"Molar Concentration","Reaction","Component Molar Balance","Energy Balance","Molar Holdup","Energy Holdup","Mol fraction normalisation","Liquid Volume","Vapour Volume","Vapour Density","Level of liquid phase","","Mechanical Equilibrium","Thermal Equilibrium","Geometry Constraint","Chemical Equilibrium","",
			],
			[:PP,:NComp,:Across,:V,:stoic,:Hr,:Pstartup,],
			[:Inlet,:InletL,:OutletL,:OutletV,:InletQ,:M,:ML,:MV,:E,:vL,:vV,:Level,:Vol,:startup,:rhoV,:r3,:C,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	Across::area 
	V::volume 
	stoic::Array{DanaReal}
	Hr::energy_mol
	Pstartup::pressure
	Inlet::stream
	InletL::stream
	OutletL::liquid_stream
	OutletV::vapour_stream
	InletQ::energy_stream 
	M::Array{mol }
	ML::mol 
	MV::mol 
	E::energy 
	vL::volume_mol 
	vV::volume_mol 
	Level::length 
	Vol::volume
	startup::DanaReal
	rhoV::dens_mass
	r3::reaction_mol 
	C::Array{conc_mol }
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export reboilerReact
function setEquationFlow(in::reboilerReact)
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
end
function atributes(in::reboilerReact,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Reboiler"
	fields[:Brief]="Model of a dynamic reboiler with reaction."
	fields[:Info]="== Assumptions ==
* perfect mixing of both phases;
* thermodynamics equilibrium;
* no liquid entrainment in the vapour stream;
* the reaction takes place only in the liquid phase.
	
== Specify ==
* the kinetics variables;
* the inlet stream;
* the liquid inlet stream;
* the outlet flows: OutletV.F and OutletL.F;
* the heat supply.

== Initial Conditions ==
* the reboiler temperature (OutletL.T);
* the reboiler liquid level (Level);
* (NoComps - 1) OutletL (OR OutletV) compositions.
"
	drive!(fields,_)
	return fields
end
reboilerReact(_::Dict{Symbol,Any})=begin
	newModel=reboilerReact()
	newModel.attributes=atributes(newModel,_)
	newModel
end
