# -------------------------------------------------------------------
#* Distillation Column model with:
#*
#*	- NumberOfTrays like tray;
#*	- a vessel in the bottom of column;
#*	- a splitter who separate the bottom product and the stream to reboiler;
#*	- steady state reboiler (thermosyphon);
#*	- a steady state condenser with subcooling;
#*	- a vessel drum (layed cilinder);
#*	- a splitter which separate reflux and distillate;
#*	- a pump in reflux stream.
#*
#* ------------------------------------------------------------------
type User_Distillation_thermosyphon_subcooling
	User_Distillation_thermosyphon_subcooling()=begin
		new(
			User_Section_ColumnBasic(),
			DanaSwitcher((Symbol=>Any)[
				:Valid=>["on", "off"],
				:Hidden=>true,
				:Default=>"on"
			]),
			vapour_stream ((Symbol=>Any)[
				:Brief=>"Vapour Outlet in the section",
				:PosX=>1,
				:PosY=>0.41,
				:Protected=>true
			]),
			liquid_stream ((Symbol=>Any)[
				:Brief=>"Liquid Outlet in the section",
				:PosX=>1,
				:PosY=>0.515,
				:Protected=>true
			]),
			condenserSteady(),
			tank_cylindrical(),
			splitter(),
			pump(),
			reboilerSteady(),
			tank(),
			splitter(),
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
			energy_stream ((Symbol=>Any)[
				:Brief=>"Heat supplied to Top Vessel",
				:Hidden=>true
			]),
			liquid_stream ((Symbol=>Any)[
				:Brief=>"Liquid outlet stream From Top Splitter",
				:PosX=>1,
				:PosY=>0.30
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
				:(ConnectorSplitterTop.T = LiquidDistillate.T),
				:(ConnectorSplitterTop.P = LiquidDistillate.P),
				:(ConnectorSplitterTop.F = LiquidDistillate.F),
				:(ConnectorSplitterTop.z = LiquidDistillate.z),
				:(ConnectorSplitterBottom.T = BottomProduct.T),
				:(ConnectorSplitterBottom.P = BottomProduct.P),
				:(ConnectorSplitterBottom.F = BottomProduct.F),
				:(ConnectorSplitterBottom.z = BottomProduct.z),
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
				:(CondenserUnity.InletV.F*trays(1).vV = alfaTopo * _P1.Ah * sqrt(2*(trays(1).OutletV.P - CondenserUnity.OutletL.P + 1e-8 * "atm") / (_P1.alfa*trays(1).rhoV))),
				:(CondenserUnity.InletV.F = 0 * "mol/s"),
			],
			[
				"","","","","","","","","","","","","","","","","","","","",
			],
			[:CondenserVapourFlow,],
			[:VapourDrawOff,:LiquidDrawOff,:CondenserUnity,:TopVessel,:TopSplitter,:PumpUnity,:ReboilerUnity,:BottomVessel,:BottomSplitter,:alfaTopo,:HeatToCondenser,:HeatToReboiler,:HeatToBottomVessel,:HeatToTopVessel,:LiquidDistillate,:ConnectorSplitterTop,:BottomProduct,:ConnectorSplitterBottom,]
		)
	end
	_P1::User_Section_ColumnBasic
	CondenserVapourFlow::DanaSwitcher
	VapourDrawOff::vapour_stream 
	LiquidDrawOff::liquid_stream 
	CondenserUnity::condenserSteady
	TopVessel::tank_cylindrical
	TopSplitter::splitter
	PumpUnity::pump
	ReboilerUnity::reboilerSteady
	BottomVessel::tank
	BottomSplitter::splitter
	alfaTopo::DanaReal
	HeatToCondenser::energy_stream 
	HeatToReboiler::energy_stream 
	HeatToBottomVessel::energy_stream 
	HeatToTopVessel::energy_stream 
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
export User_Distillation_thermosyphon_subcooling
function setEquationFlow(in::User_Distillation_thermosyphon_subcooling)
	# Top Splitter Connector Equations
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	# Bottom Splitter Connector Equations
	addEquation(5)
	addEquation(6)
	addEquation(7)
	addEquation(8)
	addEquation(9)
	addEquation(10)
	addEquation(11)
	addEquation(12)
	addEquation(13)
	addEquation(14)
	addEquation(15)
	addEquation(16)
	addEquation(17)
	addEquation(18)
	let switch=CondenserVapourFlow
		if CondenserVapourFlow==CondenserUnity.InletV.F < 1e-6 * "kmol/h"
			set(switch,"off")
		end
		if CondenserVapourFlow==trays(1).OutletV.P > CondenserUnity.OutletL.P + 1e-1 * "atm"
			set(switch,"on")
		end
		if switch=="on"
			addEquation(19)
		elseif switch=="off"
			addEquation(20)
		end
	end
end
function atributes(in::User_Distillation_thermosyphon_subcooling,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/DistillationThermosyphonSubcooling"
	fields[:Brief]="Model of a distillation column with steady condenser and steady reboiler."
	fields[:Info]="== Specify ==
* the feed stream of each tray (Inlet);
* the Murphree eficiency for each tray Emv;
* the pump head;
* the condenser pressure drop;
* the heat supllied in top and bottom tanks;
* the heat supllied in condenser and reboiler;
* the Outlet1 flow in the bottom splitter (spbottom.Outlet1.F) that corresponds to the bottom product;
* both  top splitter outlet flows OR one of the splitter outlet flows and the splitter frac.
	
== Initial Conditions ==
* the trays temperature (OutletL.T);
* the trays liquid level (Level) OR the trays liquid flow (OutletL.F);
* (NoComps - 1) OutletL (OR OutletV) compositions for each tray;
	
* the top tank temperature (OutletL.T);
* the top tank liquid level (Level);
* (NoComps - 1) OutletL (OR OutletV) compositions;
	
* the bottom tank temperature (OutletL.T);
* the bottom tank liquid level (Level);
* (NoComps - 1) OutletL (OR OutletV) compositions.
"
	drive!(fields,_)
	return fields
end
User_Distillation_thermosyphon_subcooling(_::Dict{Symbol,Any})=begin
	newModel=User_Distillation_thermosyphon_subcooling()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(User_Distillation_thermosyphon_subcooling)
