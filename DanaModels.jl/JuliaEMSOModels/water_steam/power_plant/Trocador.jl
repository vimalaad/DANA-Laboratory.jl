# Modelo de trocador de calor, dada a carga termica
type Trocador
	Trocador()=begin
		propterm=outers.propterm
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"Steam tables",
				:Type=>"water"
			]),
			Potencia(),
			Dif_Pres(),
			Corrente ((Symbol=>Any)[
				:Symbol=>"_{in}"
			]),
			Corrente ((Symbol=>Any)[
				:Symbol=>"_{out}"
			]),
			[
				:(Fout.F = Fin.F),
				:(Fout.P = Fin.P - DP),
				:(Fout.F * (Fout.H - Fin.H) = Q),
				:([Fout.S,Fout.T] = propterm.propPH(Fout.P,Fout.H)),
			],
			[
				"","","","",
			],
			[:propterm,],
			[:Q,:DP,:Fin,:Fout,]
		)
	end
	propterm::DanaPlugin
	Q::Potencia
	DP::Dif_Pres
	Fin::Corrente 
	Fout::Corrente 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
end
export Trocador
function setEquationFlow(in::Trocador)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
end
