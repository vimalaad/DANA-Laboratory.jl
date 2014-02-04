# Modelo de bomba
type Bomba
	Bomba()=begin
		propterm=outers.propterm
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"Steam tables",
				:Type=>"water"
			]),
			VolumeEspecifico(),
			Entalpia(),
			Potencia((Symbol=>Any)[
				:Brief=>"Potencia do motor da bomba"
			]),
			Potencia((Symbol=>Any)[
				:Brief=>"Potencia injetada pela bomba"
			]),
			Eficiencia((Symbol=>Any)[
				:Brief=>"Eficiencia da bomba"
			]),
			Corrente ((Symbol=>Any)[
				:Symbol=>"_{in}"
			]),
			Corrente ((Symbol=>Any)[
				:Symbol=>"_{out}"
			]),
			[
				:(H_IS = propterm.propPS(Fout.P,Fin.S)),
				:((Fout.H - Fin.H) * EF_B = H_IS - Fin.H),
				:([Fout.S,Fout.T] = propterm.propPH(Fout.P,Fout.H)),
				:(POT_EF = POT_BMB * EF_B),
				:(POT_EF = Fin.F * v_esp * (Fout.P - Fin.P)),
				:(Fout.F = Fin.F),
			],
			[
				"","","","","","",
			],
			[:propterm,:v_esp,],
			[:H_IS,:POT_BMB,:POT_EF,:EF_B,:Fin,:Fout,]
		)
	end
	propterm::DanaPlugin
	v_esp::VolumeEspecifico
	H_IS::Entalpia
	POT_BMB::Potencia
	POT_EF::Potencia
	EF_B::Eficiencia
	Fin::Corrente 
	Fout::Corrente 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Bomba
function setEquationFlow(in::Bomba)
	addEquation(1)
	addEquation(2)
	#	(Fout.H - Fin.H) * Fin.F = POT_EF; # Forma alternativa
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
end
function atributes(in::Bomba,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/bomba1"
	drive!(fields,_)
	return fields
end
Bomba(_::Dict{Symbol,Any})=begin
	newModel=Bomba()
	newModel.attributes=atributes(newModel,_)
	newModel
end
