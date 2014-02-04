# Modelo de torre de refrigeracao
type Torre
	Torre()=begin
		new(
			CalorEspecifico(),
			VazaoMassica(),
			Potencia(),
			Dif_Temp(),
			Dif_Temp(),
			Dif_Temp(),
			Temperatura(),
			Temperatura(),
			Temperatura(),
			Temperatura(),
			CoefGlobal_area(),
			[
				:(DTar = Tar_h - Tar_c),
				:(DTh = Th - Tar_h),
				:(DTc = Tc - Tar_c),
				:(F * cpa * (Th - Tc) = Q),
				:(Uat * (DTh - DTc) = Q * ln(abs(DTh/DTc))),
			],
			[
				"","","","","",
			],
			[:cpa,],
			[:F,:Q,:DTh,:DTc,:DTar,:Th,:Tc,:Tar_c,:Tar_h,:Uat,]
		)
	end
	cpa::CalorEspecifico
	F::VazaoMassica
	Q::Potencia
	DTh::Dif_Temp
	DTc::Dif_Temp
	DTar::Dif_Temp
	Th::Temperatura
	Tc::Temperatura
	Tar_c::Temperatura
	Tar_h::Temperatura
	Uat::CoefGlobal_area
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Torre
function setEquationFlow(in::Torre)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	#	Uat * 0.5 * (DTh + DTc) = Q;
	
end
function atributes(in::Torre,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/torreresf"
	drive!(fields,_)
	return fields
end
Torre(_::Dict{Symbol,Any})=begin
	newModel=Torre()
	newModel.attributes=atributes(newModel,_)
	newModel
end
