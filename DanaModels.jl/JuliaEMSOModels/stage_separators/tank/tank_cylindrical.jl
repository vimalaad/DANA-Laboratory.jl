#----------------------------------------------------------
#*
#*Model of a tank with a lain cylinder geometry
#*
#*---------------------------------------------------------
type tank_cylindrical
	tank_cylindrical()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger(),
			length((Symbol=>Any)[
				:Brief=>"Tank radius"
			]),
			length((Symbol=>Any)[
				:Brief=>"Tank length"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet stream",
				:PosX=>0.1825,
				:PosY=>0,
				:Symbol=>"_{in}"
			]),
			liquid_stream ((Symbol=>Any)[
				:Brief=>"Outlet liquid stream",
				:PosX=>1,
				:PosY=>1,
				:Symbol=>"_{out}"
			]),
			energy_stream ((Symbol=>Any)[
				:Brief=>"Rate of heat supply",
				:PosX=>1,
				:PosY=>0.6160,
				:Symbol=>"_{in}"
			]),
			length((Symbol=>Any)[
				:Brief=>"Tank level"
			]),
			area ((Symbol=>Any)[
				:Brief=>"Tank cross section area",
				:Default=>2
			]),
			fill(mol ((Symbol=>Any)[
				:Brief=>"Molar Holdup in the tank"
			]),(NComp)),
			energy ((Symbol=>Any)[
				:Brief=>"Total Energy Holdup on tank"
			]),
			volume_mol ((Symbol=>Any)[
				:Brief=>"Liquid Molar Volume"
			]),
			[
				:(diff(M) = Inlet.F*Inlet.z - Outlet.F*Outlet.z),
				:(diff(E) = Inlet.F*Inlet.h - Outlet.F*Outlet.h + InletQ.Q),
				:(E = sum(M)*Outlet.h),
				:(Inlet.P = Outlet.P),
				:(vL = PP.LiquidVolume(Outlet.T, Outlet.P, Outlet.z)),
				:(M = Outlet.z*sum(M)),
				:(Across = radius^2 * (asin(1) - asin((radius-Level)/radius) ) + (Level-radius)*sqrt(Level*(2*radius - Level))),
				:(L*Across = sum(M)*vL),
			],
			[
				"Mass balance","Energy balance","Energy Holdup","Mechanical Equilibrium","Liquid Volume","Composition","Cylindrical Area","Level of liquid phase",
			],
			[:PP,:NComp,:radius,:L,],
			[:Inlet,:Outlet,:InletQ,:Level,:Across,:M,:E,:vL,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	radius::length
	L::length
	Inlet::stream 
	Outlet::liquid_stream 
	InletQ::energy_stream 
	Level::length
	Across::area 
	M::Array{mol }
	E::energy 
	vL::volume_mol 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export tank_cylindrical
function setEquationFlow(in::tank_cylindrical)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
	addEquation(7)
	addEquation(8)
end
function atributes(in::tank_cylindrical,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/TankHorizontal"
	fields[:Brief]="Model of a tank with a lain cylinder geometry."
	fields[:Info]="== Specify ==
* the Inlet stream;
* the outlet flow;
* the tank Q.

== Initial Conditions ==
* the tank initial temperature (OutletL.T);
* the tank initial level (Level);
* (NoComps - 1) OutletL (OR OutletV) compositions.
"
	drive!(fields,_)
	return fields
end
tank_cylindrical(_::Dict{Symbol,Any})=begin
	newModel=tank_cylindrical()
	newModel.attributes=atributes(newModel,_)
	newModel
end
