# -------------------------------------------------------------------
#* Distillation Column model with:
#*
#*	- NTrays like tray;
#*	- a kettle reboiler;
#*	- a steady state condenser with subcooling;
#*	- a vessel drum (layed cilinder);
#*	- a splitter which separate reflux and distillate;
#*	- a pump in reflux stream.
#*
#* ------------------------------------------------------------------
type Distillation_kettle_subcooling
	Distillation_kettle_subcooling()=begin
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
			condenserSteady(),
			reboiler(),
			tank_cylindrical(),
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
			[:trays,:cond,:reb,:ttop,:sptop,:pump1,:alfaTopo,]
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
	cond::condenserSteady
	reb::reboiler
	ttop::tank_cylindrical
	sptop::splitter
	pump1::pump
	alfaTopo::DanaReal
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Distillation_kettle_subcooling
function set(in::Distillation_kettle_subcooling)
	top = (NTrays-1)*(1-topdown)/2+1
	 bot = NTrays/top
	 
end
function setEquationFlow(in::Distillation_kettle_subcooling)
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
function atributes(in::Distillation_kettle_subcooling,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/DistillationKettleSubcooling"
	fields[:Brief]="Model of a distillation column with steady condenser and dynamic reboiler."
	fields[:Info]="== Specify ==
* the feed stream of each tray (Inlet);
* the Murphree eficiency for each tray (Emv);
* the pump pressure difference;
* the heat supllied in reboiler and condenser;
* the heat supllied in the top tank;
* the condenser pressure drop;
* the reboiler liquid outlet flow (OutletL.F);
* both splitter outlet flows OR one of the splitter outlet flows and the splitter frac.
	
== Initial Conditions ==
* the trays temperature (OutletL.T);
* the trays liquid level (Level) OR the trays liquid flow (OutletL.F);
* (NoComps - 1) OutletL (OR OutletV) compositions for each tray;
	
* the top tank temperature (OutletL.T);
* the top tank liquid level (Level);
* (NoComps - 1) OutletL (OR OutletV) compositions;
	
* the reboiler temperature (OutletL.T);
* the reboiler liquid level (Level);
* (NoComps - 1) OutletL (OR OutletV) compositions.
"
	drive!(fields,_)
	return fields
end
Distillation_kettle_subcooling(_::Dict{Symbol,Any})=begin
	newModel=Distillation_kettle_subcooling()
	newModel.attributes=atributes(newModel,_)
	newModel
end
