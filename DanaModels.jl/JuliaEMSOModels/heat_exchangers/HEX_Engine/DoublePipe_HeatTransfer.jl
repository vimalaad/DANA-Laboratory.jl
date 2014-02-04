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
type DoublePipe_HeatTransfer
	DoublePipe_HeatTransfer()=begin
		new(
			area ((Symbol=>Any)[
				:Brief=>"Cross Sectional Area for Flow",
				:Default=>0.05,
				:Lower=>1e-8
			]),
			length ((Symbol=>Any)[
				:Brief=>"Hydraulic Diameter of Pipe for Heat Transfer",
				:Lower=>1e-8
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Reynolds Number",
				:Default=>100,
				:Lower=>1
			]),
			heat_trans_coeff ((Symbol=>Any)[
				:Brief=>"Film Coefficient",
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
				:Brief=>"Nusselt Number",
				:Default=>0.5,
				:Lower=>1e-8
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Prandtl Number",
				:Default=>0.5,
				:Lower=>1e-8
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Phi Correction",
				:Default=>1,
				:Lower=>1e-3
			]),
			velocity ((Symbol=>Any)[
				:Brief=>"Tube Velocity",
				:Lower=>1e-8
			]),
			[:As,:Dh,],
			[:Re,:hcoeff,:fi,:Nu,:PR,:Phi,:Vmean,]
		)
	end
	As::area 
	Dh::length 
	Re::positive 
	hcoeff::heat_trans_coeff 
	fi::fricfactor 
	Nu::positive 
	PR::positive 
	Phi::positive 
	Vmean::velocity 
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export DoublePipe_HeatTransfer
function atributes(in::DoublePipe_HeatTransfer,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="to be documented"
	fields[:Info]="to be documented"
	drive!(fields,_)
	return fields
end
DoublePipe_HeatTransfer(_::Dict{Symbol,Any})=begin
	newModel=DoublePipe_HeatTransfer()
	newModel.attributes=atributes(newModel,_)
	newModel
end
