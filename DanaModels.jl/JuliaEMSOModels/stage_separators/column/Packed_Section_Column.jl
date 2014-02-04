#----------------------------------------------------------------------
#* Model of a  packed column section with:
#*	- NStages = theoretical number of equilibrium stages.
#* 
#*---------------------------------------------------------------------
type Packed_Section_Column
	Packed_Section_Column()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger(),
			DanaInteger((Symbol=>Any)[
				:Brief=>"Number of trays",
				:Default=>2
			]),
			DanaInteger((Symbol=>Any)[
				:Brief=>"Trays counting (1=top-down, -1=bottom-up)",
				:Default=>1
			]),
			DanaInteger((Symbol=>Any)[
				:Brief=>"Number of top tray"
			]),
			DanaInteger((Symbol=>Any)[
				:Brief=>"Number of bottom tray"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Height of packing"
			]),
			fill(packedStage()),
			pressure(),
			[
				:(dP = stage(bot).OutletL.P - stage(top).OutletL.P),
			],
			[
				"",
			],
			[:PP,:NComp,:NStages,:topdown,:top,:bot,:H,],
			[:stage,:dP,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	NStages::DanaInteger
	topdown::DanaInteger
	top::DanaInteger
	bot::DanaInteger
	H::length 
	stage::Array{packedStage}
	dP::pressure
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Packed_Section_Column
function set(in::Packed_Section_Column)
	top = (NStages-1)*(1-topdown)/2+1
	 bot = NStages/top
	 stage.hs = H/NStages
	 stage.V = stage.hs * stage.d^2*3.14159/4
	 
end
function setEquationFlow(in::Packed_Section_Column)
	#stage.deltaP = dP/NStages;
	addEquation(1)
end
function atributes(in::Packed_Section_Column,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/PackedSectionColumn"
	fields[:Brief]="Model of a packed column section."
	fields[:Info]="== Model of a packed column section containing ==
* NStages theoretical stages.
	
== Specify ==
* the feed stream of each tray (Inlet);
* the InletL stream of the top tray;
* the InletV stream of the bottom tray;
* the total pressure drop (dP) of the section.
	
== Initial Conditions ==
* the stages temperature (OutletL.T);
* the stages liquid holdup;
* (NoComps - 1) OutletL (OR OutletV) compositions for each tray.
"
	drive!(fields,_)
	return fields
end
Packed_Section_Column(_::Dict{Symbol,Any})=begin
	newModel=Packed_Section_Column()
	newModel.attributes=atributes(newModel,_)
	newModel
end
