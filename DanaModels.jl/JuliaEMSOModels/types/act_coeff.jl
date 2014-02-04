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
# Viscosity
# Molar and Specific Volume 
# Others
export act_coeff
typealias Danaact_coeff Danapositive
type _act_coeff
	function _act_coeff(_::Dict{Symbol,Any})
		fields::Dict{Symbol,Any}=(Symbol=>Any)[]
		fields[:Brief]="Activity Coefficient for Liquid"
		fields[:Default]=1
		fields[:Upper]=30
		drive!(fields,_)
		new(_positive (fields).value)
	end
	value::Dict{Symbol,Any}
end
typealias act_coeff Danapositive{_act_coeff}