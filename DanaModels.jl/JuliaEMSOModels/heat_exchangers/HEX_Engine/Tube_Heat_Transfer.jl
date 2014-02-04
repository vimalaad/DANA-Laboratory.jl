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
type Tube_Heat_Transfer
	Tube_Heat_Transfer()=begin
		new(
			positive ((Symbol=>Any)[
				:Brief=>"Tube Side Reynolds Number",
				:Default=>1000,
				:Lower=>1
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Nusselt Number",
				:Default=>0.5,
				:Lower=>1e-8
			]),
			heat_trans_coeff ((Symbol=>Any)[
				:Brief=>"Tube Side Film Coefficient",
				:Default=>1,
				:Lower=>1e-12,
				:Upper=>1e6
			]),
			fricfactor ((Symbol=>Any)[
				:Brief=>"Friction Factor",
				:Default=>0.05,
				:Lower=>1e-10,
				:Upper=>2000
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Tube Side Prandtl Number",
				:Default=>0.5,
				:Lower=>1e-8
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Phi Correction",
				:Default=>1,
				:Lower=>1e-3
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"Tube Side Velocity",
				:Lower=>1e-8
			]),
			[:Re,:Nu,:htube,:fi,:PR,:Phi,:Vtube,]
		)
	end
	Re::positive 
	Nu::positive 
	htube::heat_trans_coeff 
	fi::fricfactor 
	PR::positive 
	Phi::positive 
	Vtube::velocity 
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Tube_Heat_Transfer
function atributes(in::Tube_Heat_Transfer,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="to be documented"
	fields[:Info]="to be documented"
	drive!(fields,_)
	return fields
end
Tube_Heat_Transfer(_::Dict{Symbol,Any})=begin
	newModel=Tube_Heat_Transfer()
	newModel.attributes=atributes(newModel,_)
	newModel
end
