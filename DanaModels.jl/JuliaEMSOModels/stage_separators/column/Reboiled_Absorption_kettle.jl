# -------------------------------------------------------------------
#* Reboiled Absorption Column model with:
#*
#*	- NTrays like tray;
#*	- a kettle reboiler;
#*
#* ------------------------------------------------------------------
type Reboiled_Absorption_kettle
	Reboiled_Absorption_kettle()=begin
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
			fill(tray()),
			reboiler(),
			[:PP,:NComp,:NTrays,:topdown,:top,:bot,],
			[:trays,:reb,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	NTrays::DanaInteger
	topdown::DanaInteger
	top::DanaInteger
	bot::DanaInteger
	trays::Array{tray}
	reb::reboiler
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Reboiled_Absorption_kettle
function set(in::Reboiled_Absorption_kettle)
	top = (NTrays-1)*(1-topdown)/2+1
	 bot = NTrays/top
	 
end
function atributes(in::Reboiled_Absorption_kettle,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/ReboiledKettle"
	fields[:Brief]="Model of a reboiled absorption column with dynamic reboiler."
	fields[:Info]="== Specify ==
* the feed stream of each tray (Inlet);
* the Murphree eficiency for each tray Emv;
* the vapour flow leaving the top of the column;
* the InletL stream of the top tray;
* the heat supllied in the reboiler;
* the reboiler liquid outlet flow (OutletL.F);
	
== Initial Conditions ==
* the trays temperature (OutletL.T);
* the trays liquid level (Level) OR the trays liquid flow (OutletL.F);
* (NoComps - 1) OutletL (OR OutletV) compositions for each tray;
	
* the reboiler temperature (OutletL.T);
* the reboiler liquid level (Level);
* (NoComps - 1) OutletL (OR OutletV) compositions.
"
	drive!(fields,_)
	return fields
end
Reboiled_Absorption_kettle(_::Dict{Symbol,Any})=begin
	newModel=Reboiled_Absorption_kettle()
	newModel.attributes=atributes(newModel,_)
	newModel
end
