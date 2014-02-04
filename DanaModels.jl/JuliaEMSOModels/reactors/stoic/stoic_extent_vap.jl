#---------------------------------------------------------------------
#*	1. extent of reactions are known
#*--------------------------------------------------------------------
type stoic_extent_vap
	stoic_extent_vap()=begin
		new(
			stoic_vap(),
			fill(flow_mol ((Symbol=>Any)[
				:Brief=>"Extent of reaction",
				:Symbol=>"\\xi"
			]),(NReac)),
			[
				:(_P1.rate*_P1._P1._P1.Tank.V = sumt(_P1.stoic*extent)),
			],
			[
				"Rate of reaction",
			],
			[:extent,]
		)
	end
	_P1::stoic_vap
	extent::Array{flow_mol }
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export stoic_extent_vap
function setEquationFlow(in::stoic_extent_vap)
	addEquation(1)
end
function atributes(in::stoic_extent_vap,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/cstr"
	fields[:Brief]="Model of a generic vapour-phase stoichiometric CSTR based on extent of reaction"
	fields[:Info]="
== Specify ==
* inlet stream
* extent of reactions
"
	drive!(fields,_)
	return fields
end
stoic_extent_vap(_::Dict{Symbol,Any})=begin
	newModel=stoic_extent_vap()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(stoic_extent_vap)
