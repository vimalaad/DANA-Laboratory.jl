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
type Resistor
	Resistor()=begin
		new(
			resistance(),
			wire ((Symbol=>Any)[
				:Brief=>"Inlet",
				:PosX=>0.3831,
				:PosY=>0,
				:Symbol=>"_{in}"
			]),
			wire ((Symbol=>Any)[
				:Brief=>"Outlet",
				:PosX=>0.3529,
				:PosY=>1,
				:Symbol=>"_{out}"
			]),
			[
				:(inlet.V - outlet.V = R * outlet.i),
				:(outlet.i = inlet.i),
			],
			[
				"","",
			],
			[:R,],
			[:inlet,:outlet,]
		)
	end
	R::resistance
	inlet::wire 
	outlet::wire 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Resistor
function setEquationFlow(in::Resistor)
	addEquation(1)
	addEquation(2)
end
function atributes(in::Resistor,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Resistor"
	fields[:Brief]="Electrical Resistor."
	drive!(fields,_)
	return fields
end
Resistor(_::Dict{Symbol,Any})=begin
	newModel=Resistor()
	newModel.attributes=atributes(newModel,_)
	newModel
end
