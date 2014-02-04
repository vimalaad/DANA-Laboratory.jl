# Modelo de gerador eletrico
type Gerador_Eletrico
	Gerador_Eletrico()=begin
		new(
			Eficiencia((Symbol=>Any)[
				:Brief=>"Eficiencia do gerador eletrico"
			]),
			Potencia((Symbol=>Any)[
				:Brief=>"Potencia do gerador eletrico"
			]),
			[:EF_GE,],
			[:POT_GE,]
		)
	end
	EF_GE::Eficiencia
	POT_GE::Potencia
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Gerador_Eletrico
function atributes(in::Gerador_Eletrico,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/gerador"
	drive!(fields,_)
	return fields
end
Gerador_Eletrico(_::Dict{Symbol,Any})=begin
	newModel=Gerador_Eletrico()
	newModel.attributes=atributes(newModel,_)
	newModel
end
