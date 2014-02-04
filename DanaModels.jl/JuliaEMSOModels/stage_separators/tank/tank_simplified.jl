#----------------------------------------------------------
#*
#*Model of a tank with a lain cylinder geometry
#*
#*---------------------------------------------------------
type tank_simplified
	tank_simplified()=begin
		new(
			DanaReal ((Symbol=>Any)[
				:Brief=>"Valve Constant",
				:Unit=>"m^2.5/h",
				:Default=>4
			]),
			area ((Symbol=>Any)[
				:Brief=>"Tank area",
				:Default=>2
			]),
			length((Symbol=>Any)[
				:Brief=>"Tank level"
			]),
			flow_vol((Symbol=>Any)[
				:Brief=>"Input flow",
				:PosX=>0.3037,
				:PosY=>0
			]),
			flow_vol((Symbol=>Any)[
				:Brief=>"Output flow",
				:PosX=>1,
				:PosY=>1
			]),
			[
				:(diff(A*Level) = Fin - Fout),
				:(Fout = k*sqrt(Level)),
			],
			[
				"Mass balance","Valve equation",
			],
			[:k,:A,],
			[:Level,:Fin,:Fout,]
		)
	end
	k::DanaReal 
	A::area 
	Level::length
	Fin::flow_vol
	Fout::flow_vol
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export tank_simplified
function setEquationFlow(in::tank_simplified)
	addEquation(1)
	addEquation(2)
end
function atributes(in::tank_simplified,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Tank"
	fields[:Brief]="Model of a simplified tank."
	fields[:Info]="== Specify ==
* the Inlet flow rate;

== Initial Conditions ==
* the tank initial level (Level);
"
	drive!(fields,_)
	return fields
end
tank_simplified(_::Dict{Symbol,Any})=begin
	newModel=tank_simplified()
	newModel.attributes=atributes(newModel,_)
	newModel
end
