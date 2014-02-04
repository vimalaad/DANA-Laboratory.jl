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
#*------------------------------------------------------------------
type DoublePipe_Geometry
	DoublePipe_Geometry()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin ((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of Components",
				:Hidden=>true
			]),
			fill(molweight ((Symbol=>Any)[
				:Brief=>"Component Mol Weight",
				:Hidden=>true
			]),(NComp)),
			constant ((Symbol=>Any)[
				:Brief=>"Pi Number",
				:Default=>3.14159265,
				:Symbol=>"\\pi",
				:Hidden=>true
			]),
			length ((Symbol=>Any)[
				:Brief=>"Outside Diameter of Inner Pipe",
				:Lower=>1e-6
			]),
			length ((Symbol=>Any)[
				:Brief=>"Inside Diameter of Inner Pipe",
				:Lower=>1e-10
			]),
			length ((Symbol=>Any)[
				:Brief=>"Inside Diameter of Outer pipe",
				:Lower=>1e-10
			]),
			length ((Symbol=>Any)[
				:Brief=>"Effective Tube Length of one segment of Pipe",
				:Lower=>0.1,
				:Symbol=>"L_{pipe}"
			]),
			conductivity ((Symbol=>Any)[
				:Brief=>"Tube Wall Material Thermal Conductivity",
				:Default=>1.0,
				:Symbol=>"K_{wall}"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Inside Fouling Resistance",
				:Unit=>"m^2*K/kW",
				:Default=>1e-6,
				:Lower=>0
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Outside Fouling Resistance",
				:Unit=>"m^2*K/kW",
				:Default=>1e-6,
				:Lower=>0
			]),
			[:PP,:NComp,:M,:Pi,:DoInner,:DiInner,:DiOuter,:Lpipe,:Kwall,:Rfi,:Rfo,],
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	M::Array{molweight }
	Pi::constant 
	DoInner::length 
	DiInner::length 
	DiOuter::length 
	Lpipe::length 
	Kwall::conductivity 
	Rfi::positive 
	Rfo::positive 
	parameters::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export DoublePipe_Geometry
function set(in::DoublePipe_Geometry)
	#"Component Molecular Weight"
	M = PP.MolecularWeight()
	 #"Pi Number"
	Pi = 3.14159265
end
function atributes(in::DoublePipe_Geometry,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="double pipe geometrical parameters."
	drive!(fields,_)
	return fields
end
DoublePipe_Geometry(_::Dict{Symbol,Any})=begin
	newModel=DoublePipe_Geometry()
	newModel.attributes=atributes(newModel,_)
	newModel
end
