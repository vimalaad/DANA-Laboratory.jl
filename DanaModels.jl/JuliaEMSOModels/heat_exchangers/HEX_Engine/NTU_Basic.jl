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
#* $Id$
#*--------------------------------------------------------------------
type NTU_Basic
	NTU_Basic()=begin
		new(
			positive ((Symbol=>Any)[
				:Brief=>"Hot Stream Heat Capacity",
				:Lower=>1e-3,
				:Default=>1e3,
				:Unit=>"W/K"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Cold Stream Heat Capacity",
				:Lower=>1e-3,
				:Default=>1e3,
				:Unit=>"W/K"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Heat Capacity Ratio",
				:Default=>0.5,
				:Lower=>1e-6
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Minimum Heat Capacity",
				:Lower=>1e-10,
				:Default=>1e3,
				:Unit=>"W/K"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Maximum Heat Capacity",
				:Lower=>1e-10,
				:Default=>1e3,
				:Unit=>"W/K"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Number of Units Transference",
				:Default=>0.05,
				:Lower=>1e-10
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Effectiveness",
				:Default=>0.5,
				:Lower=>1e-8,
				:Upper=>1,
				:Symbol=>"\\varepsilon"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Effectiveness Correction",
				:Lower=>1e-8,
				:Default=>0.5,
				:Symbol=>"\\hat {\\varepsilon}"
			]),
			[:Ch,:Cc,:Cr,:Cmin,:Cmax,:NTU,:Eft,:Eft1,]
		)
	end
	Ch::positive 
	Cc::positive 
	Cr::positive 
	Cmin::positive 
	Cmax::positive 
	NTU::positive 
	Eft::positive 
	Eft1::positive 
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export NTU_Basic
function atributes(in::NTU_Basic,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Number of Units Transference Method."
	fields[:Info]="to be documented"
	drive!(fields,_)
	return fields
end
NTU_Basic(_::Dict{Symbol,Any})=begin
	newModel=NTU_Basic()
	newModel.attributes=atributes(newModel,_)
	newModel
end
