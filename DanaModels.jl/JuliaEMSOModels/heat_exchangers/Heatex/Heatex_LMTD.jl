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
#*--------------------------------------------------------------------
#* Author: Gerson Balbueno Bicca 
#* $Id: Heatex.mso 574 2008-07-25 14:18:50Z rafael $
#*--------------------------------------------------------------------
type Heatex_LMTD
	Heatex_LMTD()=begin
		new(
			Heatex_Basic(),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Type of Heat Exchanger",
				:Valid=>["Counter Flow","Cocurrent Flow", "Shell and Tube"],
				:Default=>"Cocurrent Flow"
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"LMTD Correction Factor Model",
				:Valid=>["Bowmann","Fakheri"],
				:Default=>"Bowmann"
			]),
			LMTD_Basic ((Symbol=>Any)[
				:Brief=>"LMTD Method of Calculation",
				:Symbol=>" "
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Capacity Ratio for LMTD Correction Fator",
				:Lower=>1e-6,
				:Hidden=>true
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Non - Dimensional Variable for LMTD Correction Fator ",
				:Lower=>1e-6,
				:Hidden=>true
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Non - Dimensional Variable for LMTD Correction Fator in Fakheri Equation",
				:Lower=>1e-6,
				:Hidden=>true
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Non - Dimensional Variable for LMTD Correction Fator in Fakheri Equation",
				:Lower=>1e-6,
				:Symbol=>"\\phi",
				:Hidden=>true
			]),
			[
				:(Q = U*A*Method.LMTD*Method.Fc),
				:(Method.DT0 = _P1.InletHot.T - _P1.InletCold.T),
				:(Method.DTL = _P1.OutletHot.T - _P1.OutletCold.T),
				:(R=1),
				:(P=1),
				:(Phi = 1),
				:(Rho = 1),
				:(Method.Fc = 1),
				:(Method.DT0 = _P1.InletHot.T - _P1.OutletCold.T),
				:(Method.DTL = _P1.OutletHot.T - _P1.InletCold.T),
				:(R=1),
				:(P=1),
				:(Phi = 1),
				:(Rho = 1),
				:(Method.Fc = 1),
				:(Method.DT0 = _P1.InletHot.T - _P1.OutletCold.T),
				:(Method.DTL = _P1.OutletHot.T - _P1.InletCold.T),
				:(Phi = 1),
				:(Rho = 1),
				:(R*(_P1.OutletCold.T - _P1.InletCold.T ) = (_P1.InletHot.T-_P1.OutletHot.T)),
				:(P*(_P1.InletHot.T- _P1.InletCold.T)= (_P1.OutletCold.T-_P1.InletCold.T)),
				:(Method.Fc = (sqrt(2)*P)/((1-P)*ln( abs( ( 2-P*0.585786)/( 2-P*3.414214))))),
				:(Method.Fc = sqrt(R*R+1)*ln(abs((1-P*R)/(1-P)))/((1-R)*ln( abs( ( 2-P*(R+1-sqrt(R*R+1)))/ ( 2-P*(R + 1 + sqrt(R*R+1))))))),
				:(R*(_P1.OutletCold.T - _P1.InletCold.T ) = (_P1.InletHot.T-_P1.OutletHot.T)),
				:(P*(_P1.InletHot.T- _P1.InletCold.T)= (_P1.OutletCold.T-_P1.InletCold.T)),
				:(Phi = (sqrt(((_P1.InletHot.T- _P1.OutletHot.T)*(_P1.InletHot.T- _P1.OutletHot.T))+((_P1.OutletCold.T - _P1.InletCold.T)*(_P1.OutletCold.T - _P1.InletCold.T))))/(2*((_P1.InletHot.T+ _P1.OutletHot.T)-(_P1.InletCold.T+ _P1.OutletCold.T)))),
				:(Rho*(1-P*R) = (1-P)),
				:(Method.Fc = (4*Phi)/(ln(abs((1+2*Phi)/(1-2*Phi))))),
				:(Method.Fc = (2*Phi*(Rho+1)*ln(abs(Rho)))/( ln(abs((1+2*Phi)/(1-2*Phi)))*(Rho-1))),
			],
			[
				"Duty","Temperature Difference at Inlet","Temperature Difference at Outlet","R: Capacity Ratio for LMTD Correction Fator","P: Non - Dimensional Variable for LMTD Correction Fator"," Variable useless with this model"," Variable useless with this model","LMTD Correction Factor in Cocurrent Flow","Temperature Difference at Inlet","Temperature Difference at Outlet","R: Capacity Ratio for LMTD Correction Fator","P: Non - Dimensional Variable for LMTD Correction Fator"," Variable useless with this model"," Variable useless with this model","LMTD Correction Factor in Counter Flow","Temperature Difference at Inlet","Temperature Difference at Outlet"," Variable not in use with Bowmann equation"," Variable not in use with Bowmann equation","R: Capacity Ratio for LMTD Correction Fator when Shell and Tube","P: Non - Dimensional Variable for LMTD Correction Fator when Shell and Tube","LMTD Correction Fator when 1 Pass Shell Side","LMTD Correction Fator when 1 Pass Shell Side","R: Capacity Ratio for LMTD Correction Fator when Shell and Tube","P: Non - Dimensional Variable for LMTD Correction Fator when Shell and Tube","Non Dimensional Variable for LMTD Correction Fator in Fakheri Equation ","Non Dimensional Variable for LMTD Correction Fator in Fakheri Equation","LMTD Correction Fator when 1 Pass Shell Side","LMTD Correction Fator when 1 Pass Shell Side",
			],
			[:ExchangerType,:LMTDcorrection,],
			[:Method,:R,:P,:Rho,:Phi,]
		)
	end
	_P1::Heatex_Basic
	ExchangerType::DanaSwitcher 
	LMTDcorrection::DanaSwitcher 
	Method::LMTD_Basic 
	R::positive 
	P::positive 
	Rho::positive 
	Phi::positive 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Heatex_LMTD
function setEquationFlow(in::Heatex_LMTD)
	addEquation(1)
	let switch=ExchangerType
		if switch=="Cocurrent Flow"
			addEquation(2)
			addEquation(3)
			addEquation(4)
			addEquation(5)
			addEquation(6)
			addEquation(7)
			addEquation(8)
		elseif switch=="Counter Flow"
			addEquation(9)
			addEquation(10)
			addEquation(11)
			addEquation(12)
			addEquation(13)
			addEquation(14)
			addEquation(15)
		elseif switch=="Shell and Tube"
			addEquation(16)
			addEquation(17)
			let switch=LMTDcorrection
				if switch=="Bowmann"
					addEquation(18)
					addEquation(19)
					addEquation(20)
					addEquation(21)
					if R == 1 
						addEquation(22)
					else
						addEquation(23)
					end
				elseif switch=="Fakheri"
					addEquation(24)
					addEquation(25)
					addEquation(26)
					addEquation(27)
					if Rho == 1 
						addEquation(28)
					else
						addEquation(29)
					end
				end
			end
		end
	end
end
function atributes(in::Heatex_LMTD,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/HeatExchanger_LMTD"
	fields[:Brief]="Simplified model for Heat Exchangers"
	fields[:Info]="This model perform material and heat balance using the Log Mean Temperature Difference Approach. 
This shortcut calculation does not require exchanger configuration or geometry data.

== Assumptions ==
* Steady-State operation;
* No heat loss to the surroundings.

== Specify ==
* The Inlet streams: Hot and Cold.

== References ==
[1] E.A.D. Saunders, Heat Exchangers: Selection, Design and
 Construction, Longman, Harlow, 1988. 

[2] Taborek, J., Shell-and-tube heat exchangers, in Heat Exchanger Design Handbook, Vol. 3
 Hemisphere Publishing Corp., New York, 1988. 

[3] Fakheri, A. , Alternative approach for determining log mean temperature difference correction factor 
 and number of shells of shell and tube heat exchangers, Journal of Enhanced Heat Transfer, v. 10, p. 407- 420, 2003. 
"
	drive!(fields,_)
	return fields
end
Heatex_LMTD(_::Dict{Symbol,Any})=begin
	newModel=Heatex_LMTD()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(Heatex_LMTD)
