# -------------------------------------------------------------------
#* Distillation Column model with:
#*
#*	- NTrays like tray;
#*	- a vessel in the bottom of column;
#*	- a splitter who separate the bottom product and the stream to reboiler;
#*	- steady state reboiler (thermosyphon);
#*	- a dynamic condenser without subcooling;
#*	- a splitter which separate reflux and distillate;
#*	- a pump in reflux stream.
#*
#* ------------------------------------------------------------------
type Distillation_thermosyphon_cond
	Distillation_thermosyphon_cond()=begin
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
			DanaSwitcher((Symbol=>Any)[
				:Valid=>["on", "off"],
				:Default=>"on"
			]),
			fill(tray()),
			condenser(),
			reboilerSteady(),
			tank(),
			splitter(),
			splitter(),
			pump(),
			DanaReal(),
			[
				:(cond.InletV.F*trays(top).vV = alfaTopo * trays(top).Ah * sqrt(2*(trays(top).OutletV.P - cond.OutletL.P + 1e-8 * "atm") / (trays(top).alfa*trays(top).rhoV))),
				:(cond.InletV.F = 0 * "mol/s"),
			],
			[
				"","",
			],
			[:PP,:NComp,:NTrays,:topdown,:top,:bot,:VapourFlow,],
			[:trays,:cond,:reb,:tbottom,:spbottom,:sptop,:pump1,:alfaTopo,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	NTrays::DanaInteger
	topdown::DanaInteger
	top::DanaInteger
	bot::DanaInteger
	VapourFlow::DanaSwitcher
	trays::Array{tray}
	cond::condenser
	reb::reboilerSteady
	tbottom::tank
	spbottom::splitter
	sptop::splitter
	pump1::pump
	alfaTopo::DanaReal
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Distillation_thermosyphon_cond
function set(in::Distillation_thermosyphon_cond)
	top = (NTrays-1)*(1-topdown)/2+1
	 bot = NTrays/top
	 
end
function setEquationFlow(in::Distillation_thermosyphon_cond)
	let switch=VapourFlow
		if VapourFlow==cond.InletV.F < 1e-6 * "kmol/h"
			set(switch,"off")
		end
		if VapourFlow==trays(top).OutletV.P > cond.OutletL.P + 1e-1 * "atm"
			set(switch,"on")
		end
		if switch=="on"
			addEquation(1)
		elseif switch=="off"
			addEquation(2)
		end
	end
end
function atributes(in::Distillation_thermosyphon_cond,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/DistillationThermosyphonCond"
	fields[:Brief]="Model of a distillation column with dynamic condenser and steady reboiler."
	fields[:Info]="== Specify ==
* the feed stream of each tray (Inlet);
* the Murphree eficiency for each tray Emv;
* the pump head;
* the condenser vapor outlet flow (OutletV.F);
* the heat supllied in bottom tank;
* the heat supllied in condenser and reboiler;
* the Outlet1 flow in the bottom splitter (spbottom.Outlet1.F) that corresponds to the bottom product;
	
== Initial Conditions ==
* the trays temperature (OutletL.T);
* the trays liquid level (Level) OR the trays liquid flow (OutletL.F);
* (NoComps - 1) OutletL (OR OutletV) compositions for each tray;
	
* the condenser temperature (OutletL.T);
* the condenser liquid level (Level);
* (NoComps - 1) OutletL (OR OutletV) compositions;
	
* the bottom tank temperature (OutletL.T);
* the bottom tank liquid level (Level);
* (NoComps - 1) OutletL (OR OutletV) compositions.
"
	drive!(fields,_)
	return fields
end
Distillation_thermosyphon_cond(_::Dict{Symbol,Any})=begin
	newModel=Distillation_thermosyphon_cond()
	newModel.attributes=atributes(newModel,_)
	newModel
end
