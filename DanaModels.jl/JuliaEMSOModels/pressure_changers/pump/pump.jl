#-------------------------------------------------------------------
#* Model of a pump (simplified, used in distillation column model)
#*----------------------------------------------------------------------
#* Author: Paula B. Staudt
#*--------------------------------------------------------------------
type pump
	pump()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin ((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger(),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet stream",
				:PosX=>0,
				:PosY=>0.4727,
				:Symbol=>"_{in}"
			]),
			streamPH ((Symbol=>Any)[
				:Brief=>"Outlet stream",
				:PosX=>1,
				:PosY=>0.1859,
				:Symbol=>"_{out}"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Pump head"
			]),
			[
				:(Inlet.F = Outlet.F),
				:(Inlet.z = Outlet.z),
				:(Outlet.P = Inlet.P + dP),
				:(Outlet.h = Inlet.h),
			],
			[
				"Molar Balance","","Pump head","FIXME: pump potency",
			],
			[:PP,:NComp,],
			[:Inlet,:Outlet,:dP,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger
	Inlet::stream 
	Outlet::streamPH 
	dP::press_delta 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export pump
function setEquationFlow(in::pump)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
end
function atributes(in::pump,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Pump"
	fields[:Brief]="Model of a simplified pump, used in distillation column model."
	fields[:Info]="Specify: 
	 * the inlet stream;
	 * the pump press delta dP.
	"
	drive!(fields,_)
	return fields
end
pump(_::Dict{Symbol,Any})=begin
	newModel=pump()
	newModel.attributes=atributes(newModel,_)
	newModel
end
