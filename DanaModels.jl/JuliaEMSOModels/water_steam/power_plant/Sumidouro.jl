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
#*
#*--------------------------------------------------------------------
#* Models to simulate a power plant.
#*--------------------------------------------------------------------
#* Author: Argimiro R. Secchi
#* $Id: power_plant.mso 195 2007-03-07 20:30:12Z arge $
#*-------------------------------------------------------------------
# Declaracao de tipos
type Sumidouro
	Sumidouro()=begin
		new(
			Corrente((Symbol=>Any)[
				:Symbol=>"_{in}",
				:PosX=>0,
				:PosY=>0.5 
			]),
			[:Fin,]
		)
	end
	Fin::Corrente
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Sumidouro
function atributes(in::Sumidouro,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/sumidouro"
	fields[:Brief]="Sumidouro de corrente de processo"
	fields[:Info]=" "
	drive!(fields,_)
	return fields
end
Sumidouro(_::Dict{Symbol,Any})=begin
	newModel=Sumidouro()
	newModel.attributes=atributes(newModel,_)
	newModel
end
