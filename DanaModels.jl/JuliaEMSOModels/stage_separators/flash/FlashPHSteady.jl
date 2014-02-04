#----------------------------------------------------------------------
#* Model of a steady-state PH flash.
#*---------------------------------------------------------------------
type FlashPHSteady
	FlashPHSteady()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger(),
			stream((Symbol=>Any)[
				:Brief=>"Feed Stream",
				:PosX=>0,
				:PosY=>0.5421,
				:Symbol=>"_{in}"
			]),
			liquid_stream((Symbol=>Any)[
				:Brief=>"Liquid outlet stream",
				:PosX=>0.4790,
				:PosY=>1,
				:Symbol=>"_{outL}"
			]),
			vapour_stream((Symbol=>Any)[
				:Brief=>"Vapour outlet stream",
				:PosX=>0.4877,
				:PosY=>0,
				:Symbol=>"_{outV}"
			]),
			energy_stream ((Symbol=>Any)[
				:Brief=>"Rate of heat supply",
				:PosX=>1,
				:PosY=>0.7559,
				:Symbol=>"_{in}"
			]),
			fraction((Symbol=>Any)[
				:Brief=>"Vaporization fraction",
				:Symbol=>"\\phi"
			]),
			enth_mol((Symbol=>Any)[
				:Brief=>"Mixture enthalpy"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Pressure Ratio",
				:Symbol=>"P_{ratio}"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Pressure Drop",
				:DisplayUnit=>"kPa",
				:Symbol=>"\\Delta P"
			]),
			[
				:([vfrac,OutletL.z,OutletV.z]=PP.FlashPH(OutletL.P,h,Inlet.z)),
				:(Inlet.F = OutletV.F + OutletL.F),
				:(OutletV.F = Inlet.F * vfrac),
				:(Inlet.F*(h - Inlet.h) = InletQ.Q),
				:(Inlet.F*h = Inlet.F*(1-vfrac)*OutletL.h + Inlet.F*vfrac*OutletV.h),
				:(OutletV.T = OutletL.T),
				:(OutletV.P = OutletL.P),
				:(OutletL.P = Inlet.P - Pdrop),
				:(OutletL.P = Inlet.P * Pratio),
			],
			[
				"Chemical equilibrium","Global Molar Balance","","Energy Balance","","Thermal Equilibrium","Mechanical Equilibrium","Pressure Drop","Pressure Ratio",
			],
			[:PP,:NComp,],
			[:Inlet,:OutletL,:OutletV,:InletQ,:vfrac,:h,:Pratio,:Pdrop,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	Inlet::stream
	OutletL::liquid_stream
	OutletV::vapour_stream
	InletQ::energy_stream 
	vfrac::fraction
	h::enth_mol
	Pratio::positive 
	Pdrop::press_delta 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export FlashPHSteady
function setEquationFlow(in::FlashPHSteady)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
	addEquation(7)
	addEquation(8)
	addEquation(9)
end
function atributes(in::FlashPHSteady,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Flash"
	fields[:Brief]="Model of a static PH flash."
	fields[:Info]="This model is for using the flashPH routine available on VRTherm.

== Assumptions ==
* perfect mixing of both phases;

== Specify ==
* the feed stream;
* the heat duty;
* the outlet pressure.
"
	drive!(fields,_)
	return fields
end
FlashPHSteady(_::Dict{Symbol,Any})=begin
	newModel=FlashPHSteady()
	newModel.attributes=atributes(newModel,_)
	newModel
end
