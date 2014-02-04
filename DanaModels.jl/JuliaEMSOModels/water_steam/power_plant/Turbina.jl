# Modelo de turbina sem sangria
type Turbina
	Turbina()=begin
		propterm=outers.propterm
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"Steam tables",
				:Type=>"water"
			]),
			Entalpia(),
			Eficiencia ((Symbol=>Any)[
				:Brief=>"Eficiencia da turbina"
			]),
			Potencia ((Symbol=>Any)[
				:Brief=>"Potencia da turbina"
			]),
			Corrente ((Symbol=>Any)[
				:Symbol=>"_{in}"
			]),
			Corrente ((Symbol=>Any)[
				:Symbol=>"_{out}"
			]),
			[
				:(H_IS = propterm.propPS(Fout.P,Fin.S)),
				:(Fout.H = (H_IS - Fin.H) * EF_T + Fin.H),
				:([Fout.S,Fout.T] = propterm.propPH(Fout.P,Fout.H)),
				:(Fin.F * (Fin.H - Fout.H) = POT_TURB),
				:(Fout.F = Fin.F),
			],
			[
				"","","","","",
			],
			[:propterm,],
			[:H_IS,:EF_T,:POT_TURB,:Fin,:Fout,]
		)
	end
	propterm::DanaPlugin
	H_IS::Entalpia
	EF_T::Eficiencia 
	POT_TURB::Potencia 
	Fin::Corrente 
	Fout::Corrente 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Turbina
function setEquationFlow(in::Turbina)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
end
function atributes(in::Turbina,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/turbina"
	drive!(fields,_)
	return fields
end
Turbina(_::Dict{Symbol,Any})=begin
	newModel=Turbina()
	newModel.attributes=atributes(newModel,_)
	newModel
end
