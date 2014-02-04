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
#*----------------------------------------------------------------------
#* Author: Rafael de Pelegrini Soares
#* $Id$
#*--------------------------------------------------------------------
type Capacitor
	Capacitor()=begin
		new(
			capacitance(),
			charge(),
			wire ((Symbol=>Any)[
				:Brief=>"Inlet",
				:PosX=>0.3978,
				:PosY=>0,
				:Symbol=>"_{in}"
			]),
			wire ((Symbol=>Any)[
				:Brief=>"Outlet",
				:PosX=>0.3965,
				:PosY=>1,
				:Symbol=>"_{out}"
			]),
			[
				:(diff(q) = inlet.i),
				:(inlet.V - outlet.V = (1/C) * q),
				:(outlet.i = inlet.i),
			],
			[
				"","","",
			],
			[:C,],
			[:q,:inlet,:outlet,]
		)
	end
	C::capacitance
	q::charge
	inlet::wire 
	outlet::wire 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Capacitor
function setEquationFlow(in::Capacitor)
	addEquation(1)
	addEquation(2)
	addEquation(3)
end
function atributes(in::Capacitor,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Capacitor"
	fields[:Brief]="Electrical Capacitor."
	drive!(fields,_)
	return fields
end
Capacitor(_::Dict{Symbol,Any})=begin
	newModel=Capacitor()
	newModel.attributes=atributes(newModel,_)
	newModel
end
