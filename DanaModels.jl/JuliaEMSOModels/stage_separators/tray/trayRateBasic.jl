#-------------------------------------
#* Nonequilibrium Model
#-------------------------------------
type trayRateBasic
	trayRateBasic()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger(),
			DanaInteger(),
			volume((Symbol=>Any)[
				:Brief=>"Total Volume of the tray"
			]),
			heat_rate ((Symbol=>Any)[
				:Brief=>"Rate of heat supply"
			]),
			area ((Symbol=>Any)[
				:Brief=>"Plate area = Atray - Adowncomer"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Feed stream",
				:PosX=>0,
				:PosY=>0.4932,
				:Symbol=>"_{in}"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Feed stream",
				:PosX=>0,
				:PosY=>0.4932,
				:Symbol=>"_{in}"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet liquid stream",
				:PosX=>0.5195,
				:PosY=>0,
				:Symbol=>"_{inL}"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet vapour stream",
				:PosX=>0.4994,
				:PosY=>1,
				:Symbol=>"_{inV}"
			]),
			liquid_stream ((Symbol=>Any)[
				:Brief=>"Outlet liquid stream",
				:PosX=>0.8277,
				:PosY=>1,
				:Symbol=>"_{outL}"
			]),
			vapour_stream ((Symbol=>Any)[
				:Brief=>"Outlet vapour stream",
				:PosX=>0.8043,
				:PosY=>0,
				:Symbol=>"_{outV}"
			]),
			fill(mol ((Symbol=>Any)[
				:Brief=>"Liquid Molar Holdup in the tray"
			]),(NComp)),
			fill(mol ((Symbol=>Any)[
				:Brief=>"Vapour Molar Holdup in the tray"
			]),(NComp)),
			mol ((Symbol=>Any)[
				:Brief=>"Molar liquid holdup"
			]),
			mol ((Symbol=>Any)[
				:Brief=>"Molar vapour holdup"
			]),
			energy ((Symbol=>Any)[
				:Brief=>"Total Liquid Energy Holdup on tray"
			]),
			energy ((Symbol=>Any)[
				:Brief=>"Total Vapour Energy Holdup on tray"
			]),
			volume_mol ((Symbol=>Any)[
				:Brief=>"Liquid Molar Volume"
			]),
			volume_mol ((Symbol=>Any)[
				:Brief=>"Vapour Molar volume"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Height of clear liquid on plate"
			]),
			interface(),
			[
				:(diff(M_liq)=Inlet.F*Inlet.z + InletL.F*InletL.z - OutletL.F*OutletL.z + interf.NL),
				:(diff(M_vap)=InletFV.F*InletFV.z + InletV.F*InletV.z - OutletV.F*OutletV.z - interf.NV),
				:(diff(E_liq) = Inlet.F*Inlet.h + InletL.F*InletL.h - OutletL.F*OutletL.h + Q + interf.E_liq),
				:(diff(E_vap) = InletFV.F*InletFV.h + InletV.F*InletV.h - OutletV.F*OutletV.h - interf.E_vap),
				:(M_liq = ML*OutletL.z),
				:(M_vap = MV*OutletV.z),
				:(E_liq = ML*(OutletL.h - OutletL.P*vL)),
				:(E_vap = MV*(OutletV.h - OutletV.P*vV)),
				:(interf.E_liq = interf.htL*interf.a*(interf.T-OutletL.T)+sum(interf.NL)*interf.hL),
				:(interf.E_vap = interf.htV*interf.a*(OutletV.T-interf.T)+sum(interf.NV)*interf.hV),
				:(interf.NL = interf.NV),
				:(interf.E_liq = interf.E_vap),
				:(sum(OutletL.z)= 1.0),
				:(sum(OutletL.z)= sum(OutletV.z)),
				:(sum(interf.x)=1.0),
				:(sum(interf.x)=sum(interf.y)),
				:(vL = PP.LiquidVolume(OutletL.T, OutletL.P, OutletL.z)),
				:(vV = PP.VapourVolume(OutletV.T, OutletV.P, OutletV.z)),
				:(PP.LiquidFugacityCoefficient(interf.T, interf.P, interf.x)*interf.x = PP.VapourFugacityCoefficient(interf.T, interf.P, interf.y)*interf.y),
				:(V = ML*vL + MV*vV),
				:(Level = ML*vL/Ap),
				:(interf.NL(1:NC1)=interf.a*sumt(interf.kL*(interf.x(1:NC1)-OutletL.z(1:NC1)))/vL+ OutletL.z(1:NC1)*sum(interf.NL)),
				:(interf.NV(1:NC1)=interf.a*sumt(interf.kV*(OutletV.z(1:NC1)-interf.y(1:NC1)))/vV+ OutletV.z(1:NC1)*sum(interf.NV)),
				:(OutletV.P = OutletL.P),
				:(interf.P=OutletL.P),
			],
			[
				"Component Molar Balance","","Energy Balance","","Molar Holdup","","Energy Holdup","","Energy Rate through the interface","","Mass Conservation","Energy Conservation","Mol fraction normalisation","","","","Liquid Volume","Vapour Volume","Chemical Equilibrium","Geometry Constraint","Level of clear liquid over the weir","Total Mass Transfer Rates","","Mechanical Equilibrium","",
			],
			[:PP,:NComp,:NC1,:V,:Q,:Ap,],
			[:Inlet,:InletFV,:InletL,:InletV,:OutletL,:OutletV,:M_liq,:M_vap,:ML,:MV,:E_liq,:E_vap,:vL,:vV,:Level,:interf,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	NC1::DanaInteger
	V::volume
	Q::heat_rate 
	Ap::area 
	Inlet::stream 
	InletFV::stream 
	InletL::stream 
	InletV::stream 
	OutletL::liquid_stream 
	OutletV::vapour_stream 
	M_liq::Array{mol }
	M_vap::Array{mol }
	ML::mol 
	MV::mol 
	E_liq::energy 
	E_vap::energy 
	vL::volume_mol 
	vV::volume_mol 
	Level::length 
	interf::interface
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export trayRateBasic
function set(in::trayRateBasic)
	NC1=NComp-1
	 
end
function setEquationFlow(in::trayRateBasic)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
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
	addEquation(19)
	addEquation(20)
	addEquation(21)
	addEquation(22)
	#	interf.NL(1:NC1)=0.01*'kmol/s';
	addEquation(23)
	addEquation(24)
	addEquation(25)
end
function atributes(in::trayRateBasic,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Icon]="icon/Tray"
	fields[:Brief]="Basic equations of a tray rate column model."
	fields[:Info]="This model contains only the main equations of a column tray nonequilibrium model without
the hidraulic equations.
	
== Assumptions ==
* both phases (liquid and vapour) exists all the time;
* no entrainment of liquid or vapour phase;
* no weeping;
* the dymanics in the downcomer are neglected.
"
	drive!(fields,_)
	return fields
end
trayRateBasic(_::Dict{Symbol,Any})=begin
	newModel=trayRateBasic()
	newModel.attributes=atributes(newModel,_)
	newModel
end
