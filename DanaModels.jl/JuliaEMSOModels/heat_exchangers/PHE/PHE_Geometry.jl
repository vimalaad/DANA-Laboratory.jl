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
#* $Id: PHE.mso 250 2007-04-27 16:32:02Z bicca $
#*------------------------------------------------------------------
type PHE_Geometry
	PHE_Geometry()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin ((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of Chemical Components",
				:Hidden=>true
			]),
			constant ((Symbol=>Any)[
				:Brief=>"Pi Number",
				:Default=>3.14159265,
				:Hidden=>true,
				:Symbol=>"\\pi"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Auxiliar Constant",
				:Hidden=>true,
				:Default=>15
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Auxiliar Constant",
				:Hidden=>true,
				:Default=>14
			]),
			fill(constant ((Symbol=>Any)[
				:Brief=>"First constant in Kumar calculation for Pressure Drop",
				:Hidden=>true
			]),(N1)),
			fill(constant ((Symbol=>Any)[
				:Brief=>"Second constant in Kumar calculation for Pressure Drop",
				:Hidden=>true
			]),(N1)),
			fill(constant ((Symbol=>Any)[
				:Brief=>"First constant in Kumar calculation for Heat Transfer",
				:Hidden=>true
			]),(N2)),
			fill(constant ((Symbol=>Any)[
				:Brief=>"Second constant Kumar calculation for Heat Transfer",
				:Hidden=>true
			]),(N2)),
			fill(molweight ((Symbol=>Any)[
				:Brief=>"Component Mol Weight",
				:Hidden=>true
			]),(NComp)),
			length ((Symbol=>Any)[
				:Brief=>"Vertical Ports Distance",
				:Lower=>0.1
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Total Number of Plates in The Whole Heat Exchanger",
				:Default=>25,
				:Symbol=>"N_{plates}"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of Passes for Hot Side",
				:Symbol=>"Npasshot"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of Passes for Cold Side",
				:Symbol=>"Npasscold"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Ports Diameter",
				:Lower=>1e-6,
				:Symbol=>"D_{ports}"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Plate Width",
				:Lower=>0.1
			]),
			length ((Symbol=>Any)[
				:Brief=>"Plate Pitch",
				:Lower=>0.1
			]),
			length ((Symbol=>Any)[
				:Brief=>"Plate Thickness",
				:Lower=>0.1
			]),
			conductivity ((Symbol=>Any)[
				:Brief=>"Plate Thermal Conductivity",
				:Default=>1.0,
				:Symbol=>"K_{wall}"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Hot Side Fouling Resistance",
				:Unit=>"m^2*K/kW",
				:Default=>1e-6,
				:Lower=>0
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Cold Side Fouling Resistance",
				:Unit=>"m^2*K/kW",
				:Default=>1e-6,
				:Lower=>0
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Enlargement Factor",
				:Lower=>1e-6,
				:Symbol=>"\\phi"
			]),
			area ((Symbol=>Any)[
				:Brief=>"Total Effective  Area",
				:Lower=>1e-6,
				:Symbol=>"A_{total}",
				:Protected=>true
			]),
			area ((Symbol=>Any)[
				:Brief=>"Port Opening  Area of Plate",
				:Lower=>1e-6,
				:Symbol=>"A_{ports}",
				:Protected=>true
			]),
			area ((Symbol=>Any)[
				:Brief=>"Cross-Sectional Area for Channel Flow",
				:Lower=>1e-6,
				:Symbol=>"A_{channel}",
				:Protected=>true
			]),
			length ((Symbol=>Any)[
				:Brief=>"Equivalent Diameter of Channel",
				:Lower=>1e-6,
				:Protected=>true
			]),
			length ((Symbol=>Any)[
				:Brief=>"Corrugation Depth",
				:Lower=>1e-6,
				:Protected=>true
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Total Number of Channels in The Whole Heat Exchanger",
				:Protected=>true
			]),
			length ((Symbol=>Any)[
				:Brief=>"Plate Vertical Distance between Port Centers",
				:Lower=>0.1,
				:Protected=>true
			]),
			length ((Symbol=>Any)[
				:Brief=>"Compact Plate Pack Length",
				:Lower=>0.1,
				:Protected=>true
			]),
			length ((Symbol=>Any)[
				:Brief=>"Plate Horizontal Distance between Port Centers",
				:Lower=>0.1,
				:Protected=>true
			]),
			[:PP,:NComp,:Pi,:N1,:N2,:Kp1,:Kp2,:Kc1,:Kc2,:M,:Lv,:Nplates,:NpassHot,:NpassCold,:Dports,:Lw,:pitch,:pt,:Kwall,:Rfh,:Rfc,:PhiFactor,:Atotal,:Aports,:Achannel,:Dh,:Depth,:Nchannels,:Lp,:Lpack,:Lh,],
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	Pi::constant 
	N1::DanaInteger 
	N2::DanaInteger 
	Kp1::Array{constant }
	Kp2::Array{constant }
	Kc1::Array{constant }
	Kc2::Array{constant }
	M::Array{molweight }
	Lv::length 
	Nplates::DanaInteger 
	NpassHot::DanaInteger 
	NpassCold::DanaInteger 
	Dports::length 
	Lw::length 
	pitch::length 
	pt::length 
	Kwall::conductivity 
	Rfh::positive 
	Rfc::positive 
	PhiFactor::DanaReal 
	Atotal::area 
	Aports::area 
	Achannel::area 
	Dh::length 
	Depth::length 
	Nchannels::DanaInteger 
	Lp::length 
	Lpack::length 
	Lh::length 
	parameters::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export PHE_Geometry
function set(in::PHE_Geometry)
	#"Vector Length of constants for Kumar's calculating Pressure Drop"
	N1 = 15
	 #"Vector Length of constants for Kumar's calculating Heat Transfer"
	N2 = 14
	 #"First constant for Kumar's calculating Pressure Drop"
	Kp1 = [50,19.40,2.990,47,18.290,1.441,34,11.250,0.772,24,3.240,0.760,24,2.80,0.639]
	 #"Second constant for Kumar's calculating Pressure Drop"
	Kp2 = [1,0.589,0.183,1,0.652,0.206,1,0.631,0.161,1,0.457,0.215,1,0.451,0.213]
	 #"First constant for Kumar's calculating Heat Transfer"
	Kc1 = [0.718,0.348,0.718,0.400,0.300,0.630,0.291,0.130,0.562,0.306,0.108,0.562,0.331,0.087]
	 #"Second constant for Kumar's calculating Heat Transfer"
	Kc2 = [0.349,0.663,0.349,0.598,0.663,0.333,0.591,0.732,0.326,0.529,0.703,0.326,0.503,0.718]
	 #"Component Molecular Weight"
	M = PP.MolecularWeight()
	 #"Pi Number"
	Pi = 3.14159265
	 #"Plate Vertical Distance between Port Centers"
	Lp = Lv - Dports
	 #"Corrugation Depth"
	Depth=pitch-pt
	 #"Plate Horizontal Distance between Port Centers"
	Lh=Lw-Dports
	 #"Hydraulic Diameter"
	Dh=2*Depth/PhiFactor
	 #"Ports Area"
	Aports=0.25*Pi*Dports*Dports
	 #"Channel Area"
	Achannel=Depth*Lw
	 #"Pack Length"
	Lpack=Depth*(Nplates-1)+Nplates*pt
	 #"Total Number of  Channels"
	Nchannels = Nplates -1
	 #"Exchange Surface Area"
	Atotal =(Nplates-2)*Lw*Lp*PhiFactor
end
function atributes(in::PHE_Geometry,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Parameters for a gasketed plate heat exchanger."
	drive!(fields,_)
	return fields
end
PHE_Geometry(_::Dict{Symbol,Any})=begin
	newModel=PHE_Geometry()
	newModel.attributes=atributes(newModel,_)
	newModel
end
