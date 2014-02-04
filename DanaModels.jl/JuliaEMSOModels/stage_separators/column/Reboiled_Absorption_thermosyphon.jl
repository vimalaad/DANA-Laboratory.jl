# -------------------------------------------------------------------
#* Reboiled Absorption Column model with:
#*
#*	- NTrays like tray;
#*	- a vessel in the bottom of column;
#*	- a splitter which separate the bottom product and the stream to reboiler;
#*	- steady state reboiler (thermosyphon);
#*
#* ------------------------------------------------------------------
type Reboiled_Absorption_thermosyphon
	Reboiled_Absorption_thermosyphon()=begin
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
			reboilerSteady(),
			splitter(),
			tank(),
			[:PP,:NComp,:NTrays,:topdown,:top,:bot,],
			[:trays,:reb,:spbottom,:tbottom,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	NTrays::DanaInteger
	topdown::DanaInteger
	top::DanaInteger
	bot::DanaInteger
	trays::Array{tray}
	reb::reboilerSteady
	spbottom::splitter
	tbottom::tank
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Reboiled_Absorption_thermosyphon
function set(in::Reboiled_Absorption_thermosyphon)
	top = (NTrays-1)*(1-topdown)/2+1
	 bot = NTrays/top
	 
end
function atributes(in::Reboiled_Absorption_thermosyphon,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/ReboiledThermosyphon"
	fields[:Brief]="Model of a reboiled absorption column with steady reboiler."
	fields[:Info]="== Specify ==
* the feed stream of each tray (Inlet);
* the Murphree eficiency for each tray (Emv);
* the vapour flow leaving the top of the column;
* the InletL stream of the top tray;
* the heat supllied in bottom tank;
* the heat supllied in the reboiler;
* the Outlet1 flow in the bottom splitter (spbottom.Outlet1.F) that corresponds to the bottom product;
	
== Initial Conditions ==
* the trays temperature (OutletL.T);
* the trays liquid level (Level) OR the trays liquid flow (OutletL.F);
* (NoComps - 1) OutletL (OR OutletV) compositions for each tray;

* the bottom tank temperature (OutletL.T);
* the bottom tank liquid level (Level);
* (NoComps - 1) OutletL (OR OutletV) compositions.
"
	drive!(fields,_)
	return fields
end
Reboiled_Absorption_thermosyphon(_::Dict{Symbol,Any})=begin
	newModel=Reboiled_Absorption_thermosyphon()
	newModel.attributes=atributes(newModel,_)
	newModel
end
