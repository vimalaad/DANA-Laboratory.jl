# Modelo de turbina com sangria
type Turbina_sangra
	Turbina_sangra()=begin
		propterm=outers.propterm
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"Steam tables",
				:Type=>"water"
			]),
			Entalpia(),
			Eficiencia((Symbol=>Any)[
				:Brief=>"Eficiencia da turbina"
			]),
			Potencia((Symbol=>Any)[
				:Brief=>"Potencia da turbina"
			]),
			Fracao((Symbol=>Any)[
				:Brief=>"Fracao massica da sangria"
			]),
			Corrente ((Symbol=>Any)[
				:Symbol=>"_{in}"
			]),
			Corrente ((Symbol=>Any)[
				:Symbol=>"_{out}"
			]),
			Corrente ((Symbol=>Any)[
				:Symbol=>"_{outx}"
			]),
			[
				:(H_IS = propterm.propPS(Fout.P,Fin.S)),
				:(Fout.H = (H_IS - Fin.H) * EF_T + Fin.H),
				:([Fout.S,Fout.T] = propterm.propPH(Fout.P,Fout.H)),
				:(Fin.F * (Fin.H - Fout.H) = POT_TURB),
				:(Fouts.F = Fin.F * y),
				:(Fout.F = Fin.F - Fouts.F),
				:(Fouts.P = Fout.P),
				:(Fouts.T = Fout.T),
				:(Fouts.S = Fout.S),
				:(Fouts.H = Fout.H),
			],
			[
				"","","","","","","","","","",
			],
			[:propterm,],
			[:H_IS,:EF_T,:POT_TURB,:y,:Fin,:Fout,:Fouts,]
		)
	end
	propterm::DanaPlugin
	H_IS::Entalpia
	EF_T::Eficiencia
	POT_TURB::Potencia
	y::Fracao
	Fin::Corrente 
	Fout::Corrente 
	Fouts::Corrente 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Turbina_sangra
function setEquationFlow(in::Turbina_sangra)
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
function atributes(in::Turbina_sangra,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/turbina_sa"
	drive!(fields,_)
	return fields
end
Turbina_sangra(_::Dict{Symbol,Any})=begin
	newModel=Turbina_sangra()
	newModel.attributes=atributes(newModel,_)
	newModel
end
