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
type Shell_Heat_Transfer
	Shell_Heat_Transfer()=begin
		new(
			positive ((Symbol=>Any)[
				:Brief=>"Shell Side Reynolds Number",
				:Default=>100,
				:Lower=>1
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Shell Side Prandtl Number",
				:Default=>0.7,
				:Lower=>1e-6
			]),
			heat_trans_coeff ((Symbol=>Any)[
				:Brief=>"Shell Side Film Coefficient",
				:Default=>1,
				:Lower=>1e-12,
				:Upper=>1e6
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Phi Correction",
				:Default=>1,
				:Lower=>1e-3
			]),
			[:Re,:PR,:hshell,:Phi,]
		)
	end
	Re::positive 
	PR::positive 
	hshell::heat_trans_coeff 
	Phi::positive 
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Shell_Heat_Transfer
function atributes(in::Shell_Heat_Transfer,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="to be documented"
	fields[:Info]="to be documented"
	drive!(fields,_)
	return fields
end
Shell_Heat_Transfer(_::Dict{Symbol,Any})=begin
	newModel=Shell_Heat_Transfer()
	newModel.attributes=atributes(newModel,_)
	newModel
end
