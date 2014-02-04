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
type Baffles_Main
	Baffles_Main()=begin
		new(
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Baffle Cut",
				:Default=>25,
				:Lower=>25
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Number of Baffles",
				:Symbol=>"N_{baffles}",
				:Lower=>1
			]),
			length ((Symbol=>Any)[
				:Brief=>"Inlet Baffle Spacing",
				:Lower=>1e-8,
				:Symbol=>"L_{si}",
				:DisplayUnit=>"mm" 
			]),
			length ((Symbol=>Any)[
				:Brief=>"Central Baffle Spacing",
				:Lower=>1e-8,
				:Symbol=>"L_s",
				:DisplayUnit=>"mm" 
			]),
			length ((Symbol=>Any)[
				:Brief=>"Outlet Baffle Spacing",
				:Lower=>1e-8,
				:Symbol=>"L_{so}",
				:DisplayUnit=>"mm" 
			]),
			[:BaffleCut,:NumberOfBaffles,],
			[:Inlet_Spacing,:Central_Spacing,:Outlet_Spacing,]
		)
	end
	BaffleCut::DanaInteger 
	NumberOfBaffles::DanaReal 
	Inlet_Spacing::length 
	Central_Spacing::length 
	Outlet_Spacing::length 
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Baffles_Main
function atributes(in::Baffles_Main,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Main variables in the Baffle section of a shell and tube heat exchanger."
	drive!(fields,_)
	return fields
end
Baffles_Main(_::Dict{Symbol,Any})=begin
	newModel=Baffles_Main()
	newModel.attributes=atributes(newModel,_)
	newModel
end
