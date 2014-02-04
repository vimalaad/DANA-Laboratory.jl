#-------------------------------------------------------------------
#* Model of a valve (simplified)
#*-------------------------------------------------------------------- 
#*
#* Author: Paula B. Staudt
#*--------------------------------------------------------------------
type valve_simplified
	valve_simplified()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin((Symbol=>Any)[
				:Type=>"PP"
			]),
			DanaInteger(),
			stream ((Symbol=>Any)[
				:Brief=>"Inlet stream",
				:PosX=>0,
				:PosY=>0.7365,
				:Symbol=>"_{in}"
			]),
			streamPH ((Symbol=>Any)[
				:Brief=>"Outlet stream",
				:PosX=>1,
				:PosY=>0.7365,
				:Symbol=>"_{out}"
			]),
			fraction ((Symbol=>Any)[
				:Brief=>"Plug Position"
			]),
			dens_mass ((Symbol=>Any)[
				:Brief=>"Fluid Density",
				:Default=>1e3
			]),
			vol_mol ((Symbol=>Any)[
				:Brief=>"Specific volume",
				:Default=>1e3
			]),
			press_delta ((Symbol=>Any)[
				:Brief=>"Pressure Drop",
				:DisplayUnit=>"kPa",
				:Symbol=>"\\Delta P"
			]),
			positive ((Symbol=>Any)[
				:Brief=>"Pressure Ratio",
				:Symbol=>"P_{ratio}"
			]),
			dens_mass ((Symbol=>Any)[
				:Brief=>"Reference Density",
				:Default=>1e4
			]),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Valve Constant",
				:Unit=>"gal/min/psi^0.5"
			]),
			[
				:(Inlet.F = Outlet.F),
				:(Inlet.z = Outlet.z),
				:(Inlet.h = Outlet.h),
				:(Outlet.P = Inlet.P - Pdrop),
				:(Outlet.P = Inlet.P * Pratio),
				:(rho = Inlet.v*PP.VapourDensity((Inlet.T+Outlet.T)/2, (Inlet.P+Outlet.P)/2, Outlet.z) + (1-Inlet.v)*PP.LiquidDensity((Inlet.T+Outlet.T)/2, (Inlet.P+Outlet.P)/2, Outlet.z)),
				:(v = Inlet.v*PP.VapourVolume((Inlet.T+Outlet.T)/2, (Inlet.P+Outlet.P)/2, Outlet.z) + (1-Inlet.v)*PP.LiquidVolume((Inlet.T+Outlet.T)/2, (Inlet.P+Outlet.P)/2, Outlet.z)),
				:(Outlet.F * v = k*x*sqrt(Pdrop * rho_ref / rho )),
				:(Outlet.F = 0 * "kmol/h"),
			],
			[
				"Overall Molar Balance","Componente Molar Balance","Energy Balance","Pressure Drop","Pressure Ratio","Density","Volume","Flow","Closed",
			],
			[:PP,:NComp,:rho_ref,:k,],
			[:Inlet,:Outlet,:x,:rho,:v,:Pdrop,:Pratio,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	Inlet::stream 
	Outlet::streamPH 
	x::fraction 
	rho::dens_mass 
	v::vol_mol 
	Pdrop::press_delta 
	Pratio::positive 
	rho_ref::dens_mass 
	k::DanaReal 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export valve_simplified
function setEquationFlow(in::valve_simplified)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
	addEquation(7)
	if Pdrop > 0 
		addEquation(8)
	else
		addEquation(9)
	end
end
function atributes(in::valve_simplified,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/Valve"
	fields[:Brief]="Model of a very simple valve - used in distillation column models."
	fields[:Info]="== Assumptions ==
* no flashing liquid in the valve;
* the flow in the valve is adiabatic;
* dynamics in the valve are neglected;
* linear flow type.
	
== Specify ==
* the inlet stream
* the plug position (x) OR outlet temperature (Outlet.T) OR outlet pressure (Outlet.P) 
	
	OR		
	
* the inlet stream excluding its flow (Inlet.F)
* the outlet pressure (Outlet.P) OR outlet flow (Outlet.F)
* the plug position (x)
"
	drive!(fields,_)
	return fields
end
valve_simplified(_::Dict{Symbol,Any})=begin
	newModel=valve_simplified()
	newModel.attributes=atributes(newModel,_)
	newModel
end
