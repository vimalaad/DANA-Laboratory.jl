#-------------------------------------
#* Nonequilibrium Model
#-------------------------------------
type interface
	interface()=begin
		PP=outers.PP
		NComp=outers.NComp
		NC1=outers.NC1
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger(),
			DanaInteger(),
			fill(flow_mol_delta ((Symbol=>Any)[
				:Brief=>"Stream Molar Rate on Liquid Phase"
			]),(NComp)),
			fill(flow_mol_delta ((Symbol=>Any)[
				:Brief=>"Stream Molar Rate on Vapour Phase"
			]),(NComp)),
			temperature ((Symbol=>Any)[
				:Brief=>"Stream Temperature"
			]),
			pressure ((Symbol=>Any)[
				:Brief=>"Stream Pressure"
			]),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Stream Molar Fraction on Liquid Phase"
			]),(NComp)),
			fill(fraction ((Symbol=>Any)[
				:Brief=>"Stream Molar Fraction on Vapour Phase"
			]),(NComp)),
			area ((Symbol=>Any)[
				:Brief=>"Interface Area"
			]),
			heat_trans_coeff ((Symbol=>Any)[
				:Brief=>"Heat Transference Coefficient on Liquid Phase"
			]),
			heat_trans_coeff ((Symbol=>Any)[
				:Brief=>"Heat Transference Coefficient on Vapour Phase"
			]),
			heat_rate ((Symbol=>Any)[
				:Brief=>"Liquid Energy Rate at interface"
			]),
			heat_rate ((Symbol=>Any)[
				:Brief=>"Vapour Energy Rate at interface"
			]),
			enth_mol ((Symbol=>Any)[
				:Brief=>"Liquid Molar Enthalpy"
			]),
			enth_mol ((Symbol=>Any)[
				:Brief=>"Vapour Molar Enthalpy"
			]),
			fill(velocity ((Symbol=>Any)[
				:Brief=>"Mass Transfer Coefficients"
			]),(NC1,NC1)),
			fill(velocity ((Symbol=>Any)[
				:Brief=>"Mass Transfer Coefficients"
			]),(NC1,NC1)),
			[
				:(hL = PP.LiquidEnthalpy(T, P, x)),
				:(hV = PP.VapourEnthalpy(T, P, y)),
			],
			[
				"Liquid Enthalpy","Vapour Enthalpy",
			],
			[:PP,:NComp,:NC1,],
			[:NL,:NV,:T,:P,:x,:y,:a,:htL,:htV,:E_liq,:E_vap,:hL,:hV,:kL,:kV,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	NC1::DanaInteger
	NL::Array{flow_mol_delta }
	NV::Array{flow_mol_delta }
	T::temperature 
	P::pressure 
	x::Array{fraction }
	y::Array{fraction }
	a::area 
	htL::heat_trans_coeff 
	htV::heat_trans_coeff 
	E_liq::heat_rate 
	E_vap::heat_rate 
	hL::enth_mol 
	hV::enth_mol 
	kL::Array{velocity }
	kV::Array{velocity }
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export interface
function setEquationFlow(in::interface)
	addEquation(1)
	addEquation(2)
end
function atributes(in::interface,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Icon]="icon/Tray"
	fields[:Brief]="Descrition of variables of the equilibrium interface."
	fields[:Info]="This model contains only the variables of the equilibrium interface."
	drive!(fields,_)
	return fields
end
interface(_::Dict{Symbol,Any})=begin
	newModel=interface()
	newModel.attributes=atributes(newModel,_)
	newModel
end
