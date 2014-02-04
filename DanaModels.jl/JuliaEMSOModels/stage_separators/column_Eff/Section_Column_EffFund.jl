#-------------------------------------------------------------------
#* Models of Column Section with Tray Efficiency Prediction
#* Author: Josias J. Junges
#*-------------------------------------------------------------------
type Section_Column_EffFund
	Section_Column_EffFund()=begin
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
			DanaReal((Symbol=>Any)[
				:Brief=>"Adjacent above stage vapour composition"
			]),
			fill(trayEffFund()),
			[
				:((trays(top).LoutLk-trays(top).LinLK)*trays(top).m=(trays(top).VoutLk-xas)),
				:((trays([(top+1):NTrays]).LoutLk-trays([(top+1):NTrays]).LinLK)*trays([(top+1):NTrays]).m=(trays([(top+1):NTrays]).VoutLk-trays([(top+1):NTrays]-1).VoutLk)),
				:((trays(top).OutletL.z(1)-trays(top).InletL.z(1))*trays(top).m=(trays(top).OutletV.z(1)-xas)),
				:((trays([(top+1):NTrays]).OutletL.z(1)-trays([(top+1):NTrays]).InletL.z(1))*trays([(top+1):NTrays]).m=(trays([(top+1):NTrays]).OutletV.z(1)-trays([(top+1):NTrays]-1).OutletV.z(1))),
			],
			[
				"","","","",
			],
			[:PP,:NComp,:NTrays,:topdown,:top,:bot,:xas,],
			[:trays,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	NTrays::DanaInteger
	topdown::DanaInteger
	top::DanaInteger
	bot::DanaInteger
	xas::DanaReal
	trays::Array{trayEffFund}
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Section_Column_EffFund
function set(in::Section_Column_EffFund)
	top = (NTrays-1)*(1-topdown)/2+1
	 bot = NTrays/top
	 
end
function setEquationFlow(in::Section_Column_EffFund)
	if NComp > 2 
		addEquation(1)
		addEquation(2)
	else
		addEquation(3)
		addEquation(4)
	end
end
function atributes(in::Section_Column_EffFund,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/SectionColumn"
	fields[:Brief]="Model of a column section - Tray Efficiency Prediction"
	fields[:Info]="== Model of a column section containing ==
* NTrays trays.
	
== Specify ==
* the feed stream of each tray (Inlet);

* the InletL stream of the top tray;
* the InletV stream of the bottom tray.
	
== Initial Conditions ==
* the trays temperature (OutletL.T);
* the trays liquid level (Level) OR the trays liquid flow (OutletL.F);
* (NoComps - 1) OutletL (OR OutletV) compositions for each tray.
"
	drive!(fields,_)
	return fields
end
Section_Column_EffFund(_::Dict{Symbol,Any})=begin
	newModel=Section_Column_EffFund()
	newModel.attributes=atributes(newModel,_)
	newModel
end
