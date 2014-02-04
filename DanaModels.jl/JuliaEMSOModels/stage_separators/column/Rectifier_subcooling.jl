# -------------------------------------------------------------------
#* Rectifier Column with:
#*
#*	- NTrays like tray;
#*	- a steady state condenser with subcooling;
#*	- a vessel drum (layed cilinder);
#*	- a splitter which separate reflux and distillate;
#*	- a pump in reflux stream.
#*
#* ------------------------------------------------------------------
type Rectifier_subcooling
	Rectifier_subcooling()=begin
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
			[:trays,:cond,:ttop,:sptop,:pump1,:alfaTopo,]
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
export Rectifier_subcooling
function set(in::Rectifier_subcooling)
	top = (NTrays-1)*(1-topdown)/2+1
	 bot = NTrays/top
	 
end
function setEquationFlow(in::Rectifier_subcooling)
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
function atributes(in::Rectifier_subcooling,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/RefluxedSubcooling"
	fields[:Brief]="Model of a rectifier column with steady condenser."
	fields[:Info]="== Specify ==
* the feed stream of each tray (Inlet);
* the Murphree eficiency for each tray Emv;
* the InletV stream of the bottom tray unless its flow;
* the pump head;
* the condenser pressure drop;
* the heat supllied in  the top tank;
* the heat supllied in condenser;
* both  top splitter outlet flows OR one of the splitter outlet flows and the splitter frac.
	
== Initial Conditions ==
* the trays temperature (OutletL.T);
* the trays liquid level (Level) OR the trays liquid flow (OutletL.F);
* (NoComps - 1) OutletL (OR OutletV) compositions for each tray;
	
* the top tank temperature (OutletL.T);
* the top tank liquid level (Level);
* (NoComps - 1) OutletL (OR OutletV) compositions;
"
	drive!(fields,_)
	return fields
end
Rectifier_subcooling(_::Dict{Symbol,Any})=begin
	newModel=Rectifier_subcooling()
	newModel.attributes=atributes(newModel,_)
	newModel
end
