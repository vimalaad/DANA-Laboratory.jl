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
type PHE_HeatTransfer
	PHE_HeatTransfer()=begin
		new(
			positive ((Symbol=>Any)[
				:Brief=>"Reynolds Number",
				:Default=>100,
				:Lower=>1
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Prandtl Number",
				:Default=>0.5,
				:Lower=>1e-8
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Number of Units Transference",
				:Default=>0.05,
				:Lower=>1E-10
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Stream Heat Capacity",
				:Lower=>1E-3,
				:Default=>1E3,
				:Unit=>"W/K"
			]),
			heat_trans_coeff ((Symbol=>Any)[
				:Brief=>"Film Coefficient",
				:Default=>1,
				:Lower=>1E-12,
				:Upper=>1E6
			]),
			flux_mass ((Symbol=>Any)[
				:Brief=>"Channel Mass Flux",
				:Default=>1,
				:Lower=>1E-6,
				:Symbol=>"G^{channel}"
			]),
			flux_mass ((Symbol=>Any)[
				:Brief=>"Ports Mass Flux",
				:Default=>1,
				:Lower=>1E-6,
				:Symbol=>"G^{ports}"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Viscosity Correction",
				:Default=>1,
				:Lower=>1E-6,
				:Symbol=>"\\phi"
			]),
			[:Re,:PR,:NTU,:WCp,:hcoeff,:Gchannel,:Gports,:Phi,]
		)
	end
	Re::positive 
	PR::positive 
	NTU::positive 
	WCp::positive 
	hcoeff::heat_trans_coeff 
	Gchannel::flux_mass 
	Gports::flux_mass 
	Phi::positive 
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export PHE_HeatTransfer
function atributes(in::PHE_HeatTransfer,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="to be documented"
	fields[:Info]="to be documented"
	drive!(fields,_)
	return fields
end
PHE_HeatTransfer(_::Dict{Symbol,Any})=begin
	newModel=PHE_HeatTransfer()
	newModel.attributes=atributes(newModel,_)
	newModel
end
