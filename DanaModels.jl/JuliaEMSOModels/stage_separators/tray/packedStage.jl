#-------------------------------------
#* Model of a packed column stage
#-------------------------------------
type packedStage
	packedStage()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger(),
			volume((Symbol=>Any)[
				:Brief=>"Total Volume of the tray"
			]),
			heat_rate ((Symbol=>Any)[
				:Brief=>"Rate of heat supply"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Column diameter"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"surface area per packing volume",
				:Unit=>"m^2/m^3"
			]),
			acceleration(),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Void fraction of packing, m^3/m^3"
			]),
			fill(molweight ((Symbol=>Any)[
				:Brief=>"Component Mol Weight"
			]),(NComp)),
			length ((Symbol=>Any)[
				:Brief=>"Height of the packing stage"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Resistance coefficient on the liquid load",
				:Default=>0.6
			]),
			DanaSwitcher((Symbol=>Any)[
				:Valid=>["on", "off"],
				:Default=>"on"
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
				:Brief=>"Molar Holdup in the tray",
				:Default=>0.01,
				:Lower=>0,
				:Upper=>100
			]),(NComp)),
			mol ((Symbol=>Any)[
				:Brief=>"Molar liquid holdup",
				:Default=>0.01,
				:Lower=>0,
				:Upper=>100
			]),
			mol ((Symbol=>Any)[
				:Brief=>"Molar vapour holdup",
				:Default=>0.01,
				:Lower=>0,
				:Upper=>100
			]),
			energy ((Symbol=>Any)[
				:Brief=>"Total Energy Holdup on tray",
				:Default=>-500
			]),
			volume_mol ((Symbol=>Any)[
				:Brief=>"Liquid Molar Volume"
			]),
			volume_mol ((Symbol=>Any)[
				:Brief=>"Vapour Molar volume"
			]),
			viscosity ((Symbol=>Any)[
				:Brief=>"Liquid dynamic viscosity",
				:DisplayUnit=>"kg/m/s"
			]),
			dens_mass(),
			dens_mass(),
			pressure((Symbol=>Any)[
				:Lower=>-10
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"volume flow rate of liquid, m^3/m^2/s",
				:Lower=>0,
				:Upper=>100
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"volume flow rate of vapor, m^3/m^2/s",
				:Lower=>0,
				:Upper=>100
			]),
			area ((Symbol=>Any)[
				:Brief=>"Area occupied by the liquid",
				:Default=>0.001,
				:Upper=>10
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Column holdup",
				:Unit=>"m^3/m^3",
				:Default=>0.04,
				:Upper=>1
			]),
			[
				:(diff(M)=Inlet.F*Inlet.z + InletL.F*InletL.z + InletV.F*InletV.z - OutletL.F*OutletL.z - OutletV.F*OutletV.z),
				:(diff(E) = ( Inlet.F*Inlet.h + InletL.F*InletL.h + InletV.F*InletV.h - OutletL.F*OutletL.h - OutletV.F*OutletV.h + Q )),
				:(M = ML*OutletL.z + MV*OutletV.z),
				:(E = ML*OutletL.h + MV*OutletV.h - OutletL.P*V),
				:(sum(OutletL.z)= 1.0),
				:(sum(OutletL.z)=sum(OutletV.z)),
				:(vL = PP.LiquidVolume(OutletL.T, OutletL.P, OutletL.z)),
				:(vV = PP.VapourVolume(OutletV.T, OutletV.P, OutletV.z)),
				:(PP.LiquidFugacityCoefficient(OutletL.T, OutletL.P, OutletL.z)*OutletL.z = PP.VapourFugacityCoefficient(OutletV.T, OutletV.P, OutletV.z)*OutletV.z),
				:(OutletV.T = OutletL.T),
				:(OutletL.P = OutletV.P),
				:(V*e = ML*vL + MV*vV),
				:(rhoL = PP.LiquidDensity(OutletL.T, OutletL.P, OutletL.z)),
				:(rhoV = PP.VapourDensity(InletV.T, InletV.P, InletV.z)),
				:(miL = PP.LiquidViscosity(OutletL.T, OutletL.P, OutletL.z)),
				:(Al = ML*vL/hs),
				:(uL * Al = OutletL.F * vL),
				:(uV * (V*e/hs - Al) = InletV.F * vV),
				:(hl*V*e = ML*vL),
				:(hl^3 = (12/g) * a^2 * (miL/rhoL) * uL),
				:(deltaP/hs = Qsil * (a/2 + 2/d) * 1/((e-hl)^3) * (uV^2) * rhoV),
				:(InletV.F = 0 * "mol/s"),
				:(deltaP = InletV.P - OutletV.P),
			],
			[
				"Component Molar Balance","Energy Balance","Molar Holdup","Energy Holdup","Mol fraction normalisation","","Liquid Volume","Vapour Volume","Chemical Equilibrium","Thermal Equilibrium","Mechanical Equilibrium","Geometry Constraint","Liquid Density","Vapour Density","Liquid viscosity","Area occupied by the liquid","Volume flow rate of liquid, m^3/m^2/s","Volume flow rate of vapor, m^3/m^2/s","Liquid holdup","Liquid velocity as a function of liquid holdup, Billet (4-27)","Pressure drop and Vapor flow, Billet (4-58)","","Pressure profile",
			],
			[:PP,:NComp,:V,:Q,:d,:a,:g,:e,:Mw,:hs,:Qsil,:VapourFlow,],
			[:Inlet,:InletL,:InletV,:OutletL,:OutletV,:M,:ML,:MV,:E,:vL,:vV,:miL,:rhoL,:rhoV,:deltaP,:uL,:uV,:Al,:hl,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	V::volume
	Q::heat_rate 
	d::length 
	a::DanaReal 
	g::acceleration
	e::DanaReal 
	Mw::Array{molweight }
	hs::length 
	Qsil::positive 
	VapourFlow::DanaSwitcher
	Inlet::stream 
	InletL::stream 
	InletV::stream 
	OutletL::liquid_stream 
	OutletV::vapour_stream 
	M::Array{mol }
	ML::mol 
	MV::mol 
	E::energy 
	vL::volume_mol 
	vV::volume_mol 
	miL::viscosity 
	rhoL::dens_mass
	rhoV::dens_mass
	deltaP::pressure
	uL::velocity 
	uV::velocity 
	Al::area 
	hl::positive 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export packedStage
function set(in::packedStage)
	Mw = PP.MolecularWeight()
	 
end
function setEquationFlow(in::packedStage)
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
	let switch=VapourFlow
		if VapourFlow==InletV.F < 1e-6 * "kmol/h"
			set(switch,"off")
		end
		if VapourFlow==deltaP > 1e-4 * "atm"
			set(switch,"on")
		end
		if switch=="on"
			addEquation(21)
		elseif switch=="off"
			addEquation(22)
		end
	end
	addEquation(23)
end
function atributes(in::packedStage,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Icon]="icon/PackedStage"
	fields[:Brief]="Complete model of a packed column stage."
	fields[:Info]="== Specify ==
* the Feed stream
* the Liquid inlet stream
* the Vapour inlet stream
* the stage pressure drop (deltaP)
	
== Initial ==
* the plate temperature (OutletL.T)
* the liquid molar holdup ML
* (NoComps - 1) OutletL compositions
"
	drive!(fields,_)
	return fields
end
packedStage(_::Dict{Symbol,Any})=begin
	newModel=packedStage()
	newModel.attributes=atributes(newModel,_)
	newModel
end
