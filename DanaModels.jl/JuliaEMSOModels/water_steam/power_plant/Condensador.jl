# Modelo de condensador com uma alimentacao
type Condensador
	Condensador()=begin
		propterm=outers.propterm
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"Steam tables",
				:Type=>"water"
			]),
			Potencia ((Symbol=>Any)[
				:Brief=>"Taxa de calor removido"
			]),
			Dif_Temp ((Symbol=>Any)[
				:Brief=>"Grau de sub-resfriamento"
			]),
			Corrente ((Symbol=>Any)[
				:Symbol=>"_{in}"
			]),
			Corrente ((Symbol=>Any)[
				:Symbol=>"_{out}"
			]),
			[
				:(Fout.P = Fin.P),
				:(Fout.T = propterm.Tsat(Fout.P) - G_S),
				:([Fout.S,Fout.H] = propterm.propPTl(Fout.P,Fout.T)),
				:(Q_COND = Fin.F * (Fin.H - Fout.H)),
				:(Fout.F = Fin.F),
			],
			[
				"","","","","",
			],
			[:propterm,],
			[:Q_COND,:G_S,:Fin,:Fout,]
		)
	end
	propterm::DanaPlugin
	Q_COND::Potencia 
	G_S::Dif_Temp 
	Fin::Corrente 
	Fout::Corrente 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Condensador
function setEquationFlow(in::Condensador)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
end
function atributes(in::Condensador,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/condensador"
	drive!(fields,_)
	return fields
end
Condensador(_::Dict{Symbol,Any})=begin
	newModel=Condensador()
	newModel.attributes=atributes(newModel,_)
	newModel
end
