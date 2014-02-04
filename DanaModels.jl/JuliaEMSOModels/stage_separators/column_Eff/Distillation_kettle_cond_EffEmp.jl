#----------------------------------------------------------------------
#* Models of Column with Tray Efficiency Prediction
#* Author: Josias J. Junges
#*---------------------------------------------------------------------
type Distillation_kettle_cond_EffEmp
	Distillation_kettle_cond_EffEmp()=begin
		PP=outers.PP
		NComp=outers.NComp
		iLK=outers.iLK
		iHK=outers.iHK
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
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Pseudo-binary ligth key index"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Pseudo-binary heavy key index"
			]),
			fill(trayEffEmp()),
			condenser(),
			reboiler(),
			splitter(),
			pump(),
			DanaReal(),
			positive ((Symbol=>Any)[
				:Brief=>"Pseudo-binary approach"
			]),
			[
				:(cond.InletV.F*trays(top).vV = alfaTopo * trays(top).Ah * sqrt(2*(trays(top).OutletV.P - cond.OutletL.P + 1e-8 * "atm") / (trays(top).alfa*trays(top).rhoV))),
				:(cond.InletV.F = 0 * "mol/s"),
				:(condVoutLk=cond.OutletV.z(iLK)/(cond.OutletV.z(iLK)+cond.OutletV.z(iHK))),
			],
			[
				"","","Condenser pseudo-binary approach",
			],
			[
				:((trays(top).LoutLk-trays(top).LinLK)*trays(top).m=(trays(top).VoutLk-condVoutLk)),
				:((trays([(top+1):NTrays]).LoutLk-trays([(top+1):NTrays]).LinLK)*trays([(top+1):NTrays]).m=(trays([(top+1):NTrays]).VoutLk-trays([(top+1):NTrays]-1).VoutLk)),
				:((trays(top).OutletL.z(1)-trays(top).InletL.z(1))*trays(top).m=(trays(top).OutletV.z(1)-cond.OutletV.z(1))),
				:((trays([(top+1):NTrays]).OutletL.z(1)-trays([(top+1):NTrays]).InletL.z(1))*trays([(top+1):NTrays]).m=(trays([(top+1):NTrays]).OutletV.z(1)-trays([(top+1):NTrays]-1).OutletV.z(1))),
			],
			[
				"","","","",
			],
			[:PP,:NComp,:NTrays,:topdown,:top,:bot,:VapourFlow,:iLK,:iHK,],
			[:trays,:cond,:reb,:sptop,:pump1,:alfaTopo,:condVoutLk,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	NTrays::DanaInteger
	topdown::DanaInteger
	top::DanaInteger
	bot::DanaInteger
	VapourFlow::DanaSwitcher
	iLK::DanaInteger 
	iHK::DanaInteger 
	trays::Array{trayEffEmp}
	cond::condenser
	reb::reboiler
	sptop::splitter
	pump1::pump
	alfaTopo::DanaReal
	condVoutLk::positive 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Distillation_kettle_cond_EffEmp
function set(in::Distillation_kettle_cond_EffEmp)
	top = (NTrays-1)*(1-topdown)/2+1
	 bot = NTrays/top
	 
end
function setEquationFlow(in::Distillation_kettle_cond_EffEmp)
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
	addEquation(3)
end
function setEquationFlow(in::Distillation_kettle_cond_EffEmp)
	if NComp > 2 
		addEquation(1)
		addEquation(2)
	else
		addEquation(3)
		addEquation(4)
	end
end
function atributes(in::Distillation_kettle_cond_EffEmp,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/DistillationKettleCond"
	fields[:Brief]="Model of a distillation column with dynamic condenser and dynamic reboiler-Tray Efficiency Prediction"
	fields[:Info]="== Specify ==
* the feed stream of each tray (Inlet);

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
Distillation_kettle_cond_EffEmp(_::Dict{Symbol,Any})=begin
	newModel=Distillation_kettle_cond_EffEmp()
	newModel.attributes=atributes(newModel,_)
	newModel
end
