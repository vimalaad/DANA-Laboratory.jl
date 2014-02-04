#---------------------------------------------------------------------
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
#* Model of a tank basic
#*----------------------------------------------------------------------
#*
#*   Description:
#*       Generic model for a dynamic tank.
#*
#*   Assumptions:
#*		* single- and two-phases involved
#*       * dynamic
#*
#*----------------------------------------------------------------------
#* Author: Rodolfo Rodrigues
#* $Id$
#*--------------------------------------------------------------------
type tank_basic
	tank_basic()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin ((Symbol=>Any)[
				:Brief=>"External physical properties",
				:Type=>"PP"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of components",
				:Default=>1
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet stream",
				:PosX=>0,
				:PosY=>0,
				:Symbol=>"_{in}"
			]),
			stream ((Symbol=>Any)[
				:Brief=>"Intermediary outlet stream",
				:Symbol=>"_{outm}",
				:Hidden=>true
			]),
			vol_tank ((Symbol=>Any)[
				:Brief=>"Routine to volume tank calculation",
				:Symbol=>"_{tank}"
			]),
			fill(mol ((Symbol=>Any)[
				:Brief=>"Component molar holdup",
				:Protected=>true
			]),(NComp)),
			mol ((Symbol=>Any)[
				:Brief=>"Total component molar holdup",
				:Protected=>true
			]),
			energy ((Symbol=>Any)[
				:Brief=>"Internal energy",
				:Protected=>true
			]),
			heat_rate((Symbol=>Any)[
				:Brief=>"Reactor duty",
				:Default=>0
			]),
			[
				:(diff(M) = Inlet.F*Inlet.z - Outletm.F*Outletm.z),
				:(M = Mt*Outletm.z),
				:(sum(Outletm.z) = 1),
				:(diff(E) = Inlet.F*Inlet.h - Outletm.F*Outletm.h + Q),
			],
			[
				"Component molar balance","Component molar","Mole fraction normalisation","Energy balance",
			],
			[:PP,:NComp,],
			[:Inlet,:Outletm,:Tank,:M,:Mt,:E,:Q,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	Inlet::stream 
	Outletm::stream 
	Tank::vol_tank 
	M::Array{mol }
	Mt::mol 
	E::energy 
	Q::heat_rate
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export tank_basic
function setEquationFlow(in::tank_basic)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
end
function atributes(in::tank_basic,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Brief]="Basic model for a dynamic tank"
	drive!(fields,_)
	return fields
end
tank_basic(_::Dict{Symbol,Any})=begin
	newModel=tank_basic()
	newModel.attributes=atributes(newModel,_)
	newModel
end
