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
#* $Id: HairpinIncr.mso								$
#*------------------------------------------------------------------
type HairpinIncr
	HairpinIncr()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin ((Symbol=>Any)[
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of Components"
			]),
			constant ((Symbol=>Any)[
				:Brief=>"Pi Number",
				:Default=>3.14159265,
				:Symbol=>"\\pi"
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of zones",
				:Default=>2
			]),
			DanaInteger ((Symbol=>Any)[
				:Brief=>"Number of incremental points",
				:Default=>3
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
			length ((Symbol=>Any)[
				:Brief=>"Inner Side Outlet Nozzle Diameter",
				:Default=>0.036,
				:Lower=>1e-6
			]),
			length ((Symbol=>Any)[
				:Brief=>"Inner Side Inlet Nozzle Diameter",
				:Default=>0.036,
				:Lower=>1e-6
			]),
			length ((Symbol=>Any)[
				:Brief=>"Outer Side Outlet Nozzle Diameter",
				:Default=>0.036,
				:Lower=>1e-6
			]),
			length ((Symbol=>Any)[
				:Brief=>"Outer Side Inlet Nozzle Diameter",
				:Default=>0.036,
				:Lower=>1e-6
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Inner Side Inlet Nozzle Pressure Loss Coeff",
				:Default=>1.1
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Inner Side Outlet Nozzle Pressure Loss Coeff",
				:Default=>0.7
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Outer Side Inlet Nozzle Pressure Loss Coeff",
				:Default=>1.1
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Outer Side Outlet Nozzle Pressure Loss Coeff",
				:Default=>0.7
			]),
			Summary_Hairpin ((Symbol=>Any)[
				:Brief=>"Results for The Whole Heat Exchanger"
			]),
			UpperPipe_basic ((Symbol=>Any)[
				:Brief=>"Upper Pipe Results"
			]),
			LowerPipe_basic ((Symbol=>Any)[
				:Brief=>"Lower Pipe Results"
			]),
			[
				:(Summary.A = LowerPipe.Details.A+UpperPipe.Details.A),
				:(Summary.Qtotal = LowerPipe.Details.Qtotal+UpperPipe.Details.Qtotal),
				:(Summary.Inner.Pdrop = Summary.Inner.Pdnozzle_in+Summary.Inner.Pdnozzle_out+LowerPipe.Inner.PressureDrop.Pd_fric(1) +UpperPipe.Inner.PressureDrop.Pd_fric(Npoints)),
				:(Summary.Outer.Pdrop = Summary.Outer.Pdnozzle_in+Summary.Outer.Pdnozzle_out+LowerPipe.Outer.PressureDrop.Pd_fric(Npoints) +UpperPipe.Outer.PressureDrop.Pd_fric(1)),
				:(UpperPipe.Outer.PressureDrop.Plocal([1:N]) = UpperPipe.Outer.PressureDrop.Plocal(Npoints) - UpperPipe.Outer.PressureDrop.Pd_fric([1:N])),
				:(UpperPipe.Inner.PressureDrop.Plocal([1:N]+1) = UpperPipe.Inner.PressureDrop.Plocal(1) - UpperPipe.Inner.PressureDrop.Pd_fric([1:N]+1)),
				:(LowerPipe.Inner.PressureDrop.Plocal([1:N]) = LowerPipe.Inner.PressureDrop.Plocal(Npoints) - LowerPipe.Inner.PressureDrop.Pd_fric([1:N])),
				:(LowerPipe.Outer.PressureDrop.Plocal([1:N]+1) = LowerPipe.Outer.PressureDrop.Plocal(1) - LowerPipe.Outer.PressureDrop.Pd_fric([1:N]+1)),
				:(Summary.Inner.Vnozzle_in = UpperPipe.Inner.Properties.Inlet.Fw/(UpperPipe.Inner.Properties.Inlet.rho*(0.25*Pi*Dinozzle_Inner^2))),
				:(Summary.Inner.Vnozzle_out = LowerPipe.Inner.Properties.Outlet.Fw/(LowerPipe.Inner.Properties.Outlet.rho*(0.25*Pi*Donozzle_Inner^2))),
				:(Summary.Outer.Vnozzle_in = LowerPipe.Outer.Properties.Inlet.Fw/(LowerPipe.Outer.Properties.Inlet.rho*(0.25*Pi*Dinozzle_Outer^2))),
				:(Summary.Outer.Vnozzle_out = UpperPipe.Outer.Properties.Outlet.Fw/(UpperPipe.Outer.Properties.Outlet.rho*(0.25*Pi*Donozzle_Outer^2))),
				:(Summary.Inner.Pdnozzle_in = 0.5*InnerKinlet*UpperPipe.Inner.Properties.Inlet.rho*Summary.Inner.Vnozzle_in^2),
				:(Summary.Inner.Pdnozzle_out = 0.5*InnerKoutlet*LowerPipe.Inner.Properties.Outlet.rho*Summary.Inner.Vnozzle_out^2),
				:(Summary.Outer.Pdnozzle_in = 0.5*OuterKinlet*LowerPipe.Outer.Properties.Inlet.rho*Summary.Outer.Vnozzle_in^2),
				:(Summary.Outer.Pdnozzle_out = 0.5*OuterKoutlet*UpperPipe.Outer.Properties.Outlet.rho*Summary.Outer.Vnozzle_out^2),
				:(Summary.Inner.RVsquare_in = UpperPipe.Inner.Properties.Inlet.rho*(Summary.Inner.Vnozzle_in)^2),
				:(Summary.Inner.RVsquare_out = LowerPipe.Inner.Properties.Outlet.rho*(Summary.Inner.Vnozzle_out)^2),
				:(Summary.Outer.RVsquare_in = LowerPipe.Outer.Properties.Inlet.rho*(Summary.Outer.Vnozzle_in)^2),
				:(Summary.Outer.RVsquare_out = UpperPipe.Outer.Properties.Outlet.rho*(Summary.Outer.Vnozzle_out)^2),
				:(Summary.Outer.hcoeff = sum(UpperPipe.Outer.HeatTransfer.hcoeff+LowerPipe.Outer.HeatTransfer.hcoeff)/(2*N)),
				:(Summary.Inner.hcoeff = sum(UpperPipe.Inner.HeatTransfer.hcoeff+LowerPipe.Inner.HeatTransfer.hcoeff)/(2*N)),
			],
			[
				"Total Exchange Surface Area","Total Duty","Total Pressure Drop Inner Side","Total Pressure Drop Outer Side","Outer Pipe Local Pressure","Inner Pipe Local Pressure","Inner Pipe Local Pressure","Outer Pipe Local Pressure","Velocity Inner Side Inlet Nozzle","Velocity Inner Side Outlet Nozzle","Velocity Outer Side Inlet Nozzle","Velocity Outer Side Outlet Nozzle","Pressure Drop Inner Side Inlet Nozzle","Pressure Drop Inner Side Outlet Nozzle","Pressure Drop Outer Side Inlet Nozzle","Pressure Drop Outer Side Outlet Nozzle","Inner Side Inlet Nozzle rho-V^2","Inner Side Outlet Nozzle rho-V^2","Outer Side Inlet Nozzle rho-V^2","Outer Side Outlet Nozzle rho-V^2","Average Film Coefficient Outer Side","Average Film Coefficient Inner Side",
			],
			[:PP,:NComp,:Pi,:N,:Npoints,:DoInner,:DiInner,:DiOuter,:Lpipe,:Kwall,:Rfi,:Rfo,:Donozzle_Inner,:Dinozzle_Inner,:Donozzle_Outer,:Dinozzle_Outer,:InnerKinlet,:InnerKoutlet,:OuterKinlet,:OuterKoutlet,],
			[:Summary,:UpperPipe,:LowerPipe,]
		)
	end
	PP::DanaPlugin 
	NComp::DanaInteger 
	Pi::constant 
	N::DanaInteger 
	Npoints::DanaInteger 
	DoInner::length 
	DiInner::length 
	DiOuter::length 
	Lpipe::length 
	Kwall::conductivity 
	Rfi::positive 
	Rfo::positive 
	Donozzle_Inner::length 
	Dinozzle_Inner::length 
	Donozzle_Outer::length 
	Dinozzle_Outer::length 
	InnerKinlet::positive 
	InnerKoutlet::positive 
	OuterKinlet::positive 
	OuterKoutlet::positive 
	Summary::Summary_Hairpin 
	UpperPipe::UpperPipe_basic 
	LowerPipe::LowerPipe_basic 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export HairpinIncr
function set(in::HairpinIncr)
	#"Pi Number"
	Pi = 3.14159265
	 #"Number of incremental points"
	Npoints = N+1
	 
end
function setEquationFlow(in::HairpinIncr)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	# FIXME: NOZZLE PRESSURE DROP MUST BE ADDED
	addEquation(5)
	# FIXME: NOZZLE PRESSURE DROP MUST BE ADDED
	addEquation(6)
	# FIXME: NOZZLE PRESSURE DROP MUST BE ADDED
	addEquation(7)
	# FIXME: NOZZLE PRESSURE DROP MUST BE ADDED
	addEquation(8)
	addEquation(9)
	addEquation(10)
	addEquation(11)
	addEquation(12)
	addEquation(13)
	addEquation(14)
	addEquation(15)
	addEquation(16)
	addEquation(17)
	addEquation(18)
	addEquation(19)
	addEquation(20)
	addEquation(21)
	addEquation(22)
end
function atributes(in::HairpinIncr,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/hairpin"
	fields[:Brief]="Incremental Hairpin Heat Exchanger. "
	fields[:Info]="Incremental approach for Hairpin heat exchanger.
OBS: LEFT = 0 e N = N, RIGTH= L e N=1
"
	drive!(fields,_)
	return fields
end
HairpinIncr(_::Dict{Symbol,Any})=begin
	newModel=HairpinIncr()
	newModel.attributes=atributes(newModel,_)
	newModel
end
