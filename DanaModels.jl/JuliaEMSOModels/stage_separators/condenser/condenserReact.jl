#-------------------------------------------------------------------
#* Condenser with reaction in liquid phase
#*--------------------------------------------------------------------
type condenserReact
	condenserReact()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin((Symbol=>Any)[
				:Type=>"PP"
			]),
			DanaInteger(),
			volume ((Symbol=>Any)[
				:Brief=>"Condenser total volume"
			]),
			area ((Symbol=>Any)[
				:Brief=>"Cross Section Area of reboiler"
			]),
			fill(DanaReal((Symbol=>Any)[
				:Brief=>"Stoichiometric matrix"
			]),(NComp)),
			energy_mol(),
			pressure(),
			stream((Symbol=>Any)[
				:Brief=>"Vapour inlet stream",
				:PosX=>0.1164,
				:PosY=>0,
				:Symbol=>"_{inV}"
			]),
			liquid_stream((Symbol=>Any)[
				:Brief=>"Liquid outlet stream",
				:PosX=>0.4513,
				:PosY=>1,
				:Symbol=>"_{outL}"
			]),
			vapour_stream((Symbol=>Any)[
				:Brief=>"Vapour outlet stream",
				:PosX=>0.4723,
				:PosY=>0,
				:Symbol=>"_{outV}"
			]),
			energy_stream ((Symbol=>Any)[
				:Brief=>"Cold supplied",
				:PosX=>1,
				:PosY=>0.6311,
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
				:(diff(M) = InletV.F*InletV.z - OutletL.F*OutletL.z - OutletV.F*OutletV.z + stoic*r3*ML*vL),
				:(diff(E) = InletV.F*InletV.h - OutletL.F*OutletL.h - OutletV.F*OutletV.h + InletQ.Q + Hr * r3 * ML*vL),
				:(M = ML*OutletL.z + MV*OutletV.z),
				:(E = ML*OutletL.h + MV*OutletV.h - OutletV.P*V),
				:(sum(OutletL.z)=1.0),
				:(vL = PP.LiquidVolume(OutletL.T, OutletL.P, OutletL.z)),
				:(vV = PP.VapourVolume(OutletV.T, OutletV.P, OutletV.z)),
				:(OutletL.T = OutletV.T),
				:(OutletV.P = OutletL.P),
				:(V = ML*vL + MV*vV),
				:(Vol = ML*vL),
				:(Level = ML*vL/Across),
				:(PP.LiquidFugacityCoefficient(OutletL.T, OutletL.P, OutletL.z)*OutletL.z = PP.VapourFugacityCoefficient(OutletV.T, OutletV.P, OutletV.z)*OutletV.z),
				:(sum(OutletL.z)=sum(OutletV.z)),
			],
			[
				"Molar Concentration","Reaction","Component Molar Balance","Energy Balance","Molar Holdup","Energy Holdup","Mol fraction normalisation","Liquid Volume","Vapour Volume","Thermal Equilibrium","Mechanical Equilibrium","Geometry Constraint","","Level of liquid phase","Chemical Equilibrium","",
			],
			[:PP,:NComp,:V,:Across,:stoic,:Hr,:Pstartup,],
			[:InletV,:OutletL,:OutletV,:InletQ,:M,:ML,:MV,:E,:vL,:vV,:Level,:Vol,:r3,:C,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	V::volume 
	Across::area 
	stoic::Array{DanaReal}
	Hr::energy_mol
	Pstartup::pressure
	InletV::stream
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
	r3::reaction_mol 
	C::Array{conc_mol }
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export condenserReact
function setEquationFlow(in::condenserReact)
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
end
function atributes(in::condenserReact,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Condenser"
	fields[:Brief]="Model of a Condenser with reaction in liquid phase."
	fields[:Info]="== Assumptions ==
* perfect mixing of both phases;
* thermodynamics equilibrium;
* the reaction only takes place in liquid phase.
	
== Specify ==
* the reaction related variables;
* the inlet stream;
* the outlet flows: OutletV.F and OutletL.F;
* the heat supply.

== Initial Conditions ==
* the condenser temperature (OutletL.T);
* the condenser liquid level (Level);
* (NoComps - 1) OutletL (OR OutletV) compositions.
"
	drive!(fields,_)
	return fields
end
condenserReact(_::Dict{Symbol,Any})=begin
	newModel=condenserReact()
	newModel.attributes=atributes(newModel,_)
	newModel
end
