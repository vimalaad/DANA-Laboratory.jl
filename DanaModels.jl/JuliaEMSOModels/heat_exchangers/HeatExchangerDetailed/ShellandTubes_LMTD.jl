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
#*--------------------------------------------------------------------
#* Author: Gerson Balbueno Bicca 
#* $Id: HeatExchangerDetailed.mso 197 2007-03-08 14:31:57Z bicca $
#*------------------------------------------------------------------
type ShellandTubes_LMTD
	ShellandTubes_LMTD()=begin
		new(
			ShellandTubesBasic(),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"LMTD Correction Factor Model",
				:Valid=>["Bowmann","Fakeri"],
				:Default=>"Bowmann"
			]),
			LMTD_Basic(),
			positive ((Symbol=>Any)[
				:Brief=>" Capacity Ratio for LMTD Correction Fator",
				:Lower=>1e-6
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Non - Dimensional Variable for LMTD Correction Fator ",
				:Lower=>1e-6
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Non - Dimensional Variable for LMTD Correction Fator when 2 Pass Shell Side",
				:Lower=>1e-6
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Non - Dimensional Variable for LMTD Correction Fator in Fakeri Equation",
				:Lower=>1e-6
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Non - Dimensional Variable for LMTD Correction Fator in Fakeri Equation",
				:Lower=>1e-6
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Non - Dimensional Variable for LMTD Correction Fator in Fakeri Equation when 2 Pass Shell Side",
				:Lower=>1e-6
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Non - Dimensional Variable for LMTD Correction Fator in Fakeri Equationwhen 2 Pass Shell Side",
				:Lower=>1e-6
			]),
			[
				:(_P1.Details.Q = _P1.Details.Ud*_P1.Pi*_P1.Tubes.TubeOD*_P1.Tubes.NumberOfTubes*_P1.Tubes.TubeLength*Method.LMTD*Method.Fc),
				:(Phi*(2*((_P1.InletShell.T+ _P1.OutletShell.T)-(_P1.InletTube.T+ _P1.OutletTube.T))) = (sqrt(((_P1.InletShell.T- _P1.OutletShell.T)*(_P1.InletShell.T- _P1.OutletShell.T))+((_P1.OutletTube.T - _P1.InletTube.T)*(_P1.OutletTube.T - _P1.InletTube.T))))),
				:(R*(_P1.OutletTube.T - _P1.InletTube.T ) = (_P1.InletShell.T-_P1.OutletShell.T)),
				:(P*(_P1.InletShell.T- _P1.InletTube.T)= (_P1.OutletTube.T-_P1.InletTube.T)),
				:(Method.DT0 = _P1.InletShell.T - _P1.OutletTube.T),
				:(Method.DTL = _P1.OutletShell.T - _P1.InletTube.T),
				:(Phi*(2*((_P1.InletShell.T+ _P1.OutletShell.T)-(_P1.InletTube.T+ _P1.OutletTube.T))) = (sqrt(((_P1.InletShell.T- _P1.OutletShell.T)*(_P1.InletShell.T- _P1.OutletShell.T))+((_P1.OutletTube.T - _P1.InletTube.T)*(_P1.OutletTube.T - _P1.InletTube.T))))),
				:(R*(_P1.OutletShell.T - _P1.InletShell.T ) = (_P1.InletTube.T-_P1.OutletTube.T)),
				:(P*(_P1.InletTube.T- _P1.InletShell.T)= (_P1.OutletShell.T-_P1.InletShell.T)),
				:(Method.DT0 = _P1.InletTube.T - _P1.OutletShell.T),
				:(Method.DTL = _P1.OutletTube.T - _P1.InletShell.T),
				:(lambdaN =1),
				:(lambda1 =1),
				:(Rho =1),
				:(Pc*(2-P)= P),
				:(Method.Fc= (sqrt(2)*Pc)/((1-Pc)*ln( abs( ( 2-Pc*0.585786)/( 2-Pc*3.414214))))),
				:(Pc = (sqrt(abs(( 1-P*R)/(1-P)))-1)/(sqrt(abs(( 1-P*R)/(1-P)))-R)),
				:(Method.Fc = sqrt(R*R+1)*ln(abs((1-Pc*R)/(1-Pc)))/((1-R)*ln( abs( ( 2-Pc*(R+1-sqrt(R*R+1)))/ ( 2-Pc*(R + 1 + sqrt(R*R+1))))))),
				:(Pc = P),
				:(Rho*(1-P*R) = (1-P)),
				:(lambdaN = 1),
				:(lambda1 = 1),
				:(Method.Fc = (2*Phi )/(ln(abs((1+Phi )/(1-Phi ))))),
				:(lambdaN = (1/ln(sqrt(abs(Rho))))*((2*sqrt(abs(Rho))-2)/(sqrt(abs(Rho))+1))),
				:(lambda1 = (1/ln(abs(Rho)))*((2*Rho-2)/(Rho+1))),
				:(Method.Fc = ((2*Phi *(lambdaN/lambda1))/(ln(abs((1+Phi *(lambdaN/lambda1))/(1-Phi *(lambdaN/lambda1))))))*(1/lambdaN)),
				:(lambdaN =1),
				:(lambda1 =1),
				:(Pc = P),
				:(Rho = 1),
				:(Method.Fc = (sqrt(2)*P)/((1-P)*ln( abs( ( 2-P*0.585786)/( 2-P*3.414214))))),
				:(Method.Fc = sqrt(R*R+1)*ln(abs((1-P*R)/(1-P)))/((1-R)*ln( abs( ( 2-P*(R+1-sqrt(R*R+1)))/ ( 2-P*(R + 1 + sqrt(R*R+1))))))),
				:(Rho*(1-P*R) = (1-P)),
				:(Method.Fc = (4*Phi)/(ln(abs((1+2*Phi)/(1-2*Phi))))),
				:(Method.Fc = (2*Phi*(Rho+1)*ln(abs(Rho)))/( ln(abs((1+2*Phi)/(1-2*Phi)))*(Rho-1))),
			],
			[
				"Exchange Surface Area","Non Dimensional Variable for LMTD Correction Fator in Fakeri Equation ","R: Capacity Ratio for LMTD Correction Fator","P: Non - Dimensional Variable for LMTD Correction Fator","Temperature Difference at Inlet","Temperature Difference at Outlet","Non Dimensional Variable for LMTD Correction Fator in Fakeri Equation ","R: Capacity Ratio for LMTD Correction Fator","P: Non - Dimensional Variable for LMTD Correction Fator","Temperature Difference at Inlet","Temperature Difference at Outlet"," Variable not in use with Bowmann equation"," Variable not in use with Bowmann equation"," Variable not in use with Bowmann equation","Non Dimensional Variable for LMTD Correction Fator when 2 Pass Shell Side","LMTD Correction Fator when 2 Pass Shell Side","Non Dimensional Variable for LMTD Correction Fator when 2 Pass Shell Side","LMTD Correction Fator when 2 Pass Shell Side"," Variable not in use with Fakeri equation","Non Dimensional Variable for LMTD Correction Fator in Fakeri Equation"," Variable not in use when Rho = 1"," Variable not in use when Rho = 1","LMTD Correction Fator when 2 Pass Shell Side","Non Dimensional Variable for LMTD Correction Fator in Fakeri Equation","Non Dimensional Variable for LMTD Correction Fator in Fakeri Equation","LMTD Correction Fator when 2 Pass Shell Side"," Variable not in use when 1 Pass Shell Side"," Variable not in use when 1 Pass Shell Side"," Variable not in use when 1 Pass Shell Side"," Variable not in use with Bowmann equation","LMTD Correction Fator when 1 Pass Shell Side","LMTD Correction Fator when 1 Pass Shell Side","Non Dimensional Variable for LMTD Correction Fator in Fakeri Equation","LMTD Correction Fator when 1 Pass Shell Side","LMTD Correction Fator when 1 Pass Shell Side",
			],
			[:LMTDcorrection,],
			[:Method,:R,:P,:Pc,:Rho,:Phi,:lambdaN,:lambda1,]
		)
	end
	_P1::ShellandTubesBasic
	LMTDcorrection::DanaSwitcher 
	Method::LMTD_Basic
	R::positive 
	P::positive 
	Pc::positive 
	Rho::positive 
	Phi::positive 
	lambdaN::positive 
	lambda1::positive 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export ShellandTubes_LMTD
function setEquationFlow(in::ShellandTubes_LMTD)
	addEquation(1)
	let switch=HotSide
		if HotSide==InletTube.T > InletShell.T
			set(switch,"tubes")
		end
		if HotSide==InletTube.T < InletShell.T
			set(switch,"shell")
		end
		if switch=="shell"
			addEquation(2)
			addEquation(3)
			addEquation(4)
			addEquation(5)
			addEquation(6)
		elseif switch=="tubes"
			addEquation(7)
			addEquation(8)
			addEquation(9)
			addEquation(10)
			addEquation(11)
		end
	end
	let switch=ShellType
		if switch=="Fshell"
			let switch=LMTDcorrection
				if switch=="Bowmann"
					addEquation(12)
					addEquation(13)
					#" Variable not in use with Bowmann equation"
					#	Phi = 1;
					addEquation(14)
					if R == 1 
						addEquation(15)
						addEquation(16)
					else
						addEquation(17)
						addEquation(18)
					end
				elseif switch=="Fakeri"
					addEquation(19)
					addEquation(20)
					#"Non Dimensional Variable for LMTD Correction Fator in Fakeri Equation "
					#	Phi = (sqrt(((Inlet.Hot.T - Outlet.Hot.T)*(Inlet.Hot.T- Outlet.Hot.T))+((Outlet.Cold.T -  Inlet.Cold.T)*(Outlet.Cold.T -  Inlet.Cold.T))))/(2*((Inlet.Hot.T + Outlet.Hot.T)-( Inlet.Cold.T + Outlet.Cold.T)));
					if Rho == 1 
						addEquation(21)
						addEquation(22)
						addEquation(23)
					else
						addEquation(24)
						addEquation(25)
						addEquation(26)
					end
				end
			end
		elseif switch=="Eshell"
			addEquation(27)
			addEquation(28)
			addEquation(29)
			let switch=LMTDcorrection
				if switch=="Bowmann"
					#" Variable not in use with Bowmann equation"
					#	Phi  = 1;
					addEquation(30)
					if R == 1 
						addEquation(31)
					else
						addEquation(32)
					end
				elseif switch=="Fakeri"
					#"Non Dimensional Variable for LMTD Correction Fator in Fakeri Equation "
					#	Phi  = (sqrt(((Inlet.Hot.T- Outlet.Hot.T)*(Inlet.Hot.T- Outlet.Hot.T))+((Outlet.Cold.T - Inlet.Cold.T)*(Outlet.Cold.T - Inlet.Cold.T))))/(2*((Inlet.Hot.T+ Outlet.Hot.T)-(Inlet.Cold.T+ Outlet.Cold.T)));
					addEquation(33)
					if Rho == 1 
						addEquation(34)
					else
						addEquation(35)
					end
				end
			end
		end
	end
end
function atributes(in::ShellandTubes_LMTD,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/ShellandTubes_LMTD"
	fields[:Brief]="Shell and Tubes Heat Exchangers"
	fields[:Info]="to be documented."
	drive!(fields,_)
	return fields
end
ShellandTubes_LMTD(_::Dict{Symbol,Any})=begin
	newModel=ShellandTubes_LMTD()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(ShellandTubes_LMTD)
