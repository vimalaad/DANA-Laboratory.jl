# Modelo de gerador de vapor
type Gerador_Vapor
	Gerador_Vapor()=begin
		propterm=outers.propterm
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"Steam tables",
				:Type=>"water"
			]),
			Potencia ((Symbol=>Any)[
				:Brief=>"Taxa de calor gerado na caldeira"
			]),
			Eficiencia ((Symbol=>Any)[
				:Brief=>"Eficiencia do gerador de vapor"
			]),
			Potencia ((Symbol=>Any)[
				:Brief=>"Taxa de calor nos reaquecedores"
			]),
			Potencia ((Symbol=>Any)[
				:Brief=>"Taxa de calor nos superaquecedores"
			]),
			Potencia ((Symbol=>Any)[
				:Brief=>"Taxa de calor no evaporador"
			]),
			Potencia ((Symbol=>Any)[
				:Brief=>"Taxa de calor nos economizadores"
			]),
			Corrente ((Symbol=>Any)[
				:Brief=>"Agua de alimentacao",
				:Symbol=>"_{in_a}"
			]),
			Corrente ((Symbol=>Any)[
				:Brief=>"Vapor a ser Reaquecido",
				:Symbol=>"_{in_ra}"
			]),
			Corrente ((Symbol=>Any)[
				:Brief=>"Vapor Superaquecido",
				:Symbol=>"_{out_sa}"
			]),
			Corrente ((Symbol=>Any)[
				:Brief=>"Vapor Reaquecido",
				:Symbol=>"_{out_ra}"
			]),
			Corrente ((Symbol=>Any)[
				:Brief=>"Evaporador"
			]),
			Corrente ((Symbol=>Any)[
				:Brief=>"Economizadores"
			]),
			[
				:([Feco.S,Feco.H] = propterm.propPTv(Feco.P,Feco.T)),
				:(Qec = Feco.F * (Feco.H - Fin_a.H)),
				:(Fvap.F = Feco.F),
				:([Fvap.S,Fvap.H] = propterm.propPTv(Fvap.P,Fvap.T)),
				:(Qca = Fvap.F * (Fvap.H - Feco.H)),
				:(Fout_sa.F = Fvap.F),
				:([Fout_sa.S,Fout_sa.H] = propterm.propPTv(Fout_sa.P,Fout_sa.T)),
				:(Qsa = Fout_sa.F * (Fout_sa.H - Fvap.H)),
				:(Fout_ra.F = Fin_ra.F),
				:([Fout_ra.S,Fout_ra.H] = propterm.propPTv(Fout_ra.P,Fout_ra.T)),
				:(Qra = Fout_ra.F * (Fout_ra.H - Fin_ra.H)),
				:(Q_GV * EF_GV = Qec + Qca + Qsa + Qra),
			],
			[
				"Economizadores ECO1 + ECO1","","Evaporador - Camisa dagua","","","Superaquecedores BT + AT","","","Reaquecedores BT + AT","","","Caldeira",
			],
			[:propterm,],
			[:Q_GV,:EF_GV,:Qra,:Qsa,:Qca,:Qec,:Fin_a,:Fin_ra,:Fout_sa,:Fout_ra,:Fvap,:Feco,]
		)
	end
	propterm::DanaPlugin
	Q_GV::Potencia 
	EF_GV::Eficiencia 
	Qra::Potencia 
	Qsa::Potencia 
	Qca::Potencia 
	Qec::Potencia 
	Fin_a::Corrente 
	Fin_ra::Corrente 
	Fout_sa::Corrente 
	Fout_ra::Corrente 
	Fvap::Corrente 
	Feco::Corrente 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Gerador_Vapor
function setEquationFlow(in::Gerador_Vapor)
	#	[Fin_a.S,Fin_a.H] = propterm.propPTl(Fin_a.P,Fin_a.T); # Reduntante no ciclo fechado
	#	Feco.F = Fin_a.F; # Reduntante no ciclo fechado
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
	addEquation(11)
	addEquation(12)
end
function atributes(in::Gerador_Vapor,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/caldeira"
	drive!(fields,_)
	return fields
end
Gerador_Vapor(_::Dict{Symbol,Any})=begin
	newModel=Gerador_Vapor()
	newModel.attributes=atributes(newModel,_)
	newModel
end
