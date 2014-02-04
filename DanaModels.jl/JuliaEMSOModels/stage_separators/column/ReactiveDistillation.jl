# -------------------------------------------------------------------
#*  Reactive Distillation Column
#*
#* ------------------------------------------------------------------
type ReactiveDistillation
	ReactiveDistillation()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin((Symbol=>Any)[
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
			DanaReal(),
			DanaSwitcher((Symbol=>Any)[
				:Valid=>["on", "off"],
				:Default=>"off"
			]),
			fill(trayReact()),
			condenserReact(),
			reboilerReact(),
			splitter(),
			pump(),
			[
				:(cond.InletV.F*trays(top).vV / "m^2" = sqrt((trays(top).OutletV.P - cond.OutletL.P + 1e-8 * "atm")/(trays(top).rhoV*alfacond))),
				:(cond.InletV.F = 0.0 * "mol/s"),
			],
			[
				"Pressure Drop through the condenser","Prato selado",
			],
			[:PP,:NComp,:NTrays,:topdown,:top,:bot,:alfacond,:VapourFlow,],
			[:trays,:cond,:reb,:sp,:p,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	NTrays::DanaInteger
	topdown::DanaInteger
	top::DanaInteger
	bot::DanaInteger
	alfacond::DanaReal
	VapourFlow::DanaSwitcher
	trays::Array{trayReact}
	cond::condenserReact
	reb::reboilerReact
	sp::splitter
	p::pump
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export ReactiveDistillation
function set(in::ReactiveDistillation)
	top = (NTrays-1)*(1-topdown)/2+1
	 bot = NTrays/top
	 
end
function setEquationFlow(in::ReactiveDistillation)
	let switch=VapourFlow
		if VapourFlow==trays(top).OutletV.P < cond.OutletL.P
			set(switch,"off")
		end
		if VapourFlow==trays(top).OutletV.P > cond.OutletL.P + 1e-3 * "atm"
			set(switch,"on")
		end
		if switch=="on"
			addEquation(1)
		elseif switch=="off"
			addEquation(2)
		end
	end
end
function atributes(in::ReactiveDistillation,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/DistillationKettleCond"
	fields[:Brief]="Model of a reactive distillation column with dynamic condenser and reboiler."
	fields[:Info]="== Specify ==
* the reaction related variables for each tray, condenser and reboiler;
* the feed stream of each tray (Inlet);
* the Murphree eficiency for each tray Emv;
* the pump pressure difference;
* the heat supllied in reboiler and condenser;
* the condenser vapor outlet flow (OutletV.F);
* the reboiler liquid outlet flow (OutletL.F);
* both splitter outlet flows OR one of the splitter outlet flows and the splitter frac.
	
== Initial Conditions ==
* the trays temperature (OutletL.T);
* the trays liquid level (Level) OR the trays liquid flow (OutletL.F);
* (NoComps - 1) OutletL (OR OutletV) compositions for each tray;
	
* the condenser temperature (OutletL.T);
* the condenser liquid level (Level);
* (NoComps - 1) OutletL (OR OutletV) compositions;
	
* the reboiler temperature (OutletL.T);
* the reboiler liquid level (Level);
* (NoComps - 1) OutletL (OR OutletV) compositions.
"
	drive!(fields,_)
	return fields
end
ReactiveDistillation(_::Dict{Symbol,Any})=begin
	newModel=ReactiveDistillation()
	newModel.attributes=atributes(newModel,_)
	newModel
end
