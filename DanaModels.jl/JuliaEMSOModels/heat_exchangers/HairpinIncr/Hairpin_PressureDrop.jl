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
type Hairpin_PressureDrop
	Hairpin_PressureDrop()=begin
		N=outers.N
		Npoints=outers.Npoints
		new(
			length ((Symbol=>Any)[
				:Brief=>"Hydraulic Diameter of Pipe for Pressure Drop",
				:Lower=>1e-6
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of zones",
				:Default=>2
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of incremental points",
				:Default=>3
			]),
			fill(pressure ((Symbol=>Any)[
				:Brief=>"Incremental Local  Pressure",
				:Default=>1,
				:Lower=>1e-10,
				:Upper=>2e4,
				:DisplayUnit=>"kPa"
			]),(Npoints)),
			fill(press_delta ((Symbol=>Any)[
				:Brief=>"Incremental Pressure Drop for friction",
				:Default=>1e-3,
				:Lower=>0,
				:DisplayUnit=>"kPa",
				:Symbol=>"\\Delta P_{fric}"
			]),(Npoints)),
			fill(fricfactor ((Symbol=>Any)[
				:Brief=>"Incremental Friction Factor",
				:Default=>0.05,
				:Lower=>1e-10,
				:Upper=>2000
			]),(N)),
			fill(positive ((Symbol=>Any)[
				:Brief=>"Incremental Reynolds Number",
				:Default=>100,
				:Lower=>1
			]),(N)),
			[:Dh,:N,:Npoints,],
			[:Plocal,:Pd_fric,:fi,:Re,]
		)
	end
	Dh::length 
	N::DanaInteger 
	Npoints::DanaInteger 
	Plocal::Array{pressure }
	Pd_fric::Array{press_delta }
	fi::Array{fricfactor }
	Re::Array{positive }
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Hairpin_PressureDrop
function atributes(in::Hairpin_PressureDrop,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="to be documented"
	fields[:Info]="to be documented"
	drive!(fields,_)
	return fields
end
Hairpin_PressureDrop(_::Dict{Symbol,Any})=begin
	newModel=Hairpin_PressureDrop()
	newModel.attributes=atributes(newModel,_)
	newModel
end
