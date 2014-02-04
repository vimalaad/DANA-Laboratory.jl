# Modelo simplificado gerador de vapor
type Gerador_Vapor_Simples
	Gerador_Vapor_Simples()=begin
		propterm=outers.propterm
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"Steam tables",
				:Type=>"water"
			]),
			Potencia(),
			Eficiencia(),
			Corrente ((Symbol=>Any)[
				:Symbol=>"_{in}"
			]),
			Corrente ((Symbol=>Any)[
				:Symbol=>"_{out}"
			]),
			[
				:(Fout.P = Fin.P),
				:([Fout.S,Fout.H] = propterm.propPTv(Fout.P,Fout.T)),
				:(Q_GV * EF_GV = Fin.F * (Fout.H - Fin.H)),
			],
			[
				"","","",
			],
			[:propterm,],
			[:Q_GV,:EF_GV,:Fin,:Fout,]
		)
	end
	propterm::DanaPlugin
	Q_GV::Potencia
	EF_GV::Eficiencia
	Fin::Corrente 
	Fout::Corrente 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Gerador_Vapor_Simples
function setEquationFlow(in::Gerador_Vapor_Simples)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	#	Fout.F = Fin.F;
	
end
function atributes(in::Gerador_Vapor_Simples,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/caldeira"
	drive!(fields,_)
	return fields
end
Gerador_Vapor_Simples(_::Dict{Symbol,Any})=begin
	newModel=Gerador_Vapor_Simples()
	newModel.attributes=atributes(newModel,_)
	newModel
end
