#-------------------------------------
#* Nonequilibrium Model
#-------------------------------------
type trayRate
	trayRate()=begin
		new(
			trayRateBasic(),
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
			DanaSwitcher((Symbol=>Any)[
				:Valid=>["on", "off"],
				:Default=>"on"
			]),
			DanaSwitcher((Symbol=>Any)[
				:Valid=>["on", "off"],
				:Default=>"on"
			]),
			dens_mass(),
			dens_mass(),
			[
				:(rhoL = _P1.PP.LiquidDensity(_P1.OutletL.T, _P1.OutletL.P, _P1.OutletL.z)),
				:(rhoV = _P1.PP.VapourDensity(_P1.InletV.T, _P1.InletV.P, _P1.InletV.z)),
				:(_P1.OutletL.F*_P1.vL = 1.84*"1/s"*lw*((_P1.Level-(beta*hw))/(beta))^2),
				:(_P1.OutletL.F = 0 * "mol/h"),
				:(_P1.InletV.F*_P1.vV = sqrt((_P1.InletV.P - _P1.OutletV.P)/(rhoV*alfa))*Ah),
				:(_P1.InletV.F = 0 * "mol/s"),
			],
			[
				"Liquid Density","Vapour Density","Francis Equation","Low level","","",
			],
			[:Ah,:lw,:g,:hw,:beta,:alfa,:VapourFlow,:LiquidFlow,],
			[:rhoL,:rhoV,]
		)
	end
	_P1::trayRateBasic
	Ah::area 
	lw::length 
	g::acceleration 
	hw::length 
	beta::fraction 
	alfa::fraction 
	VapourFlow::DanaSwitcher
	LiquidFlow::DanaSwitcher
	rhoL::dens_mass
	rhoV::dens_mass
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export trayRate
function setEquationFlow(in::trayRate)
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
			#		OutletL.F*vL = 1.84*'m^0.5/s'*lw*((Level-(beta*hw))/(beta))^1.5;
			addEquation(3)
		elseif switch=="off"
			addEquation(4)
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
			addEquation(5)
		elseif switch=="off"
			addEquation(6)
		end
	end
end
function atributes(in::trayRate,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=false
	fields[:Icon]="icon/Tray"
	fields[:Brief]="Complete rate model of a column tray."
	fields[:Info]="== Specify ==
* the Feed stream
* the Liquid inlet stream
* the Vapour inlet stream
* the Vapour outlet flow (OutletV.F)
	
== Initial ==
* the plate temperature of both phases (OutletL.T and OutletV.T)
* the liquid height (Level) OR the liquid flow holdup (ML)
* the vapor holdup (MV)
* (NoComps - 1) OutletL compositions
"
	drive!(fields,_)
	return fields
end
trayRate(_::Dict{Symbol,Any})=begin
	newModel=trayRate()
	newModel.attributes=atributes(newModel,_)
	newModel
end
addnamestoinventory(trayRate)
