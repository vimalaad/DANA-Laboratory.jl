#----------------------------------------------------------------------
#* Model of a  Steady State reboiler with fake calculation of 
#* vaporisation fraction and output temperature, but with a real
#* calculation of the output stream enthalpy
#*---------------------------------------------------------------------
type reboilerSteady_fakeH
	reboilerSteady_fakeH()=begin
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
			DanaReal ((Symbol=>Any)[
				:Brief=>"Flow Constant",
				:Unit=>"mol/J"
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
			[
				:(InletL.F = OutletV.F),
				:(InletL.z = OutletV.z),
				:(InletL.F*InletL.h + InletQ.Q = OutletV.F*OutletV.h),
				:(DP = InletL.P - OutletV.P),
				:(OutletV.v = 1.0),
				:(OutletV.T = 300*"K"),
				:(OutletV.F = k*InletQ.Q),
			],
			[
				"Molar Balance","","Energy Balance","Pressure","Fake Vapourisation Fraction","Fake output temperature","Pressure Drop through the reboiler",
			],
			[:PP,:NComp,:DP,:k,],
			[:InletL,:OutletV,:InletQ,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	DP::press_delta 
	k::DanaReal 
	InletL::stream
	OutletV::vapour_stream
	InletQ::energy_stream 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export reboilerSteady_fakeH
function setEquationFlow(in::reboilerSteady_fakeH)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
	addEquation(7)
end
function atributes(in::reboilerSteady_fakeH,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/ReboilerSteady"
	fields[:Brief]="Model of a  Steady State reboiler with fake calculation of outlet conditions."
	fields[:Info]="Model of a  Steady State reboiler with fake calculation of 
vaporisation fraction and output temperature, but with a real 
calculation of the output stream enthalpy.
"
	drive!(fields,_)
	return fields
end
reboilerSteady_fakeH(_::Dict{Symbol,Any})=begin
	newModel=reboilerSteady_fakeH()
	newModel.attributes=atributes(newModel,_)
	newModel
end
