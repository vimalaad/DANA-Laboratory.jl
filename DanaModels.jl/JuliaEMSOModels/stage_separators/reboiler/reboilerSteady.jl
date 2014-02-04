#----------------------------------------------------------------------
#* Model of a  Steady State reboiler with no thermodynamics equilibrium
#*---------------------------------------------------------------------
type reboilerSteady
	reboilerSteady()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger(),
			press_delta ((Symbol=>Any)[
				:Brief=>"Pressure Drop in the reboiler"
			]),
			stream((Symbol=>Any)[
				:Brief=>"Liquid inlet stream",
				:PosX=>0.3345,
				:PosY=>1,
				:Symbol=>"_{inL}"
			]),
			vapour_stream((Symbol=>Any)[
				:Brief=>"Vapour outlet stream",
				:PosX=>0.3369,
				:PosY=>0,
				:Symbol=>"_{outV}"
			]),
			energy_stream ((Symbol=>Any)[
				:Brief=>"Heat supplied",
				:PosX=>1,
				:PosY=>0.6111,
				:Symbol=>"_{in}"
			]),
			volume_mol ((Symbol=>Any)[
				:Brief=>"Vapour Molar volume"
			]),
			dens_mass ((Symbol=>Any)[
				:Brief=>"Vapour Density"
			]),
			[
				:(InletL.F = OutletV.F),
				:(InletL.z = OutletV.z),
				:(vV = PP.VapourVolume(OutletV.T, OutletV.P, OutletV.z)),
				:(rhoV = PP.VapourDensity(OutletV.T, OutletV.P, OutletV.z)),
				:(InletL.F*InletL.h + InletQ.Q = OutletV.F*OutletV.h),
				:(DP = InletL.P - OutletV.P),
			],
			[
				"Molar Balance","","Vapour Volume","Vapour Density","Energy Balance","Pressure",
			],
			[:PP,:NComp,:DP,],
			[:InletL,:OutletV,:InletQ,:vV,:rhoV,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	DP::press_delta 
	InletL::stream
	OutletV::vapour_stream
	InletQ::energy_stream 
	vV::volume_mol 
	rhoV::dens_mass 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export reboilerSteady
function setEquationFlow(in::reboilerSteady)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
end
function atributes(in::reboilerSteady,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/ReboilerSteady"
	fields[:Brief]="Model of a  Steady State reboiler with no thermodynamics equilibrium - thermosyphon."
	fields[:Info]="== Assumptions ==
* perfect mixing of both phases;
* no thermodynamics equilibrium;
* no liquid entrainment in the vapour stream.
	
== Specify ==
* the InletL stream;
* the heat supply OR the outlet temperature (OutletV.T);
"
	drive!(fields,_)
	return fields
end
reboilerSteady(_::Dict{Symbol,Any})=begin
	newModel=reboilerSteady()
	newModel.attributes=atributes(newModel,_)
	newModel
end
