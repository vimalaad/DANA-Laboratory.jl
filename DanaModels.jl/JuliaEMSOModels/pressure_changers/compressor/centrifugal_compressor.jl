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
#* Author: Marcos L. Alencastro,  Estefane S. Horn (Revised Gerson B. Bicca)
#* $Id$
#*--------------------------------------------------------------------
type centrifugal_compressor
	centrifugal_compressor()=begin
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
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Compressor Model Type",
				:Valid=>["Polytropic With GPSA Method","Isentropic With GPSA Method","Isentropic With ASME Method","Polytropic With ASME Method"],
				:Default=>"Isentropic With GPSA Method"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Pressure Ratio",
				:Lower=>1E-6,
				:Symbol=>"P_{ratio}"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Pressure Drop",
				:DisplayUnit=>"kPa",
				:Symbol=>"\\Delta P"
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Pressure Increase",
				:Lower=>0,
				:DisplayUnit=>"kPa",
				:Symbol=>"P_{incr}"
			]),
			energy_mass ((Symbol=>Any)[
				:Brief=>"Actual Head"
			]),
			energy_mass ((Symbol=>Any)[
				:Brief=>"Isentropic Head"
			]),
			energy_mass ((Symbol=>Any)[
				:Brief=>"Polytropic Head"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Schultz Polytropic Head Correction"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Compressor efficiency - Polytropic or Isentropic (See Compressor Type)",
				:Lower=>1E-3,
				:Upper=>1
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Mechanical efficiency",
				:Lower=>1E-3,
				:Upper=>1
			]),
			power ((Symbol=>Any)[
				:Brief=>"Fluid Power"
			]),
			power ((Symbol=>Any)[
				:Brief=>"Brake Power"
			]),
			power ((Symbol=>Any)[
				:Brief=>"Power Losses"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Polytropic Coefficient",
				:Lower=>0.2,
				:Protected=>true
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Isentropic Coefficient",
				:Lower=>0.2,
				:Protected=>true
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Polytropic efficiency",
				:Lower=>1E-3,
				:Upper=>1,
				:Protected=>true
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Isentropic efficiency",
				:Lower=>1E-3,
				:Upper=>1,
				:Protected=>true
			]),
			temperature ((Symbol=>Any)[
				:Brief=>"Isentropic Temperature",
				:Protected=>true
			]),
			enth_mol ((Symbol=>Any)[
				:Brief=>"Enthalpy at constant entropy",
				:Hidden=>true
			]),
			molweight ((Symbol=>Any)[
				:Brief=>"Mixture Molar Weight",
				:Hidden=>true
			]),
			dens_mass ((Symbol=>Any)[
				:Brief=>"Mass Density at inlet conditions",
				:Lower=>1E-6,
				:Protected=>true
			]),
			dens_mass ((Symbol=>Any)[
				:Brief=>"Mass Density at outlet conditions",
				:Lower=>1E-6,
				:Protected=>true
			]),
			dens_mass ((Symbol=>Any)[
				:Brief=>"Mass Density at isentropic conditions",
				:Lower=>1E-6,
				:Hidden=>true
			]),
			fraction ((Symbol=>Any)[
				:Brief=>"Compressibility factor at inlet",
				:Lower=>1E-3,
				:Protected=>true
			]),
			fraction ((Symbol=>Any)[
				:Brief=>"Compressibility factor at outlet",
				:Lower=>1E-3,
				:Protected=>true
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet stream",
				:PosX=>0.437,
				:PosY=>1,
				:Symbol=>"_{in}"
			]),
			streamPH ((Symbol=>Any)[
				:Brief=>"Outlet stream",
				:PosX=>0.953,
				:PosY=>0.0,
				:Symbol=>"_{out}"
			]),
			work_stream ((Symbol=>Any)[
				:Brief=>"Work Inlet",
				:PosX=>0,
				:PosY=>0.45
			]),
			[
				:(Outlet.F = Inlet.F),
				:(Outlet.z = Inlet.z),
				:(Mwm = sum(Mw*Inlet.z)),
				:(Outlet.P = Inlet.P * Pratio),
				:(Outlet.P = Inlet.P - Pdrop),
				:(Outlet.P = Inlet.P + Pincrease),
				:(rho_in = PP.VapourDensity(Inlet.T, Inlet.P, Inlet.z)),
				:(rho_out= PP.VapourDensity(Outlet.T, Outlet.P, Outlet.z)),
				:(rho_ise= PP.VapourDensity(Tisentropic, Outlet.P, Outlet.z)),
				:(hise = PP.VapourEnthalpy(Tisentropic, Outlet.P, Outlet.z)),
				:(Zfac_in = PP.VapourCompressibilityFactor(Inlet.T,Inlet.P,Inlet.z)),
				:(Zfac_out = PP.VapourCompressibilityFactor(Outlet.T,Outlet.P,Outlet.z)),
				:(IsentropicEff*(Outlet.h-Inlet.h) = (hise-Inlet.h)),
				:(Head*Mwm = (Outlet.h-Inlet.h)),
				:(PP.VapourEntropy(Tisentropic, Outlet.P, Outlet.z) = PP.VapourEntropy(Inlet.T, Inlet.P, Inlet.z)),
				:(BrakePower = -WorkIn.Work),
				:(BrakePower*MechanicalEff = FluidPower),
				:(PowerLoss = BrakePower - FluidPower),
				:(PolytropicEff*HeadIsentropic = HeadPolytropic*IsentropicEff),
				:(FluidPower = Head*Mwm*Inlet.F),
				:(EfficiencyOperation = IsentropicEff),
				:(PolytropicEff*IseCoeff*(PolyCoeff-1) = PolyCoeff*(IseCoeff-1)),
				:(HeadIsentropic = (0.5*Zfac_in+0.5*Zfac_out)*(1/Mwm)*(IseCoeff/(IseCoeff-1.001))*Rgas*Inlet.T*((Pratio)^((IseCoeff-1.001)/IseCoeff) - 1)),
				:(HeadPolytropic = (0.5*Zfac_in+0.5*Zfac_out)*(1/Mwm)*(PolyCoeff/(PolyCoeff-1.001))*Rgas*Inlet.T*((Pratio)^((PolyCoeff-1.001)/PolyCoeff) - 1)),
				:(HeadCorrection =1),
				:(HeadIsentropic = Head*IsentropicEff),
				:(EfficiencyOperation = PolytropicEff),
				:(PolytropicEff*IseCoeff*(PolyCoeff-1) = PolyCoeff*(IseCoeff-1)),
				:(HeadIsentropic = (0.5*Zfac_in+0.5*Zfac_out)*(1/Mwm)*(IseCoeff/(IseCoeff-1.001))*Rgas*Inlet.T*((Pratio)^((IseCoeff-1.001)/IseCoeff) - 1)),
				:(HeadPolytropic = (0.5*Zfac_in+0.5*Zfac_out)*(1/Mwm)*(PolyCoeff/(PolyCoeff-1.001))*Rgas*Inlet.T*((Pratio)^((PolyCoeff-1.001)/PolyCoeff) - 1)),
				:(HeadCorrection =1),
				:(HeadIsentropic = Head*IsentropicEff),
				:(EfficiencyOperation = IsentropicEff),
				:(IseCoeff*ln(rho_ise/rho_in) = ln(Outlet.P/Inlet.P)),
				:(PolyCoeff*ln(rho_out/rho_in) = ln(Outlet.P/Inlet.P)),
				:(HeadIsentropic*rho_in = (IseCoeff/(IseCoeff-1.001))*Inlet.P*HeadCorrection*((Pratio)^((IseCoeff-1.001)/IseCoeff) - 1)),
				:(HeadPolytropic*rho_in = (PolyCoeff/(PolyCoeff-1.001))*Inlet.P*HeadCorrection*((Pratio)^((PolyCoeff-1.001)/PolyCoeff) - 1)),
				:(HeadCorrection*Mwm*(IseCoeff/(IseCoeff-1.001))*(Outlet.P/rho_ise -Inlet.P/rho_in) = (hise-Inlet.h)),
				:(EfficiencyOperation = PolytropicEff),
				:(IseCoeff*ln(rho_ise/rho_in) = ln(Outlet.P/Inlet.P)),
				:(PolyCoeff*ln(rho_out/rho_in) = ln(Outlet.P/Inlet.P)),
				:(HeadIsentropic*rho_in = (IseCoeff/(IseCoeff-1.001))*Inlet.P*HeadCorrection*((Pratio)^((IseCoeff-1.001)/IseCoeff) - 1)),
				:(HeadPolytropic*rho_in = (PolyCoeff/(PolyCoeff-1.001))*Inlet.P*HeadCorrection*((Pratio)^((PolyCoeff-1.001)/PolyCoeff) - 1)),
				:(HeadCorrection*Mwm*(IseCoeff/(IseCoeff-1.001))*(Outlet.P/rho_ise -Inlet.P/rho_in) = (hise-Inlet.h)),
			],
			[
				"Overall Molar Balance","Component Molar Balance","Average Molecular Weight","Pressure Ratio","Pressure Drop","Pressure Increase","Mass Density at inlet conditions","Mass Density at outlet conditions","Mass Density at isentropic conditions","Enthalpy at isentropic conditions","Compressibility factor at Inlet Conditions","Compressibility factor at Outlet Conditions","Isentropic Efficiency","Actual Head","Isentropic Outlet Temperature","Brake Power","Brake Power","Power Loss","Polytropic-Isentropic Relation","Fluid Power","Efficiency","Polytropic Efficiency","Isentropic Coefficient","Polytropic Coefficient","Head Correction","Isentropic Head","Efficiency","Polytropic Efficiency","Isentropic Coefficient","Polytropic Coefficient","Head Correction","Isentropic Head","Efficiency","Isentropic Coefficient","Polytropic Coefficient","Isentropic Head","Polytropic Head","Schultz Polytropic Head Correction","Efficiency","Isentropic Coefficient","Polytropic Coefficient","Isentropic Head","Polytropic Head","Schultz Polytropic Head Correction",
			],
			[:PP,:NComp,:Rgas,:Mw,:CompressorType,],
			[:Pratio,:Pdrop,:Pincrease,:Head,:HeadIsentropic,:HeadPolytropic,:HeadCorrection,:EfficiencyOperation,:MechanicalEff,:FluidPower,:BrakePower,:PowerLoss,:PolyCoeff,:IseCoeff,:PolytropicEff,:IsentropicEff,:Tisentropic,:hise,:Mwm,:rho_in,:rho_out,:rho_ise,:Zfac_in,:Zfac_out,:Inlet,:Outlet,:WorkIn,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	Rgas::positive 
	Mw::Array{molweight }
	CompressorType::DanaSwitcher 
	Pratio::positive 
	Pdrop::press_delta 
	Pincrease::press_delta 
	Head::energy_mass 
	HeadIsentropic::energy_mass 
	HeadPolytropic::energy_mass 
	HeadCorrection::positive 
	EfficiencyOperation::positive 
	MechanicalEff::positive 
	FluidPower::power 
	BrakePower::power 
	PowerLoss::power 
	PolyCoeff::positive 
	IseCoeff::positive 
	PolytropicEff::positive 
	IsentropicEff::positive 
	Tisentropic::temperature 
	hise::enth_mol 
	Mwm::molweight 
	rho_in::dens_mass 
	rho_out::dens_mass 
	rho_ise::dens_mass 
	Zfac_in::fraction 
	Zfac_out::fraction 
	Inlet::stream 
	Outlet::streamPH 
	WorkIn::work_stream 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export centrifugal_compressor
function set(in::centrifugal_compressor)
	Mw = PP.MolecularWeight()
	 Rgas = 8.31451*"kJ/kmol/K"
	 
end
function setEquationFlow(in::centrifugal_compressor)
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
	addEquation(14)
	addEquation(15)
	addEquation(16)
	addEquation(17)
	addEquation(18)
	addEquation(19)
	addEquation(20)
	let switch=CompressorType
		if switch=="Isentropic With GPSA Method"
			addEquation(21)
			addEquation(22)
			addEquation(23)
			addEquation(24)
			addEquation(25)
			addEquation(26)
		elseif switch=="Polytropic With GPSA Method"
			addEquation(27)
			addEquation(28)
			addEquation(29)
			addEquation(30)
			addEquation(31)
			addEquation(32)
		elseif switch=="Isentropic With ASME Method"
			addEquation(33)
			addEquation(34)
			addEquation(35)
			addEquation(36)
			addEquation(37)
			addEquation(38)
		elseif switch=="Polytropic With ASME Method"
			addEquation(39)
			addEquation(40)
			addEquation(41)
			addEquation(42)
			addEquation(43)
			addEquation(44)
		end
	end
end
function atributes(in::centrifugal_compressor,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/CentrifugalCompressor"
	fields[:Brief]="Model of a centrifugal compressor."
	fields[:Info]="To be documented

== References ==

[1] GPSA, 1979, Engineering Data Book, Chapter 4, 5-9 - 5-10.

[2] Bloch, Heinz P., A Practical Guide to Compressor Technology, John Wiley & Sons, Incorporate, 2006. 

[3] Mark R. Sandberg, Equation Of State Influences On Compressor Performance Determination,PROCEEDINGS OF THE THIRTY-FOURTH TURBOMACHINERY SYMPOSIUM, 2005."
	drive!(fields,_)
	return fields
end
centrifugal_compressor(_::Dict{Symbol,Any})=begin
	newModel=centrifugal_compressor()
	newModel.attributes=atributes(newModel,_)
	newModel
end
