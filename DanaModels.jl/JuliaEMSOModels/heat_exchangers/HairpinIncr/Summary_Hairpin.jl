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
type Summary_Hairpin
	Summary_Hairpin()=begin
		new(
			area ((Symbol=>Any)[
				:Brief=>"Total Exchange Surface Area"
			]),
			power ((Symbol=>Any)[
				:Brief=>"Total Duty",
				:Default=>7000,
				:Lower=>1e-8,
				:Upper=>1e10
			]),
			Results_Hairpin ((Symbol=>Any)[
				:Brief=>"Inner Side Summary"
			]),
			Results_Hairpin ((Symbol=>Any)[
				:Brief=>"Outer Side Summary"
			]),
			[:A,:Qtotal,:Inner,:Outer,]
		)
	end
	A::area 
	Qtotal::power 
	Inner::Results_Hairpin 
	Outer::Results_Hairpin 
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Summary_Hairpin
function atributes(in::Summary_Hairpin,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="to be documented"
	fields[:Info]="to be documented"
	drive!(fields,_)
	return fields
end
Summary_Hairpin(_::Dict{Symbol,Any})=begin
	newModel=Summary_Hairpin()
	newModel.attributes=atributes(newModel,_)
	newModel
end
