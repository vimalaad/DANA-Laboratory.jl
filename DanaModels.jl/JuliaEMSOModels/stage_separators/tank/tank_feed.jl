#----------------------------------------------------------
#*
#*Model of a tank with a lain cylinder geometry
#*
#*---------------------------------------------------------
type tank_feed
	tank_feed()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger(),
			area ((Symbol=>Any)[
				:Brief=>"Tank cross section area",
				:Default=>2
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Feed stream",
				:PosX=>0.32,
				:PosY=>0,
				:Symbol=>"_{feed}"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet stream",
				:PosX=>0.3037,
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
				:PosY=>0.7859,
				:Symbol=>"_{in}"
			]),
			length((Symbol=>Any)[
				:Brief=>"Tank level"
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
				:(diff(M) = Feed.F*Feed.z + Inlet.F*Inlet.z - Outlet.F*Outlet.z),
				:(diff(E) = Feed.F*Feed.h + Inlet.F*Inlet.h - Outlet.F*Outlet.h + InletQ.Q),
				:(E = sum(M)*Outlet.h),
				:(Inlet.P = Outlet.P),
				:(vL = PP.LiquidVolume(Outlet.T, Outlet.P, Outlet.z)),
				:(M = Outlet.z*sum(M)),
				:(Level = sum(M)*vL/Across),
			],
			[
				"Mass balance","Energy balance","Energy Holdup","Mechanical Equilibrium","Liquid Volume","Composition","Level of liquid phase",
			],
			[:PP,:NComp,:Across,],
			[:Feed,:Inlet,:Outlet,:InletQ,:Level,:M,:E,:vL,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	Across::area 
	Feed::stream 
	Inlet::stream 
	Outlet::liquid_stream 
	InletQ::energy_stream 
	Level::length
	M::Array{mol }
	E::energy 
	vL::volume_mol 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export tank_feed
function setEquationFlow(in::tank_feed)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
	addEquation(7)
end
function atributes(in::tank_feed,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Tank"
	fields[:Brief]="Model of a tank with feed stream."
	fields[:Info]="== Specify ==
* the Inlet stream;
* the Feed stream;
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
tank_feed(_::Dict{Symbol,Any})=begin
	newModel=tank_feed()
	newModel.attributes=atributes(newModel,_)
	newModel
end
