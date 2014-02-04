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
#* $Id: PHE.mso 250 2007-04-27 16:32:02Z bicca $
#*------------------------------------------------------------------
type Thermal_PHE
	Thermal_PHE()=begin
		new(
			positive ((Symbol=>Any)[
				:Brief=>"Heat Capacity Ratio",
				:Default=>0.5,
				:Lower=>1E-6
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Minimum Heat Capacity",
				:Lower=>1E-10,
				:Default=>1E3,
				:Unit=>"W/K"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Maximum Heat Capacity",
				:Lower=>1E-10,
				:Default=>1E3,
				:Unit=>"W/K"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Number of Units Transference",
				:Default=>0.05,
				:Lower=>1E-10
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Effectiveness",
				:Default=>0.5,
				:Lower=>0.1,
				:Upper=>1.1,
				:Symbol=>"\\varepsilon"
			]),
			power ((Symbol=>Any)[
				:Brief=>"Heat Transfer",
				:Default=>7000,
				:Lower=>1E-6,
				:Upper=>1E10
			]),
			heat_trans_coeff ((Symbol=>Any)[
				:Brief=>"Overall Heat Transfer Coefficient Clean",
				:Default=>1,
				:Lower=>1E-6,
				:Upper=>1E10
			]),
			heat_trans_coeff ((Symbol=>Any)[
				:Brief=>"Overall Heat Transfer Coefficient Dirty",
				:Default=>1,
				:Lower=>1E-6,
				:Upper=>1E10
			]),
			[:Cr,:Cmin,:Cmax,:NTU,:Eft,:Q,:Uc,:Ud,]
		)
	end
	Cr::positive 
	Cmin::positive 
	Cmax::positive 
	NTU::positive 
	Eft::positive 
	Q::power 
	Uc::heat_trans_coeff 
	Ud::heat_trans_coeff 
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Thermal_PHE
function atributes(in::Thermal_PHE,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="to be documented"
	fields[:Info]="to be documented"
	drive!(fields,_)
	return fields
end
Thermal_PHE(_::Dict{Symbol,Any})=begin
	newModel=Thermal_PHE()
	newModel.attributes=atributes(newModel,_)
	newModel
end
