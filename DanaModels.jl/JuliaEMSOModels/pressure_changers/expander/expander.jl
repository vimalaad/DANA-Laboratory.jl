#-------------------------------------------------------------------
#* EMSO Model Library (EML) Copyright (C) 2004 - 2007 ALSOC.
#*
#* This LIBRARY is free software; you can distribute it and/or modify
#* it under the therms of the ALSOC FREE LICENSE as available at
#* http://www.enq.ufrgs.br/alsoc.
#*
#* EMSO Copyright (C) 2004 - 2007 ALSOC, original code
#* from http://www.rps.eng.br Copyright (C) 2002-2004.
#* All rights reserved.
#*
#* EMSO is distributed under the therms of the ALSOC LICENSE as
#* available at http://www.enq.ufrgs.br/alsoc.
#*
#*----------------------------------------------------------------------
#* Authors: Rafael de Pelegrini Soares
#*          Andrey Copat, Estefane S. Horn, Marcos L. Alencastro
#* $Id$
#*--------------------------------------------------------------------
type expander
	expander()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin ((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of chemical components",
				:Lower=>1
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Constant of Gases",
				:Unit=>"kJ/kmol/K",
				:Default=>8.31451,
				:Hidden=>true
			]),
			fill(molweight ((Symbol=>Any)[
				:Brief=>"Molar Weight"
			]),(NComp)),
			positive ((Symbol=>Any)[
				:Brief=>"Isentropic Coefficient",
				:Lower=>0.2
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Pressure Ratio",
				:Symbol=>"P_{ratio}"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Pressure Drop",
				:DisplayUnit=>"kPa",
				:Symbol=>"\\Delta P"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Pressure Decrease",
				:DisplayUnit=>"kPa",
				:Symbol=>"P_{decr}"
			]),
			energy_mass ((Symbol=>Any)[
				:Brief=>"Head",
				:Hidden=>true
			]),
			energy_mass ((Symbol=>Any)[
				:Brief=>"Isentropic Head"
			]),
			temperature ((Symbol=>Any)[
				:Brief=>"Isentropic Temperature"
			]),
			efficiency ((Symbol=>Any)[
				:Brief=>"Isentropic efficiency"
			]),
			efficiency ((Symbol=>Any)[
				:Brief=>"Mechanical efficiency"
			]),
			power ((Symbol=>Any)[
				:Brief=>"Fluid Power"
			]),
			power ((Symbol=>Any)[
				:Brief=>"Brake Power"
			]),
			power ((Symbol=>Any)[
				:Brief=>"Power Losses",
				:Lower=>0
			]),
			molweight ((Symbol=>Any)[
				:Brief=>"Mixture Molar Weight"
			]),
			dens_mass ((Symbol=>Any)[
				:Brief=>"Mass Density"
			]),
			fraction ((Symbol=>Any)[
				:Brief=>"Compressibility factor at inlet"
			]),
			fraction ((Symbol=>Any)[
				:Brief=>"Compressibility factor at outlet"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet stream",
				:PosX=>0.05,
				:PosY=>0.0,
				:Symbol=>"_{in}"
			]),
			streamPH ((Symbol=>Any)[
				:Brief=>"Outlet stream",
				:PosX=>0.65,
				:PosY=>1,
				:Symbol=>"_{out}"
			]),
			work_stream ((Symbol=>Any)[
				:Brief=>"Work Outlet",
				:PosX=>1,
				:PosY=>0.46
			]),
			[
				:(Outlet.F = Inlet.F),
				:(Outlet.z = Inlet.z),
				:(Mwm = sum(Mw*Inlet.z)),
				:(Outlet.P = Inlet.P * Pratio),
				:(Outlet.P = Inlet.P - Pdrop),
				:(Outlet.P = Inlet.P - Pdecrease),
				:(rho = PP.VapourDensity(Inlet.T, Inlet.P, Inlet.z)),
				:(Zfac_in = PP.VapourCompressibilityFactor(Inlet.T,Inlet.P,Inlet.z)),
				:(Zfac_out = PP.VapourCompressibilityFactor(Outlet.T,Outlet.P,Outlet.z)),
				:(HeadIsentropic*Mwm = (PP.VapourEnthalpy(Tisentropic,Outlet.P,Outlet.z)-Inlet.h)),
				:(Head*Mwm = (Outlet.h-Inlet.h)),
				:(HeadIsentropic = (0.5*Zfac_in+0.5*Zfac_out)*(1/Mwm)*(IseCoeff/(IseCoeff-1.001))*Rgas*Inlet.T*((Outlet.P/Inlet.P)^((IseCoeff-1.001)/IseCoeff) - 1)),
				:(PP.VapourEntropy(Tisentropic, Outlet.P, Outlet.z) = PP.VapourEntropy(Inlet.T, Inlet.P, Inlet.z)),
				:(Outlet.T = Tisentropic),
				:((PP.VapourEnthalpy(Outlet.T,Outlet.P,Outlet.z)-Inlet.h)= (PP.VapourEnthalpy(Tisentropic,Outlet.P,Outlet.z)-Inlet.h)*IsentropicEff),
				:(FluidPower = IsentropicEff*HeadIsentropic*sum(Mw*Inlet.z)*Inlet.F+PowerLoss),
				:(BrakePower = WorkOut.Work),
				:(BrakePower = FluidPower*MechanicalEff),
				:(PowerLoss = BrakePower - FluidPower),
			],
			[
				"Overall Molar Balance","Component Molar Balance","Average Molecular Weight","Pressure Ratio","Pressure Drop","Pressure Decrease","Mass Density","Compressibility factor at Inlet Conditions","Compressibility factor at Outlet Conditions","Isentropic Head","Actual Head","Isentropic Coefficient","Isentropic Outlet Temperature","Discharge Temperature","Discharge Temperature","Fluid Power","Brake Power","Brake Power","Power Loss",
			],
			[:PP,:NComp,:Rgas,:Mw,],
			[:IseCoeff,:Pratio,:Pdrop,:Pdecrease,:Head,:HeadIsentropic,:Tisentropic,:IsentropicEff,:MechanicalEff,:FluidPower,:BrakePower,:PowerLoss,:Mwm,:rho,:Zfac_in,:Zfac_out,:Inlet,:Outlet,:WorkOut,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	Rgas::positive 
	Mw::Array{molweight }
	IseCoeff::positive 
	Pratio::positive 
	Pdrop::press_delta 
	Pdecrease::press_delta 
	Head::energy_mass 
	HeadIsentropic::energy_mass 
	Tisentropic::temperature 
	IsentropicEff::efficiency 
	MechanicalEff::efficiency 
	FluidPower::power 
	BrakePower::power 
	PowerLoss::power 
	Mwm::molweight 
	rho::dens_mass 
	Zfac_in::fraction 
	Zfac_out::fraction 
	Inlet::stream 
	Outlet::streamPH 
	WorkOut::work_stream 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export expander
function set(in::expander)
	Mw = PP.MolecularWeight()
	 Rgas = 8.31451*"kJ/kmol/K"
	 
end
function setEquationFlow(in::expander)
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
	addEquation(13)
	if IsentropicEff == 1 
		addEquation(14)
	else
		addEquation(15)
	end
	addEquation(16)
	addEquation(17)
	addEquation(18)
	addEquation(19)
end
function atributes(in::expander,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/expander"
	fields[:Brief]="Model of an expansor."
	fields[:Info]="To be documented"
	drive!(fields,_)
	return fields
end
expander(_::Dict{Symbol,Any})=begin
	newModel=expander()
	newModel.attributes=atributes(newModel,_)
	newModel
end
