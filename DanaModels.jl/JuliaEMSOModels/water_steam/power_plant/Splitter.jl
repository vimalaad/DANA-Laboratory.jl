# Modelo de separador de corrente
type Splitter
	Splitter()=begin
		new(
			Fracao((Symbol=>Any)[
				:Brief=>"Fracao de massa para a segunda corrente"
			]),
			Corrente ((Symbol=>Any)[
				:Symbol=>"_{in}"
			]),
			Corrente ((Symbol=>Any)[
				:Symbol=>"_{out}"
			]),
			Corrente((Symbol=>Any)[
				:Brief=>"Segunda corrente",
				:Symbol=>"_{outx}"
			]),
			[
				:(Fout.P = Fin.P),
				:(Fout.T = Fin.T),
				:(Fout.S = Fin.S),
				:(Fout.H = Fin.H),
				:(Fouts.P = Fin.P),
				:(Fouts.T = Fin.T),
				:(Fouts.S = Fin.S),
				:(Fouts.H = Fin.H),
				:(Fouts.F = Fin.F * y),
				:(Fout.F = Fin.F - Fouts.F),
			],
			[
				"","","","","","","","","","",
			],
			[:y,:Fin,:Fout,:Fouts,]
		)
	end
	y::Fracao
	Fin::Corrente 
	Fout::Corrente 
	Fouts::Corrente
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Splitter
function setEquationFlow(in::Splitter)
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
end
function atributes(in::Splitter,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/splitter"
	drive!(fields,_)
	return fields
end
Splitter(_::Dict{Symbol,Any})=begin
	newModel=Splitter()
	newModel.attributes=atributes(newModel,_)
	newModel
end
