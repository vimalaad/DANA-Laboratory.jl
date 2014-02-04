#----------------------------------------------------------------------
#* Model of a  Refluxed Absorption column containing:
#*	- NTrays like tray;
#*	- dymamic condenser without subcooling;
#*	- a splitter which separate reflux and distillate;
#*	- a pump in reflux stream;
#*---------------------------------------------------------------------
type Refluxed_Absorption
	Refluxed_Absorption()=begin
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
			[:trays,:cond,:sptop,:pump1,:alfaTopo,]
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
	sptop::splitter
	pump1::pump
	alfaTopo::DanaReal
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Refluxed_Absorption
function set(in::Refluxed_Absorption)
	top = (NTrays-1)*(1-topdown)/2+1
	 bot = NTrays/top
	 
end
function setEquationFlow(in::Refluxed_Absorption)
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
function atributes(in::Refluxed_Absorption,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/RefluxedCond"
	fields[:Brief]="Model of a refluxed absorption column with dynamic condenser."
	fields[:Info]="== Specify ==
* the feed stream of each tray (Inlet);
* the Murphree eficiency for each tray Emv;
* the InletV stream of the bottom tray unless its flow;
* the pump pressure difference;
* the heat supllied in the condenser;
* the condenser vapor outlet flow (OutletV.F);
* both splitter outlet flows OR one of the splitter outlet flows and the splitter frac.
	
== Initial Conditions ==
* the trays temperature (OutletL.T);
* the trays liquid level (Level) OR the trays liquid flow (OutletL.F);
* (NoComps - 1) OutletL (OR OutletV) compositions for each tray;
	
* the condenser temperature (OutletL.T);
* the condenser liquid level (Level);
* (NoComps - 1) OutletL (OR OutletV) compositions;
"
	drive!(fields,_)
	return fields
end
Refluxed_Absorption(_::Dict{Symbol,Any})=begin
	newModel=Refluxed_Absorption()
	newModel.attributes=atributes(newModel,_)
	newModel
end
