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
#* Author: Paula B. Staudt
#* $Id$
#*--------------------------------------------------------------------
#----------------------------------------------------------------------------------*
#*
#*-------------------------  Fundamental Variables ----------------------------------*
#*
#*----------------------------------------------------------------------------------
# Constants
# Pressure
# Temperature
# Time
# Size related
# Eletric
# Currency
#----------------------------------------------------------------------------------*
#*
#*-------------------------  Concentration Related ----------------------------------*
#*
#*----------------------------------------------------------------------------------
# elementary
# densities
# Concentration
# reaction
#----------------------------------------------------------------------------------*
#*
#*------------------------- Thermodynamics Properties -------------------------------*
#*
#*----------------------------------------------------------------------------------
# Heat Capacity
# Enthalpy
# Entropy
# Heat
# Energy
#----------------------------------------------------------------------------------*
#*
#*--------------------------- Mass Transport ----------------------------------------*
#*
#*----------------------------------------------------------------------------------
# Flow
# Flux
# Velocity
# Others
#----------------------------------------------------------------------------------*
#*
#*------------------------ Physical and Chemistry Properties ------------------------*
#*
#*----------------------------------------------------------------------------------
# Conductivity
# Difusivity
# Fugacity
export viscosity
typealias Danaviscosity DanaRealParametric
type _viscosity
	function _viscosity(_::Dict{Symbol,Any})
		fields::Dict{Symbol,Any}=(Symbol=>Any)[]
		fields[:Brief]="Viscosity"
		fields[:Default]=1
		fields[:Lower]=1e-30
		fields[:Upper]=1e5
		fields[:finalUnit]="cP"
		drive!(fields,_)
		new(fields)
	end
	value::Dict{Symbol,Any}
end
typealias viscosity DanaRealParametric{_viscosity}