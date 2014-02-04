#----------------------------------------------------------------------
#* Another model of a steady-state PH flash.
#* It is recommended to use [v,x,y]=PP.FlashPH(P,h,z) instead of.
#*---------------------------------------------------------------------
type FlashPHSteadyA
	FlashPHSteadyA()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger(),
			DanaReal((Symbol=>Any)[
				:Default=>1000,
				:Brief=>"Regularization Factor"
			]),
			stream((Symbol=>Any)[
				:Brief=>"Feed Stream",
				:PosX=>0,
				:PosY=>0.5421,
				:Symbol=>"_{in}"
			]),
			liquid_stream((Symbol=>Any)[
				:Brief=>"Liquid outlet stream",
				:PosX=>0.4790,
				:PosY=>1,
				:Symbol=>"_{outL}"
			]),
			vapour_stream((Symbol=>Any)[
				:Brief=>"Vapour outlet stream",
				:PosX=>0.4877,
				:PosY=>0,
				:Symbol=>"_{outV}"
			]),
			energy_stream ((Symbol=>Any)[
				:Brief=>"Rate of heat supply",
				:PosX=>1,
				:PosY=>0.7559,
				:Symbol=>"_{in}"
			]),
			fraction((Symbol=>Any)[
				:Brief=>"Vaporization fraction",
				:Symbol=>"\\phi"
			]),
			DanaReal((Symbol=>Any)[
				:Lower=>-0.1,
				:Upper=>1.1,
				:Brief=>"Vaporization fraction if saturated",
				:Symbol=>"\\phi_{sat}"
			]),
			temperature((Symbol=>Any)[
				:Lower=>173,
				:Upper=>1473,
				:Brief=>"Temperature if saturated"
			]),
			fill(DanaReal((Symbol=>Any)[
				:Lower=>0,
				:Upper=>1,
				:Brief=>"Liquid composition if saturated"
			]),(NComp)),
			fill(DanaReal((Symbol=>Any)[
				:Lower=>0,
				:Upper=>1,
				:Brief=>"Vapour composition if saturated"
			]),(NComp)),
			positive ((Symbol=>Any)[
				:Brief=>"Pressure Ratio",
				:Symbol=>"P_{ratio}"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Pressure Drop",
				:DisplayUnit=>"kPa",
				:Symbol=>"\\Delta P"
			]),
			fraction((Symbol=>Any)[
				:Brief=>"Regularization Variable"
			]),
			fraction((Symbol=>Any)[
				:Brief=>"Regularization Variable"
			]),
			[
				:(PP.LiquidFugacityCoefficient(Tsat, OutletL.P, xsat)*xsat = PP.VapourFugacityCoefficient(Tsat, OutletV.P, ysat)*ysat),
				:(Inlet.F = OutletV.F + OutletL.F),
				:(OutletV.F = Inlet.F * vfrac),
				:(Inlet.F*Inlet.z = OutletL.F*xsat + OutletV.F*ysat),
				:(sum(xsat) = sum(ysat)),
				:(Inlet.F*Inlet.h + InletQ.Q = Inlet.F*(1-vsat)*PP.LiquidEnthalpy(Tsat, OutletL.P, xsat) + Inlet.F*vsat*PP.VapourEnthalpy(Tsat, OutletV.P, ysat)),
				:(Inlet.F*Inlet.h + InletQ.Q = Inlet.F*(1-vfrac)*OutletL.h + Inlet.F*vfrac*OutletV.h),
				:(OutletV.T = OutletL.T),
				:(OutletV.P = OutletL.P),
				:(OutletL.P = Inlet.P - Pdrop),
				:(OutletL.P = Inlet.P * Pratio),
				:(zero_one = (1 + tanh(B * vsat))/2),
				:(one_zero = (1 - tanh(B * (vsat - 1)))/2),
				:(vfrac = zero_one * one_zero * vsat + 1 - one_zero),
				:(OutletL.z = zero_one*one_zero*xsat + (1-zero_one*one_zero)*Inlet.z),
				:(OutletV.z = zero_one*one_zero*ysat + (1-zero_one*one_zero)*Inlet.z),
			],
			[
				"Chemical equilibrium","Global Molar Balance","","Component Molar Balance","","Energy Balance if saturated","Real Energy Balance","Thermal Equilibrium","Mechanical Equilibrium","Pressure Drop","Pressure Ratio","","","","","",
			],
			[:PP,:NComp,:B,],
			[:Inlet,:OutletL,:OutletV,:InletQ,:vfrac,:vsat,:Tsat,:xsat,:ysat,:Pratio,:Pdrop,:zero_one,:one_zero,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	B::DanaReal
	Inlet::stream
	OutletL::liquid_stream
	OutletV::vapour_stream
	InletQ::energy_stream 
	vfrac::fraction
	vsat::DanaReal
	Tsat::temperature
	xsat::Array{DanaReal}
	ysat::Array{DanaReal}
	Pratio::positive 
	Pdrop::press_delta 
	zero_one::fraction
	one_zero::fraction
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export FlashPHSteadyA
function setEquationFlow(in::FlashPHSteadyA)
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
	# regularization functions
	addEquation(12)
	addEquation(13)
	addEquation(14)
	addEquation(15)
	addEquation(16)
end
function atributes(in::FlashPHSteadyA,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Flash"
	fields[:Brief]="Another model of a static PH flash."
	fields[:Info]="This model shows how to model a pressure enthalpy flash
directly with the EMSO modeling language.

This model is for demonstration purposes only, the flashPH
routine available on VRTherm is much more robust.

== Assumptions ==
* perfect mixing of both phases;

== Specify ==
* the feed stream;
* the heat duty;
* the outlet pressure.
"
	drive!(fields,_)
	return fields
end
FlashPHSteadyA(_::Dict{Symbol,Any})=begin
	newModel=FlashPHSteadyA()
	newModel.attributes=atributes(newModel,_)
	newModel
end
