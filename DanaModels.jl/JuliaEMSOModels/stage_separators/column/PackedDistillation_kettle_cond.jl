#----------------------------------------------------------------------
#* Model of a  packed distillation column containing:
#*	- a section with NStages theoretical stages;
#*	- a kettle reboiler;
#*	- dymamic condenser;
#*	- a splitter which separate reflux and distillate;
#*	- a pump in reflux stream;
#*---------------------------------------------------------------------
type PackedDistillation_kettle_cond
	PackedDistillation_kettle_cond()=begin
		new(
			Packed_Section_Column(),
			condenser(),
			reboiler(),
			splitter(),
			pump(),
			[
				:(_P1.stage(_P1.top).InletV.F = _P1.stage(_P1.top).OutletV.F + _P1.stage(_P1.top).Inlet.F*_P1.stage(_P1.top).Inlet.v),
			],
			[
				"",
			],
			[:cond,:reb,:sptop,:pump1,]
		)
	end
	_P1::Packed_Section_Column
	cond::condenser
	reb::reboiler
	sptop::splitter
	pump1::pump
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export PackedDistillation_kettle_cond
function setEquationFlow(in::PackedDistillation_kettle_cond)
	addEquation(1)
end
function atributes(in::PackedDistillation_kettle_cond,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/PackedDistillationKettleCond"
	fields[:Brief]="Model of a distillation column with dynamic condenser and dynamic reboiler."
	fields[:Info]="== Specify ==
* the feed stream of each tray (Inlet);
* the pump pressure difference;
* the total pressure drop (dP) of the packing;
* the heat supllied in reboiler and condenser;
* the condenser vapor outlet flow (OutletV.F);
* the reboiler liquid outlet flow (OutletL.F);
* both splitter outlet flows OR one of the splitter outlet flows and the splitter frac.
	
== Initial Conditions ==
* the stages temperature (OutletL.T);
* the stages initial molar holdup;
* (NoComps - 1) OutletL (OR OutletV) compositions for each stage;
	
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
PackedDistillation_kettle_cond(_::Dict{Symbol,Any})=begin
	newModel=PackedDistillation_kettle_cond()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(PackedDistillation_kettle_cond)
