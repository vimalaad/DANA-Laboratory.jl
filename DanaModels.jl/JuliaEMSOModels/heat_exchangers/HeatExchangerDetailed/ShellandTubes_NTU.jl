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
type ShellandTubes_NTU
	ShellandTubes_NTU()=begin
		new(
			ShellandTubesBasic(),
			NTU_Basic ((Symbol=>Any)[
				:Brief=>"NTU Method"
			]),
			[
				:(Method.NTU*Method.Cmin = _P1.Details.Ud*_P1.Pi*_P1.Tubes.TubeOD*_P1.Tubes.NumberOfTubes*_P1.Tubes.TubeLength),
				:(Method.Cmin = min([Method.Ch,Method.Cc])),
				:(Method.Cmax = max([Method.Ch,Method.Cc])),
				:(Method.Cr = Method.Cmin/Method.Cmax),
				:(_P1.Details.Q = Method.Eft*Method.Cmin*(_P1.InletShell.T-_P1.InletTube.T)),
				:(Method.Ch = _P1.InletShell.F*_P1.Shell.Properties.Average.Cp),
				:(Method.Cc = _P1.InletTube.F*_P1.Tubes.Properties.Average.Cp),
				:(_P1.Details.Q = Method.Eft*Method.Cmin*(_P1.InletTube.T-_P1.InletShell.T)),
				:(Method.Cc = _P1.InletShell.F*_P1.Shell.Properties.Average.Cp),
				:(Method.Ch = _P1.InletTube.F*_P1.Tubes.Properties.Average.Cp),
				:(Method.Eft1 = 2*(1+Method.Cr+sqrt(1+Method.Cr^2)*((1+exp(-Method.NTU*sqrt(1+Method.Cr^2)))/(1-exp(-Method.NTU*sqrt(1+Method.Cr^2)))) )^-1),
				:(Method.Eft = ( ((1-Method.Eft1*Method.Cr)/(1-Method.Eft1))^2 -1 )*( ((1-Method.Eft1*Method.Cr)/(1-Method.Eft1))^2 - Method.Cr )^-1),
				:(Method.Eft = 2*(1+Method.Cr+sqrt(1+Method.Cr^2)*((1+exp(-Method.NTU*sqrt(1+Method.Cr^2)))/(1-exp(-Method.NTU*sqrt(1+Method.Cr^2)))) )^-1),
				:(Method.Eft1 = 1),
			],
			[
				"Number of Units Transference","Minimum Heat Capacity","Maximum Heat Capacity","Thermal Capacity Ratio","Duty","Hot Stream Heat Capacity","Cold Stream Heat Capacity","Duty","Hot Stream Heat Capacity","Cold Stream Heat Capacity","Effectiveness Correction for 2 pass shell side","TEMA F Shell Effectiveness","TEMA E Shell Effectiveness","Variable not in use when 1 Pass Shell Side",
			],
			[:Method,]
		)
	end
	_P1::ShellandTubesBasic
	Method::NTU_Basic 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export ShellandTubes_NTU
function setEquationFlow(in::ShellandTubes_NTU)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	let switch=HotSide
		if HotSide==InletTube.T > InletShell.T
			set(switch,"tubes")
		end
		if HotSide==InletTube.T < InletShell.T
			set(switch,"shell")
		end
		if switch=="shell"
			addEquation(5)
			addEquation(6)
			addEquation(7)
		elseif switch=="tubes"
			addEquation(8)
			addEquation(9)
			addEquation(10)
		end
	end
	let switch=ShellType
		if switch=="Fshell"
			addEquation(11)
			addEquation(12)
		elseif switch=="Eshell"
			addEquation(13)
			#	Method.Eft = 1;
			addEquation(14)
		end
	end
end
function atributes(in::ShellandTubes_NTU,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/ShellandTubes_NTU"
	fields[:Brief]="Shell and Tubes Heat Exchangers"
	fields[:Info]="to be documented"
	drive!(fields,_)
	return fields
end
ShellandTubes_NTU(_::Dict{Symbol,Any})=begin
	newModel=ShellandTubes_NTU()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(ShellandTubes_NTU)
