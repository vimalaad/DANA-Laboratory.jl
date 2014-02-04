#----------------------------------------------------------------------
#* Model of a  Steady State condenser with no thermodynamics equilibrium
#*---------------------------------------------------------------------
type condenserSteady
	condenserSteady()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger(),
			stream((Symbol=>Any)[
				:Brief=>"Vapour inlet stream",
				:PosX=>0.3431,
				:PosY=>0,
				:Symbol=>"_{inV}"
			]),
			liquid_stream((Symbol=>Any)[
				:Brief=>"Liquid outlet stream",
				:PosX=>0.34375,
				:PosY=>1,
				:Symbol=>"_{outL}"
			]),
			energy_stream ((Symbol=>Any)[
				:Brief=>"Cold supplied",
				:PosX=>1,
				:PosY=>0.5974,
				:Symbol=>"_{in}"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Pressure Drop in the condenser"
			]),
			[
				:(InletV.F = OutletL.F),
				:(InletV.z = OutletL.z),
				:(InletV.F*InletV.h = OutletL.F*OutletL.h + InletQ.Q),
				:(DP = InletV.P - OutletL.P),
			],
			[
				"Molar Balance","","Energy Balance","Pressure",
			],
			[:PP,:NComp,],
			[:InletV,:OutletL,:InletQ,:DP,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	InletV::stream
	OutletL::liquid_stream
	InletQ::energy_stream 
	DP::press_delta 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export condenserSteady
function setEquationFlow(in::condenserSteady)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
end
function atributes(in::condenserSteady,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/CondenserSteady"
	fields[:Brief]="Model of a  Steady State condenser with no thermodynamics equilibrium."
	fields[:Info]="== Assumptions ==
* perfect mixing of both phases;
* no thermodynamics equilibrium.
	
== Specify ==
* the inlet stream;
* the pressure drop in the condenser;
* the heat supply.
"
	drive!(fields,_)
	return fields
end
condenserSteady(_::Dict{Symbol,Any})=begin
	newModel=condenserSteady()
	newModel.attributes=atributes(newModel,_)
	newModel
end
