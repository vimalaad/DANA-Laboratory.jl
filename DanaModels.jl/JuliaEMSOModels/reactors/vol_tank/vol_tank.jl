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
#* Model for tank volume calculation
#*----------------------------------------------------------------------
#*
#* 	Routine to calculate tank volume and level tank volume from 
#* different geometries and orientations.
#*
#*	Geometry:
#*		* Flat (no head) (default)
#*		* Spherical
#*
#*	Orientation:
#*		* Vertical (default)
#*		* Horizontal
#*
#*----------------------------------------------------------------------
#* Author: Rodolfo Rodrigues
#* $Id$
#*--------------------------------------------------------------------
type vol_tank
	vol_tank()=begin
		new(
			positive ((Symbol=>Any)[
				:Brief=>"Pi value",
				:Default=>3.141593,
				:Symbol=>"\\pi",
				:Hidden=>true
			]),
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Tank head type",
				:Valid=>["flat","spherical"],
				:Default=>"flat"
			]),
			DanaSwitcher((Symbol=>Any)[
				:Brief=>"Tank orientation",
				:Valid=>["vertical","horizontal"],
				:Default=>"vertical"
			]),
			volume ((Symbol=>Any)[
				:Brief=>"Level tank volume"
			]),
			volume ((Symbol=>Any)[
				:Brief=>"Tank volume"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Tank length"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Tank level"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Tank diameter"
			]),
			area ((Symbol=>Any)[
				:Brief=>"Tank cross section area"
			]),
			[
				:(V = Across*Level),
				:(Vt = pi/4*(D^2)*L),
				:(V = pi/4*(D^2)*Level),
				:(Vt = pi/6*D^3),
				:(V = pi/3*Level^2*(3*D/2 - Level)),
				:(Vt = pi/4*(D^2)*L),
				:(V = ((D^2)*acos((D - 2*Level)/D)/4/"rad" - (D - 2*Level)*sqrt(D*Level - Level^2)/2)*L),
				:(Vt = pi/6*D^3),
				:(V = pi/3*Level^2*(3*D/2 - Level)),
			],
			[
				"Content volume","Tank volume","Level tank volume","Tank volume","Level tank volume","Tank volume","Level tank volume","Tank volume","Level tank volume",
			],
			[:pi,:Geometry,:Orientation,],
			[:V,:Vt,:L,:Level,:D,:Across,]
		)
	end
	pi::positive 
	Geometry::DanaSwitcher 
	Orientation::DanaSwitcher
	V::volume 
	Vt::volume 
	L::length 
	Level::length 
	D::length 
	Across::area 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export vol_tank
function setEquationFlow(in::vol_tank)
	addEquation(1)
	let switch=Orientation
		if switch=="vertical"
			let switch=Geometry
				if switch=="flat"
					addEquation(2)
					addEquation(3)
				elseif switch=="spherical"
					addEquation(4)
					addEquation(5)
				end
			end
		elseif switch=="horizontal"
			let switch=Geometry
				if switch=="flat"
					addEquation(6)
					addEquation(7)
				elseif switch=="spherical"
					addEquation(8)
					addEquation(9)
				end
			end
		end
	end
end
function atributes(in::vol_tank,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Routine to calculate tank volume"
	fields[:Info]="
Based in 2 geometry and 2 configurations/orientations

== Geometry ==
* Flat (no head) (default)
* Spherical

== Orientation ==
* Vertical (default)
* Horizontal
"
	drive!(fields,_)
	return fields
end
vol_tank(_::Dict{Symbol,Any})=begin
	newModel=vol_tank()
	newModel.attributes=atributes(newModel,_)
	newModel
end
