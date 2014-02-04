#----------------------------------------------------------------------
#* Model of a Steady State flash
#*---------------------------------------------------------------------
type flash_steady_bd
	flash_steady_bd()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger(),
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
			fraction ((Symbol=>Any)[
				:Brief=>"Vapourization fraction",
				:Symbol=>"\\phi"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Pressure Ratio",
				:Symbol=>"P_{ratio}"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Pressure Drop",
				:DisplayUnit=>"kPa",
				:Symbol=>"\\Delta P"
			]),
			temperature ((Symbol=>Any)[
				:Brief=>"Dew-point Temperature"
			]),
			temperature ((Symbol=>Any)[
				:Brief=>"Bubble-point Temperature"
			]),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Dew-point liquid composition"
			]),(NComp)),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Bubble-point Vapour composition"
			]),(NComp)),
			[
				:(PP.LiquidFugacityCoefficient(OutletL.T, OutletL.P, OutletL.z)*OutletL.z = PP.VapourFugacityCoefficient(OutletV.T, OutletV.P, OutletV.z)*OutletV.z),
				:(sum(OutletL.z) = sum(OutletV.z)),
				:(Inlet.F*Inlet.z = OutletL.F*OutletL.z + OutletV.F*OutletV.z),
				:(OutletL.z = Inlet.z),
				:(OutletV.z = y_bubble),
				:(vfrac = 0),
				:(OutletL.z = x_dew),
				:(OutletV.z = Inlet.z),
				:(vfrac = 1),
				:(PP.LiquidFugacityCoefficient(T_dew, OutletL.P, x_dew)*x_dew = PP.VapourFugacityCoefficient(T_dew, OutletV.P, Inlet.z)*Inlet.z),
				:(sum(x_dew) = 1),
				:(PP.LiquidFugacityCoefficient(T_bubble, OutletL.P, Inlet.z)*Inlet.z = PP.VapourFugacityCoefficient(T_bubble, OutletV.P, y_bubble)*y_bubble),
				:(sum(y_bubble) = 1),
				:(Inlet.F = OutletV.F + OutletL.F),
				:(OutletV.F = Inlet.F * vfrac),
				:(Inlet.F*Inlet.h + InletQ.Q = OutletL.F*OutletL.h + OutletV.F*OutletV.h),
				:(OutletV.T = OutletL.T),
				:(OutletV.P = OutletL.P),
				:(OutletL.P = Inlet.P - Pdrop),
				:(OutletL.P = Inlet.P * Pratio),
			],
			[
				"The flash calculation","Composition constraint","Component Molar Balance","Bubble-point result","","","Dew-point result","","","Dew-point equations","","Bubble-point equations","","Global Molar Balance","Vaporization Fraction","Energy Balance","Thermal Equilibrium","Mechanical Equilibrium","Pressure Drop","Pressure Ratio",
			],
			[:PP,:NComp,],
			[:Inlet,:OutletL,:OutletV,:InletQ,:vfrac,:Pratio,:Pdrop,:T_dew,:T_bubble,:x_dew,:y_bubble,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	Inlet::stream
	OutletL::liquid_stream
	OutletV::vapour_stream
	InletQ::energy_stream 
	vfrac::fraction 
	Pratio::positive 
	Pdrop::press_delta 
	T_dew::temperature 
	T_bubble::temperature 
	x_dew::Array{fraction }
	y_bubble::Array{fraction }
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export flash_steady_bd
function setEquationFlow(in::flash_steady_bd)
	if OutletL.T > T_bubble && OutletL.T < T_dew 
		addEquation(1)
		addEquation(2)
		addEquation(3)
	else
		if OutletL.T <= T_bubble 
			addEquation(4)
			addEquation(5)
			addEquation(6)
		else
			addEquation(7)
			addEquation(8)
			addEquation(9)
		end
	end
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
end
function atributes(in::flash_steady_bd,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Flash"
	fields[:Brief]="Model of a Steady State flash."
	fields[:Info]="== Assumptions ==
* both phases are perfectly mixed.
	
== Specify ==
* the feed stream;
* the outlet pressure (OutletV.P);
* the outlet temperature OR the heat supplied.
"
	drive!(fields,_)
	return fields
end
flash_steady_bd(_::Dict{Symbol,Any})=begin
	newModel=flash_steady_bd()
	newModel.attributes=atributes(newModel,_)
	newModel
end
