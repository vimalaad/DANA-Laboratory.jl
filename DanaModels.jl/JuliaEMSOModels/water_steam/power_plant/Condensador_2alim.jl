# Modelo de condensador com duas alimentacoes
type Condensador_2alim
	Condensador_2alim()=begin
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
				:Brief=>"Corrente com pressao igual a saida",
				:Symbol=>"_{in1}"
			]),
			Corrente ((Symbol=>Any)[
				:Symbol=>"_{in2}"
			]),
			Corrente ((Symbol=>Any)[
				:Symbol=>"_{out}"
			]),
			[
				:(Fout.P = Fin1.P),
				:(Fout.T = propterm.Tsat(Fout.P) - G_S),
				:([Fout.S,Fout.H] = propterm.propPTl(Fout.P,Fout.T)),
				:(Fout.F = Fin1.F + Fin2.F),
				:(Q_COND = Fin1.F * Fin1.H + Fin2.F * Fin2.H - Fout.F * Fout.H),
			],
			[
				"","","","","",
			],
			[:propterm,],
			[:Q_COND,:G_S,:Fin1,:Fin2,:Fout,]
		)
	end
	propterm::DanaPlugin
	Q_COND::Potencia 
	G_S::Dif_Temp 
	Fin1::Corrente 
	Fin2::Corrente 
	Fout::Corrente 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Condensador_2alim
function setEquationFlow(in::Condensador_2alim)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
end
function atributes(in::Condensador_2alim,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/condensador"
	drive!(fields,_)
	return fields
end
Condensador_2alim(_::Dict{Symbol,Any})=begin
	newModel=Condensador_2alim()
	newModel.attributes=atributes(newModel,_)
	newModel
end
