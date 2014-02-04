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
type Clearances_Main
	Clearances_Main()=begin
		new(
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of Sealing Strips pairs",
				:Lower=>1
			]),
			length ((Symbol=>Any)[
				:Brief=>"Height Under Shell Inlet Nozzle",
				:Lower=>1E-6
			]),
			length ((Symbol=>Any)[
				:Brief=>"Height Under Shell Outlet Nozzle",
				:Lower=>1E-6
			]),
			length ((Symbol=>Any)[
				:Brief=>"Bundle-to-Shell Clearance",
				:Symbol=>"L_{cf}",
				:Lower=>1E-8
			]),
			length ((Symbol=>Any)[
				:Brief=>"Baffle-to-Shell Clearance",
				:Symbol=>"L_{cd}",
				:Lower=>1E-8
			]),
			length ((Symbol=>Any)[
				:Brief=>"Tube-to-Baffle Clearance",
				:Symbol=>"L_{td}",
				:Lower=>1E-8
			]),
			[:SealStrip,:Hinozzle_Shell,:Honozzle_Shell,:BundleToShell,:BaffleToShell,:TubeToBaffle,],
		)
	end
	SealStrip::DanaInteger 
	Hinozzle_Shell::length 
	Honozzle_Shell::length 
	BundleToShell::length 
	BaffleToShell::length 
	TubeToBaffle::length 
	parameters::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Clearances_Main
function atributes(in::Clearances_Main,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Main parameters for diametral clearances in a shell and tube heat exchanger."
	drive!(fields,_)
	return fields
end
Clearances_Main(_::Dict{Symbol,Any})=begin
	newModel=Clearances_Main()
	newModel.attributes=atributes(newModel,_)
	newModel
end
