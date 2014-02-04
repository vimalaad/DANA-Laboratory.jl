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
type UpperPipe_basic
	UpperPipe_basic()=begin
		PP=outers.PP
		NComp=outers.NComp
		Pi=outers.Pi
		N=outers.N
		Npoints=outers.Npoints
		DoInner=outers.DoInner
		DiInner=outers.DiInner
		DiOuter=outers.DiOuter
		Lpipe=outers.Lpipe
		Kwall=outers.Kwall
		Rfi=outers.Rfi
		Rfo=outers.Rfo
		new(
			HairpinIncr_basic(),
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
			[
				:(_P1.Details.Q(1:N) = _P1.InletOuter.F*(_P1.Outer.HeatTransfer.Enth(2:_P1.Npoints) - _P1.Outer.HeatTransfer.Enth(1:N))),
				:(_P1.Details.Q(1:N) = -_P1.InletInner.F*(_P1.Inner.HeatTransfer.Enth(1:N) - _P1.Inner.HeatTransfer.Enth(2:_P1.Npoints))),
				:(_P1.Details.Q = _P1.Details.Ud*_P1.Pi*_P1.DoInner*(_P1.Lpipe/N)*(_P1.Outer.Properties.Average.T - _P1.Inner.Properties.Average.T)),
				:(_P1.Details.Q(1:N) = _P1.InletInner.F*(_P1.Inner.HeatTransfer.Enth(1:N)-_P1.Inner.HeatTransfer.Enth(2:_P1.Npoints))),
				:(_P1.Details.Q(1:N) = -_P1.InletOuter.F*(_P1.Outer.HeatTransfer.Enth(2:_P1.Npoints) - _P1.Outer.HeatTransfer.Enth(1:N))),
				:(_P1.Details.Q = _P1.Details.Ud*_P1.Pi*_P1.DoInner*(_P1.Lpipe/N)*(_P1.Inner.Properties.Average.T - _P1.Outer.Properties.Average.T)),
				:(_P1.Inner.HeatTransfer.Enth(1) = _P1.InletInner.h),
				:(_P1.Inner.HeatTransfer.Enth(_P1.Npoints) = _P1.OutletInner.h),
				:(_P1.Inner.HeatTransfer.Tlocal(1) = _P1.InletInner.T),
				:(_P1.Inner.HeatTransfer.Tlocal(_P1.Npoints) = _P1.OutletInner.T),
				:(_P1.Inner.PressureDrop.Plocal(1) = _P1.InletInner.P),
				:(_P1.Inner.PressureDrop.Plocal(_P1.Npoints) = _P1.OutletInner.P),
				:(_P1.Outer.HeatTransfer.Enth(_P1.Npoints) = _P1.InletOuter.h),
				:(_P1.Outer.HeatTransfer.Enth(1) = _P1.OutletOuter.h),
				:(_P1.Outer.HeatTransfer.Tlocal(_P1.Npoints) = _P1.InletOuter.T),
				:(_P1.Outer.HeatTransfer.Tlocal(1) = _P1.OutletOuter.T),
				:(_P1.Outer.PressureDrop.Plocal(_P1.Npoints) = _P1.InletOuter.P),
				:(_P1.Outer.PressureDrop.Plocal(1) = _P1.OutletOuter.P),
				:(_P1.Outer.PressureDrop.Pd_fric([1:N]) = (2*_P1.Outer.PressureDrop.fi([1:N])*_P1.Lincr(1+_P1.Npoints-[1:N])*_P1.Outer.Properties.Average.rho([1:N])*_P1.Outer.HeatTransfer.Vmean([1:N])^2)/(_P1.Outer.PressureDrop.Dh*_P1.Outer.HeatTransfer.Phi([1:N]))),
				:(_P1.Outer.PressureDrop.Pd_fric(_P1.Npoints) = 0*"kPa"),
				:(_P1.Inner.PressureDrop.Pd_fric(2:_P1.Npoints) = (2*_P1.Inner.PressureDrop.fi*_P1.Lincr(2:_P1.Npoints)*_P1.Inner.Properties.Average.rho*_P1.Inner.HeatTransfer.Vmean^2)/(_P1.DiInner*_P1.Inner.HeatTransfer.Phi)),
				:(_P1.Inner.PressureDrop.Pd_fric(1) = 0*"kPa"),
			],
			[
				"Energy Balance Outer Stream","Energy Balance Inner Stream","Incremental Duty","Energy Balance Hot Stream","Energy Balance Cold Stream","Incremental Duty","Enthalpy of Inner Side - Inlet Boundary","Enthalpy of inner Side - Outlet Boundary","Temperature of Inner Side - Inlet Boundary","Temperature of Inner Side - Outlet Boundary","Pressure of Inner Side - Inlet Boundary","Pressure of Inner Side - Outlet Boundary","Enthalpy of Outer Side - Inlet Boundary","Enthalpy of Outer Side - Outlet Boundary","Temperature of Outer Side - Inlet Boundary","Temperature of Outer Side - Outlet Boundary","Pressure of Outer Side - Inlet Boundary","Pressure of Outer Side - Outlet Boundary","Outer Pipe Pressure Drop for friction","Outer Pipe Pressure Drop for friction","Inner Pipe Pressure Drop for friction","Inner Pipe Pressure Drop for friction",
			],
			[:PP,:NComp,:Pi,:N,:Npoints,:DoInner,:DiInner,:DiOuter,:Lpipe,:Kwall,:Rfi,:Rfo,],
		)
	end
	_P1::HairpinIncr_basic
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
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export UpperPipe_basic
function setEquationFlow(in::UpperPipe_basic)
	let switch=HotSide
		if HotSide==InletInner.T > InletOuter.T
			set(switch,"inner")
		end
		if HotSide==InletInner.T < InletOuter.T
			set(switch,"outer")
		end
		if switch=="outer"
			addEquation(1)
			addEquation(2)
			addEquation(3)
		elseif switch=="inner"
			addEquation(4)
			addEquation(5)
			addEquation(6)
		end
	end
	addEquation(7)
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
function atributes(in::UpperPipe_basic,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Brief]="Incremental Hairpin Heat Exchanger. "
	fields[:Info]="Incremental approach for Hairpin heat exchanger. "
	drive!(fields,_)
	return fields
end
UpperPipe_basic(_::Dict{Symbol,Any})=begin
	newModel=UpperPipe_basic()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(UpperPipe_basic)
