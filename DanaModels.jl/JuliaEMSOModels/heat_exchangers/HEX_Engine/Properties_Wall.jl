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
type Properties_Wall
	Properties_Wall()=begin
		new(
			viscosity ((Symbol=>Any)[
				:Brief=>"Stream Viscosity",
				:Default=>1,
				:Lower=>1e-5,
				:Upper=>1e5,
				:Symbol=>"\\mu"
			]),
			temperature ((Symbol=>Any)[
				:Brief=>"Wall Temperature",
				:Lower=>50
			]),
			[:Mu,:Twall,]
		)
	end
	Mu::viscosity 
	Twall::temperature 
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Properties_Wall
function atributes(in::Properties_Wall,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Physical properties of the streams at wall temperature."
	fields[:Info]="to be documented."
	drive!(fields,_)
	return fields
end
Properties_Wall(_::Dict{Symbol,Any})=begin
	newModel=Properties_Wall()
	newModel.attributes=atributes(newModel,_)
	newModel
end
