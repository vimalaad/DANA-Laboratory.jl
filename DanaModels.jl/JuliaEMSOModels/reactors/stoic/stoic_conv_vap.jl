#---------------------------------------------------------------------
#*	2. conversion of a key component is known
#*--------------------------------------------------------------------
type stoic_conv_vap
	stoic_conv_vap()=begin
		new(
			stoic_vap(),
			DanaInteger((Symbol=>Any)[
				:Brief=>"Key component",
				:Lower=>1,
				:Default=>1
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Molar conversion of key component",
				:Symbol=>"X_k"
			]),
			[
				:(_P1.rate*_P1._P1._P1.Tank.V = sumt(_P1.stoic)/abs(sumt(_P1.stoic(KComp,:)))*_P1._P1._P1.Outletm.F*_P1._P1._P1.Outletm.z(KComp)*kconv),
			],
			[
				"Reaction rate",
			],
			[:KComp,],
			[:kconv,]
		)
	end
	_P1::stoic_vap
	KComp::DanaInteger
	kconv::DanaReal 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export stoic_conv_vap
function setEquationFlow(in::stoic_conv_vap)
	addEquation(1)
end
function atributes(in::stoic_conv_vap,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/cstr"
	fields[:Brief]="Model of a generic vapour-phase stoichiometric CSTR based on conversion of a key component"
	fields[:Info]="
== Specify ==
* inlet stream
* conversion of a key component
"
	drive!(fields,_)
	return fields
end
stoic_conv_vap(_::Dict{Symbol,Any})=begin
	newModel=stoic_conv_vap()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(stoic_conv_vap)
