# -------------------------------------------------------------------
#* Distillation Column model with:
#*
#*	- NumberOfTrays like tray;
#*	- a vessel in the bottom of column;
#*	- a splitter who separate the bottom product and the stream to reboiler;
#*	- steady state reboiler (thermosyphon);
#*	- a dynamic condenser without subcooling;
#*	- a splitter which separate reflux and distillate;
#*	- a pump in reflux stream.
#*
#* ------------------------------------------------------------------
type User_Distillation_thermosyphon_cond
	User_Distillation_thermosyphon_cond()=begin
		new(
			User_Section_ColumnBasic(),
			DanaSwitcher ((Symbol=>Any)[
				:Valid=>["on", "off"],
				:Default=>"on",
				:Hidden=>true
			]),
			condenser(),
			splitter(),
			pump(),
			tank(),
			splitter(),
			reboilerSteady(),
			DanaReal(),
			energy_stream ((Symbol=>Any)[
				:Brief=>"Heat supplied to Condenser",
				:Hidden=>true
			]),
			energy_stream ((Symbol=>Any)[
				:Brief=>"Heat supplied to Reboiler",
				:Hidden=>true
			]),
			energy_stream ((Symbol=>Any)[
				:Brief=>"Heat supplied to Bottom Vessel",
				:Hidden=>true
			]),
			vapour_stream ((Symbol=>Any)[
				:Brief=>"Vapour outlet stream From Top Condenser",
				:PosX=>0.73,
				:PosY=>0
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Connector for Vapour outlet stream From Top Condenser",
				:Hidden=>true
			]),
			liquid_stream ((Symbol=>Any)[
				:Brief=>"Liquid outlet stream From Top Splitter",
				:PosX=>1,
				:PosY=>0.45
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Connector for Liquid outlet stream From Top Splitter",
				:Hidden=>true
			]),
			liquid_stream ((Symbol=>Any)[
				:Brief=>"Liquid outlet stream From Bottom Splitter",
				:PosX=>1,
				:PosY=>1
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Connector for Liquid outlet stream From Reboiler",
				:Hidden=>true
			]),
			[
				:(ConnectorCondenserVout.T = VapourDistillate.T),
				:(ConnectorCondenserVout.P = VapourDistillate.P),
				:(ConnectorCondenserVout.F = VapourDistillate.F),
				:(ConnectorCondenserVout.z = VapourDistillate.z),
				:(ConnectorSplitterTop.T = LiquidDistillate.T),
				:(ConnectorSplitterTop.P = LiquidDistillate.P),
				:(ConnectorSplitterTop.F = LiquidDistillate.F),
				:(ConnectorSplitterTop.z = LiquidDistillate.z),
				:(ConnectorSplitterBottom.T = BottomProduct.T),
				:(ConnectorSplitterBottom.P = BottomProduct.P),
				:(ConnectorSplitterBottom.F = BottomProduct.F),
				:(ConnectorSplitterBottom.z = BottomProduct.z),
				:(CondenserUnity.InletV.F*trays(1).vV = alfaTopo * _P1.Ah * sqrt(2*(trays(1).OutletV.P - CondenserUnity.OutletL.P + 1e-8 * "atm") / (_P1.alfa*trays(1).rhoV))),
				:(CondenserUnity.InletV.F = 0 * "mol/s"),
			],
			[
				"","","","","","","","","","","","","","",
			],
			[:CondenserVapourFlow,],
			[:CondenserUnity,:SplitterTop,:PumpUnity,:BottomVessel,:SplitterBottom,:ReboilerUnity,:alfaTopo,:HeatToCondenser,:HeatToReboiler,:HeatToBottomVessel,:VapourDistillate,:ConnectorCondenserVout,:LiquidDistillate,:ConnectorSplitterTop,:BottomProduct,:ConnectorSplitterBottom,]
		)
	end
	_P1::User_Section_ColumnBasic
	CondenserVapourFlow::DanaSwitcher 
	CondenserUnity::condenser
	SplitterTop::splitter
	PumpUnity::pump
	BottomVessel::tank
	SplitterBottom::splitter
	ReboilerUnity::reboilerSteady
	alfaTopo::DanaReal
	HeatToCondenser::energy_stream 
	HeatToReboiler::energy_stream 
	HeatToBottomVessel::energy_stream 
	VapourDistillate::vapour_stream 
	ConnectorCondenserVout::stream 
	LiquidDistillate::liquid_stream 
	ConnectorSplitterTop::stream 
	BottomProduct::liquid_stream 
	ConnectorSplitterBottom::stream 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export User_Distillation_thermosyphon_cond
function setEquationFlow(in::User_Distillation_thermosyphon_cond)
	# Condenser Connector Equations
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	# Top Splitter Connector Equations
	addEquation(5)
	addEquation(6)
	addEquation(7)
	addEquation(8)
	# Bottom Splitter Connector Equations
	addEquation(9)
	addEquation(10)
	addEquation(11)
	addEquation(12)
	let switch=CondenserVapourFlow
		if CondenserVapourFlow==CondenserUnity.InletV.F < 1e-6 * "kmol/h"
			set(switch,"off")
		end
		if CondenserVapourFlow==trays(1).OutletV.P > CondenserUnity.OutletL.P + 1e-1 * "atm"
			set(switch,"on")
		end
		if switch=="on"
			addEquation(13)
		elseif switch=="off"
			addEquation(14)
		end
	end
end
function atributes(in::User_Distillation_thermosyphon_cond,_::Dict{Symbol,Any})
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
User_Distillation_thermosyphon_cond(_::Dict{Symbol,Any})=begin
	newModel=User_Distillation_thermosyphon_cond()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(User_Distillation_thermosyphon_cond)
