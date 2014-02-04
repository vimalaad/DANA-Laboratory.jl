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
type Properties_In_Out
	Properties_In_Out()=begin
		new(
			flow_mass ((Symbol=>Any)[
				:Brief=>"Stream Mass Flow"
			]),
			dens_mass ((Symbol=>Any)[
				:Brief=>"Stream Density" ,
				:Default=>1000,
				:Lower=>1e-3,
				:Upper=>5e5,
				:Symbol=>"\\rho"
			]),
			[:Fw,:rho,]
		)
	end
	Fw::flow_mass 
	rho::dens_mass 
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Properties_In_Out
function atributes(in::Properties_In_Out,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Inlet and outlet physical properties of the streams."
	fields[:Info]="to be documented."
	drive!(fields,_)
	return fields
end
Properties_In_Out(_::Dict{Symbol,Any})=begin
	newModel=Properties_In_Out()
	newModel.attributes=atributes(newModel,_)
	newModel
end
