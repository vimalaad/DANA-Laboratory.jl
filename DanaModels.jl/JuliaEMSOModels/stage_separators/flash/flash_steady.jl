#----------------------------------------------------------------------
#* Model of a  Steady State flash
#*---------------------------------------------------------------------
type flash_steady
	flash_steady()=begin
		PP=outers.PP
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
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
			fraction ((Symbol=>Any)[
				:Brief=>"Vapourization fraction",
				:Symbol=>"\\phi"
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
				:([vfrac, OutletL.z, OutletV.z] = PP.Flash(OutletV.T, OutletV.P, Inlet.z)),
				:(Inlet.F = OutletV.F + OutletL.F),
				:(OutletV.F = Inlet.F * vfrac),
				:(Inlet.F*Inlet.h + InletQ.Q = OutletL.F*OutletL.h + OutletV.F*OutletV.h),
				:(OutletV.T = OutletL.T),
				:(OutletV.P = OutletL.P),
				:(OutletL.P = Inlet.P - Pdrop),
				:(OutletL.P = Inlet.P * Pratio),
			],
			[
				"The flash calculation","Global Molar Balance","Vaporization Fraction","Energy Balance","Thermal Equilibrium","Mechanical Equilibrium","Pressure Drop","Pressure Ratio",
			],
			[:PP,],
			[:Inlet,:OutletL,:OutletV,:InletQ,:vfrac,:Pratio,:Pdrop,]
		)
	end
	PP::DanaPlugin
	Inlet::stream
	OutletL::liquid_stream
	OutletV::vapour_stream
	InletQ::energy_stream 
	vfrac::fraction 
	Pratio::positive 
	Pdrop::press_delta 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export flash_steady
function setEquationFlow(in::flash_steady)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
	addEquation(7)
	addEquation(8)
end
function atributes(in::flash_steady,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Flash"
	fields[:Brief]="Model of a Steady State flash."
	fields[:Info]="== Assumptions ==
* both phases are perfectly mixed.
	
== Specify ==
* the feed stream;
* the outlet pressure (OutletV.P);
* the outlet temperature OR the heat supplied.
"
	drive!(fields,_)
	return fields
end
flash_steady(_::Dict{Symbol,Any})=begin
	newModel=flash_steady()
	newModel.attributes=atributes(newModel,_)
	newModel
end
