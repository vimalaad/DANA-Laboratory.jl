#----------------------------------------------------------------------
#* Model of a  distillation column containing:
#*	- NumberOfTrays like tray;
#*	- a kettle reboiler;
#*	- dynamic condenser;
#*	- a splitter which separate reflux and distillate;
#*	- a pump in reflux stream;
#*---------------------------------------------------------------------
type User_Distillation_kettle_cond
	User_Distillation_kettle_cond()=begin
		new(
			User_Section_ColumnBasic(),
			DanaSwitcher ((Symbol=>Any)[
				:Valid=>["on", "off"],
				:Default=>"on",
				:Hidden=>true
			]),
			vapour_stream ((Symbol=>Any)[
				:Brief=>"Vapour Outlet in the section",
				:PosX=>1,
				:PosY=>0.46,
				:Protected=>true
			]),
			liquid_stream ((Symbol=>Any)[
				:Brief=>"Liquid Outlet in the section",
				:PosX=>1,
				:PosY=>0.58,
				:Protected=>true
			]),
			condenser(),
			reboiler(),
			splitter(),
			pump(),
			DanaReal(),
			energy_stream ((Symbol=>Any)[
				:Brief=>"Heat supplied to Reboiler",
				:Hidden=>true
			]),
			energy_stream ((Symbol=>Any)[
				:Brief=>"Heat supplied to Condenser",
				:Hidden=>true
			]),
			sourceNoFlow ((Symbol=>Any)[
				:Brief=>"No Inlet Flow to Reboiler",
				:Hidden=>true
			]),
			vapour_stream ((Symbol=>Any)[
				:Brief=>"Vapour outlet stream From Top Condenser",
				:PosX=>0.67,
				:PosY=>0
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Connector for Vapour outlet stream From Top Condenser",
				:Hidden=>true
			]),
			liquid_stream ((Symbol=>Any)[
				:Brief=>"Liquid outlet stream From Top Splitter",
				:PosX=>1,
				:PosY=>0.33
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Connector for Liquid outlet stream From Top Splitter",
				:Hidden=>true
			]),
			liquid_stream ((Symbol=>Any)[
				:Brief=>"Liquid outlet stream From Reboiler",
				:PosX=>1,
				:PosY=>1
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Connector for Liquid outlet stream From Reboiler",
				:Hidden=>true
			]),
			[
				:(CondenserUnity.InletV.F*trays(1).vV = alfaTopo *_P1.Ah * sqrt(2*(trays(1).OutletV.P - CondenserUnity.OutletL.P + 1e-8 * "atm") / (_P1.alfa*trays(1).rhoV))),
				:(CondenserUnity.InletV.F = 0 * "mol/s"),
				:(ConnectorCondenserVout.T = VapourDistillate.T),
				:(ConnectorCondenserVout.P = VapourDistillate.P),
				:(ConnectorCondenserVout.F = VapourDistillate.F),
				:(ConnectorCondenserVout.z = VapourDistillate.z),
				:(ConnectorSplitterOut.T = LiquidDistillate.T),
				:(ConnectorSplitterOut.P = LiquidDistillate.P),
				:(ConnectorSplitterOut.F = LiquidDistillate.F),
				:(ConnectorSplitterOut.z = LiquidDistillate.z),
				:(ConnectorReboilerLout.T = BottomProduct.T),
				:(ConnectorReboilerLout.P = BottomProduct.P),
				:(ConnectorReboilerLout.F = BottomProduct.F),
				:(ConnectorReboilerLout.z = BottomProduct.z),
				:(VapourDrawOff.F*_P1.VapSideTrayIndex= trays.VapourSideStream.F),
				:(VapourDrawOff.T = trays(_P1.VapourSideStreamLocation).VapourSideStream.T),
				:(VapourDrawOff.P = trays(_P1.VapourSideStreamLocation).VapourSideStream.P),
				:(VapourDrawOff.z = trays(_P1.VapourSideStreamLocation).VapourSideStream.z),
				:(LiquidDrawOff.F*_P1.LiqSideTrayIndex= trays.LiquidSideStream.F),
				:(LiquidDrawOff.T = trays(_P1.LiquidSideStreamLocation).LiquidSideStream.T),
				:(LiquidDrawOff.P = trays(_P1.LiquidSideStreamLocation).LiquidSideStream.P),
				:(LiquidDrawOff.z = trays(_P1.LiquidSideStreamLocation).LiquidSideStream.z),
				:(VapourDrawOffFlow = VapourDrawOff.F),
				:(LiquidDrawOffFlow = LiquidDrawOff.F),
			],
			[
				"","","","","","","","","","","","","","","","","","","","","","","","",
			],
			[:CondenserVapourFlow,],
			[:VapourDrawOff,:LiquidDrawOff,:CondenserUnity,:ReboilerUnity,:SplitterTop,:PumpUnity,:alfaTopo,:HeatToReboiler,:HeatToCondenser,:RebNoFlow,:VapourDistillate,:ConnectorCondenserVout,:LiquidDistillate,:ConnectorSplitterOut,:BottomProduct,:ConnectorReboilerLout,]
		)
	end
	_P1::User_Section_ColumnBasic
	CondenserVapourFlow::DanaSwitcher 
	VapourDrawOff::vapour_stream 
	LiquidDrawOff::liquid_stream 
	CondenserUnity::condenser
	ReboilerUnity::reboiler
	SplitterTop::splitter
	PumpUnity::pump
	alfaTopo::DanaReal
	HeatToReboiler::energy_stream 
	HeatToCondenser::energy_stream 
	RebNoFlow::sourceNoFlow 
	VapourDistillate::vapour_stream 
	ConnectorCondenserVout::stream 
	LiquidDistillate::liquid_stream 
	ConnectorSplitterOut::stream 
	BottomProduct::liquid_stream 
	ConnectorReboilerLout::stream 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export User_Distillation_kettle_cond
function setEquationFlow(in::User_Distillation_kettle_cond)
	let switch=CondenserVapourFlow
		if CondenserVapourFlow==CondenserUnity.InletV.F < 1e-6 * "kmol/h"
			set(switch,"off")
		end
		if CondenserVapourFlow==trays(1).OutletV.P > CondenserUnity.OutletL.P + 1e-1 * "atm"
			set(switch,"on")
		end
		if switch=="on"
			addEquation(1)
		elseif switch=="off"
			addEquation(2)
		end
	end
	# Condenser Connector Equations
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
	# Splitter Connector Equations
	addEquation(7)
	addEquation(8)
	addEquation(9)
	addEquation(10)
	# Reboiler Connector Equations
	addEquation(11)
	addEquation(12)
	addEquation(13)
	addEquation(14)
	addEquation(15)
	addEquation(16)
	addEquation(17)
	addEquation(18)
	addEquation(19)
	addEquation(20)
	addEquation(21)
	addEquation(22)
	addEquation(23)
	addEquation(24)
end
function atributes(in::User_Distillation_kettle_cond,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/DistillationKettleCond"
	fields[:Brief]="Model of a distillation column with dynamic condenser and dynamic reboiler."
	fields[:Info]="== Specify ==
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
User_Distillation_kettle_cond(_::Dict{Symbol,Any})=begin
	newModel=User_Distillation_kettle_cond()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(User_Distillation_kettle_cond)
