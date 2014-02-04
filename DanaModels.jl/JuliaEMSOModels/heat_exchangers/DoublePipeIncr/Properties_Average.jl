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
#* $Id: DoublePipeIncr.mso								$
#*------------------------------------------------------------------
type Properties_Average
	Properties_Average()=begin
		N=outers.N
		new(
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of zones",
				:Default=>2
			]),
			molweight ((Symbol=>Any)[
				:Brief=>"Average Mol Weight",
				:Default=>75,
				:Lower=>1,
				:Upper=>1e8
			]),
			fill(temperature ((Symbol=>Any)[
				:Brief=>"Average  Incremental Temperature",
				:Lower=>50
			]),(N)),
			fill(pressure ((Symbol=>Any)[
				:Brief=>"Average  Incremental Pressure",
				:Default=>1,
				:Lower=>1e-10,
				:Upper=>2e4,
				:DisplayUnit=>"kPa"
			]),(N)),
			fill(dens_mass ((Symbol=>Any)[
				:Brief=>"Stream Incremental Density" ,
				:Default=>1000,
				:Lower=>1e-3,
				:Upper=>5e5,
				:Symbol=>"\\rho"
			]),(N)),
			fill(viscosity ((Symbol=>Any)[
				:Brief=>"Stream Incremental Viscosity",
				:Lower=>0.0001,
				:Symbol=>"\\mu"
			]),(N)),
			fill(cp_mol ((Symbol=>Any)[
				:Brief=>"Stream Incremental Molar Heat Capacity",
				:Upper=>1e10
			]),(N)),
			fill(conductivity ((Symbol=>Any)[
				:Brief=>"Stream Incremental Thermal Conductivity",
				:Default=>1.0,
				:Lower=>1e-5,
				:Upper=>500
			]),(N)),
			[:N,],
			[:Mw,:T,:P,:rho,:Mu,:Cp,:K,]
		)
	end
	N::DanaInteger 
	Mw::molweight 
	T::Array{temperature }
	P::Array{pressure }
	rho::Array{dens_mass }
	Mu::Array{viscosity }
	Cp::Array{cp_mol }
	K::Array{conductivity }
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Properties_Average
function atributes(in::Properties_Average,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Average incremental physical properties of the streams."
	fields[:Info]="to be documented."
	drive!(fields,_)
	return fields
end
Properties_Average(_::Dict{Symbol,Any})=begin
	newModel=Properties_Average()
	newModel.attributes=atributes(newModel,_)
	newModel
end
