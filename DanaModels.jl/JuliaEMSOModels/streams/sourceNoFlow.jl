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
#* Model of basic streams
#*----------------------------------------------------------------------
#* Author: Paula B. Staudt and Rafael de P. Soares
#* $Id$
#*---------------------------------------------------------------------
type sourceNoFlow
	sourceNoFlow()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin ((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of chemical components",
				:Lower=>1
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Outlet stream",
				:PosX=>1,
				:PosY=>0.5256,
				:Symbol=>"_{out}",
				:Protected=>true
			]),
			[
				:(Outlet.z = 1/NComp),
				:(Outlet.h = 0 * "J/mol"),
				:(Outlet.T = 300 * "K"),
				:(Outlet.F = 0 * "kmol/h"),
				:(Outlet.P = 1 * "atm"),
				:(Outlet.v = 0),
			],
			[
				"Stream Molar Composition","Stream Molar Enthalpy","Stream Temperature","Stream Molar Flow","Stream Pressure","Stream Vapour Fraction",
			],
			[:PP,:NComp,],
			[:Outlet,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	Outlet::stream 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export sourceNoFlow
function setEquationFlow(in::sourceNoFlow)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
end
function atributes(in::sourceNoFlow,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/SourceNoFlow"
	fields[:Brief]="Simple Material stream source with no flow."
	fields[:Info]="
	This model should be used for boundary streams.
	Usually these streams are known and come from another process
	units."
	drive!(fields,_)
	return fields
end
sourceNoFlow(_::Dict{Symbol,Any})=begin
	newModel=sourceNoFlow()
	newModel.attributes=atributes(newModel,_)
	newModel
end
