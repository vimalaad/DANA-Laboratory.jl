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
type tray
	tray()=begin
		new(
			trayBasic(),
			area ((Symbol=>Any)[
				:Brief=>"Total holes area"
			]),
			length ((Symbol=>Any)[
				:Brief=>"Weir length"
			]),
			acceleration ((Symbol=>Any)[
				:Default=>9.81
			]),
			length ((Symbol=>Any)[
				:Brief=>"Weir height"
			]),
			fraction ((Symbol=>Any)[
				:Brief=>"Aeration fraction"
			]),
			fraction ((Symbol=>Any)[
				:Brief=>"Dry pressure drop coefficient"
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Feehery correlation coefficient",
				:Unit=>"1/m^4",
				:Default=>1
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Elgue correlation coefficient",
				:Unit=>"kg/m/mol^2",
				:Default=>1
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Olsen correlation coefficient",
				:Default=>1
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Number of liquid passes in the tray",
				:Default=>1
			]),
			fill(molweight ((Symbol=>Any)[
				:Brief=>"Component Mol Weight"
			]),(NComp)),
			DanaSwitcher((Symbol=>Any)[
				:Valid=>["on", "off"],
				:Default=>"on"
			]),
			DanaSwitcher((Symbol=>Any)[
				:Valid=>["on", "off"],
				:Default=>"on"
			]),
			DanaSwitcher((Symbol=>Any)[
				:Valid=>["Reepmeyer", "Feehery_Fv", "Roffel_Fv", "Klingberg", "Wang_Fv", "Elgue"],
				:Default=>"Reepmeyer"
			]),
			DanaSwitcher((Symbol=>Any)[
				:Valid=>["default", "Wang_Fl", "Olsen", "Feehery_Fl", "Roffel_Fl"],
				:Default=>"default"
			]),
			dens_mass(),
			dens_mass(),
			[
				:(rhoL = _P1.PP.LiquidDensity(_P1.OutletL.T, _P1.OutletL.P, _P1.OutletL.z)),
				:(rhoV = _P1.PP.VapourDensity(_P1.InletV.T, _P1.InletV.P, _P1.InletV.z)),
				:(_P1.OutletL.F*_P1.vL = 1.84*"1/s"*lw*((_P1.Level-(beta*hw))/(beta))^2),
				:(_P1.OutletL.F*_P1.vL = 1.84*"m^0.5/s"*lw*((_P1.Level-(beta*hw))/(beta))^1.5),
				:(_P1.OutletL.F / "mol/s"= lw*Np*rhoL/sum(Mw*_P1.OutletV.z)/(0.665*fw)^1.5 * ((_P1.ML*sum(Mw*_P1.OutletL.z)/rhoL/_P1.Ap)-hw)^1.5 * "m^0.5/mol"),
				:(_P1.OutletL.F = lw*rhoL/sum(Mw*_P1.OutletL.z) * ((_P1.Level-hw)/750/"mm")^1.5 * "m^2/s"),
				:(_P1.OutletL.F = 2/3*rhoL/sum(Mw*_P1.OutletL.z)*lw*(_P1.ML*sum(Mw*_P1.OutletL.z)/(_P1.Ap*1.3)/rhoL)^1.5*sqrt(2*g/ (2*(1 - 0.3593/"Pa^0.0888545"*(_P1.OutletV.F*sum(Mw*_P1.OutletV.z)/(_P1.Ap*1.3)/sqrt(rhoV))^0.177709)-1))),
				:(_P1.OutletL.F = 0 * "mol/h"),
				:(_P1.InletV.F*_P1.vV = sqrt((_P1.InletV.P - _P1.OutletV.P)/(rhoV*alfa))*Ah),
				:(_P1.InletV.F = rhoV/_P1.Ap/w/sum(Mw*_P1.OutletV.z) * sqrt(((_P1.InletV.P - _P1.OutletV.P)-(rhoV*g*_P1.ML*_P1.vL/_P1.Ap))/rhoV)),
				:(_P1.InletV.F^1.08 * 0.0013 * "kg/m/mol^1.08/s^0.92*1e5" = (_P1.InletV.P - _P1.OutletV.P)*1e5 - (beta*sum(M*Mw)/(_P1.Ap*1.3)*g*1e5) * (rhoV*Ah/sum(Mw*_P1.OutletV.z))^1.08 * "m^1.08/mol^1.08"),
				:(_P1.InletV.F * _P1.vV = _P1.Ap * sqrt(((_P1.InletV.P - _P1.OutletV.P)-rhoL*g*_P1.Level)/rhoV)),
				:(_P1.InletV.F * _P1.vV = _P1.Ap * sqrt(((_P1.InletV.P - _P1.OutletV.P)-rhoL*g*_P1.Level)/rhoV*alfa)),
				:(_P1.InletV.F = sqrt((_P1.InletV.P - _P1.OutletV.P)/btray)),
				:(_P1.InletV.F = 0 * "mol/s"),
			],
			[
				"Liquid Density","Vapour Density","Francis Equation","","","","","Low level","","","","","","","",
			],
			[:Ah,:lw,:g,:hw,:beta,:alfa,:w,:btray,:fw,:Np,:Mw,:VapourFlow,:LiquidFlow,:VapourFlowModel,:LiquidFlowModel,],
			[:rhoL,:rhoV,]
		)
	end
	_P1::trayBasic
	Ah::area 
	lw::length 
	g::acceleration 
	hw::length 
	beta::fraction 
	alfa::fraction 
	w::DanaReal 
	btray::DanaReal 
	fw::DanaReal 
	Np::DanaReal 
	Mw::Array{molweight }
	VapourFlow::DanaSwitcher
	LiquidFlow::DanaSwitcher
	VapourFlowModel::DanaSwitcher
	LiquidFlowModel::DanaSwitcher
	rhoL::dens_mass
	rhoV::dens_mass
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export tray
function set(in::tray)
	Mw = _P1.PP.MolecularWeight()
	 
end
function setEquationFlow(in::tray)
	addEquation(1)
	addEquation(2)
	let switch=LiquidFlow
		if LiquidFlow==Level < (beta * hw)
			set(switch,"off")
		end
		if LiquidFlow==Level > (beta * hw) + 1e-6*"m"
			set(switch,"on")
		end
		if switch=="on"
			let switch=LiquidFlowModel
				if switch=="default"
					addEquation(3)
				elseif switch=="Wang_Fl"
					addEquation(4)
				elseif switch=="Olsen"
					addEquation(5)
				elseif switch=="Feehery_Fl"
					addEquation(6)
				elseif switch=="Roffel_Fl"
					addEquation(7)
				end
			end
		elseif switch=="off"
			addEquation(8)
		end
	end
	let switch=VapourFlow
		if VapourFlow==InletV.F < 1e-6 * "kmol/h"
			set(switch,"off")
		end
		if VapourFlow==InletV.P > OutletV.P + Level*g*rhoL + 1e-1 * "atm"
			set(switch,"on")
		end
		if switch=="on"
			let switch=VapourFlowModel
				if switch=="Reepmeyer"
					addEquation(9)
				elseif switch=="Feehery_Fv"
					addEquation(10)
				elseif switch=="Roffel_Fv"
					addEquation(11)
				elseif switch=="Klingberg"
					addEquation(12)
				elseif switch=="Wang_Fv"
					addEquation(13)
				elseif switch=="Elgue"
					addEquation(14)
				end
			end
		elseif switch=="off"
			addEquation(15)
		end
	end
end
function atributes(in::tray,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Icon]="icon/Tray"
	fields[:Brief]="Complete model of a column tray."
	fields[:Info]="== Specify ==
* the Feed stream
* the Liquid inlet stream
* the Vapour inlet stream
* the Vapour outlet flow (OutletV.F)
	
== Initial ==
* the plate temperature (OutletL.T)
* the liquid height (Level) OR the liquid flow OutletL.F
* (NoComps - 1) OutletL compositions

== Options ==
You can choose the equation for the liquid outlet flow and the vapour
inlet flow calculation through the VapourFlowModel and LiquidFlowModel
switchers.

== References ==
* ELGUE, S.; PRAT, L.; CABASSUD, M.; LANN, J. L.; C虅ZERAC, J. Dynamic models for start-up operations of batch distillation columns with experimental validation. Computers and Chemical Engineering, v. 28, p. 2735-2747, 2004.
* FEEHERY, W. F. Dynamic Optimization with Path Constraints. Tese (Doutorado) - Massachusetts Institute of Technology, June 1998.
* KLINGBERG, A. Modeling and Optimization of Batch Distillation. Disserta袯⭠o (Mestrado) - Department of Automatic Control, Lund Institute of Technology, Lund, Sweden, fev. 2000.
* OLSEN, I.; ENDRESTOL, G. O.; SIRA, T. A rigorous and efficient distillation column model for engineering and training simulators. Computers and Chemical Engineering,v. 21, n. Suppl, p. S193-S198, 1997.
* REEPMEYER, F.; REPKE, J.-U.; WOZNY, G. Analysis of the start-up process for reactive distillation. Chemical Engineering Technology, v. 26, p. 81-86, 2003.
* ROFFEL, B.; BETLEM, B.; RUIJTER, J. de. First principles dynamic modeling and multivariable control of a cryogenic distillation column process. Computers and Chemical Engineering, v. 24, p. 111-123, 2000.
* WANG, L.; LI, P.; WOZNY, G.; WANG, S. A start-up model for simulation of batch distillation starting from a cold state. Computers and Chemical Engineering, v. 27, p.1485-1497, 2003.
"
	drive!(fields,_)
	return fields
end
tray(_::Dict{Symbol,Any})=begin
	newModel=tray()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(tray)
