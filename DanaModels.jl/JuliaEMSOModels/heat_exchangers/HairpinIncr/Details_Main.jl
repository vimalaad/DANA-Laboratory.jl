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
#* $Id: HairpinIncr.mso								$
#*------------------------------------------------------------------
type Details_Main
	Details_Main()=begin
		N=outers.N
		new(
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of zones",
				:Default=>2
			]),
			area ((Symbol=>Any)[
				:Brief=>"Total Exchange Surface Area"
			]),
			fill(power ((Symbol=>Any)[
				:Brief=>"Incremental Duty",
				:Default=>7000,
				:Lower=>1e-8,
				:Upper=>1e10
			]),(N)),
			power ((Symbol=>Any)[
				:Brief=>"Total Duty",
				:Default=>7000,
				:Lower=>1e-8,
				:Upper=>1e10
			]),
			heat_trans_coeff ((Symbol=>Any)[
				:Brief=>"Average Overall Heat Transfer Coefficient Clean",
				:Default=>1,
				:Lower=>1e-6,
				:Upper=>1e10
			]),
			fill(heat_trans_coeff ((Symbol=>Any)[
				:Brief=>"Incremental Overall Heat Transfer Coefficient Dirty",
				:Default=>1,
				:Lower=>1e-6,
				:Upper=>1e10
			]),(N)),
			[:N,],
			[:A,:Q,:Qtotal,:Uc,:Ud,]
		)
	end
	N::DanaInteger 
	A::area 
	Q::Array{power }
	Qtotal::power 
	Uc::heat_trans_coeff 
	Ud::Array{heat_trans_coeff }
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Details_Main
function atributes(in::Details_Main,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="to be documented"
	fields[:Info]="to be documented"
	drive!(fields,_)
	return fields
end
Details_Main(_::Dict{Symbol,Any})=begin
	newModel=Details_Main()
	newModel.attributes=atributes(newModel,_)
	newModel
end
