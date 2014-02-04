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
#* File containg models of columns: distillation, stripping, absorbers
#* rectifier, ....
#*
#* The default nomenclature is:
#*		Type_Column_reboilertype_condensertyper
#*
#* where:
#*	Type = refluxed or reboiled or section
#*	Column = Stripping, Absorption, Rectifier, Distillation
#*	Reboiler type (if exists) = kettle or thermosyphon 
#*	Condenser type (if exists) = with subccoling or without subcooling
#* 
#*-----------------------------------------------------------------------
#* Author: Paula B. Staudt
#* $Id$
#*---------------------------------------------------------------------
#----------------------------------------------------------------------
#* Model of a  column section with:
#*	- NTrays=number of trays.
#* 
#*---------------------------------------------------------------------
type Section_Column
	Section_Column()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger(),
			DanaInteger((Symbol=>Any)[
				:Brief=>"Number of trays",
				:Default=>2
			]),
			DanaInteger((Symbol=>Any)[
				:Brief=>"Trays counting (1=top-down, -1=bottom-up)",
				:Default=>1
			]),
			DanaInteger((Symbol=>Any)[
				:Brief=>"Number of top tray"
			]),
			DanaInteger((Symbol=>Any)[
				:Brief=>"Number of bottom tray"
			]),
			fill(tray()),
			[:PP,:NComp,:NTrays,:topdown,:top,:bot,],
			[:trays,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	NTrays::DanaInteger
	topdown::DanaInteger
	top::DanaInteger
	bot::DanaInteger
	trays::Array{tray}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Section_Column
function set(in::Section_Column)
	top = (NTrays-1)*(1-topdown)/2+1
	 bot = NTrays/top
	 
end
function atributes(in::Section_Column,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/SectionColumn"
	fields[:Brief]="Model of a column section."
	fields[:Info]="== Model of a column section containing ==
* NTrays trays.
	
== Specify ==
* the feed stream of each tray (Inlet);
* the Murphree eficiency for each tray Emv;
* the InletL stream of the top tray;
* the InletV stream of the bottom tray.
	
== Initial Conditions ==
* the trays temperature (OutletL.T);
* the trays liquid level (Level) OR the trays liquid flow (OutletL.F);
* (NoComps - 1) OutletL (OR OutletV) compositions for each tray.
"
	drive!(fields,_)
	return fields
end
Section_Column(_::Dict{Symbol,Any})=begin
	newModel=Section_Column()
	newModel.attributes=atributes(newModel,_)
	newModel
end
