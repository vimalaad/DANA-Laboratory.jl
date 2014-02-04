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
#* Author: Tiago Os򱨯rio
#* $Id$
#*-------------------------------------------------------------------
type PIDIncr
	PIDIncr()=begin
		[
			:(Ports.output = Parameters.bias),
			:(diff(Internal.dFilt) = 0/"s^2"),
			:(diff(Internal.inputFilt)=0/"s"),
			:(diff(Internal.setPointFilt)=0/"s"),
		],
		[
			"","","","",
		],
		new(
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Type of PID Incremental",
				:Valid=>["Ideal","Parallel","Series","Ideal_AWBT","Parallel_AWBT","Series_AWBT","Ideal_AW","Parallel_AW","Series_AW"],
				:Default=>"Ideal"
			]),
			MParameters(),
			MOptions(),
			MInternal_Variables(),
			MPorts(),
			DanaReal ((Symbol=>Any)[
				:Brief=>"Integral term multiplier used in anti-reset windup"
			]),
			[
				:((Parameters.tau + 1e-3*"s")*diff(Internal.inputFilt)= Ports.input - Internal.inputFilt),
				:(Parameters.tau*diff(Internal.inputFilt)= Ports.input - Internal.inputFilt),
				:((Parameters.tauSet + 1e-3*"s")*diff(Internal.setPointFilt)= Ports.setPoint - Internal.setPointFilt),
				:(Parameters.tauSet*diff(Internal.setPointFilt)= Ports.setPoint - Internal.setPointFilt),
				:(Internal.error*"s" = Internal.inputFilt*(Parameters.beta-1.0)),
				:(Internal.errorD*"s"= Internal.inputFilt*(Parameters.gamma-1.0)),
				:(Internal.errorI= 0),
				:(Internal.error = Parameters.beta*diff(Internal.setPointFilt) - diff(Internal.inputFilt)),
				:(Internal.errorD = Parameters.gamma*diff(Internal.setPointFilt) - diff(Internal.inputFilt)),
				:(Internal.errorI = Internal.setPointFilt-Internal.inputFilt),
				:(Internal.dpropTerm=Internal.error),
				:(Parameters.alpha*(Parameters.derivTime + 1e-3*"s")*diff(Internal.dFilt) = Internal.errorD - Internal.dFilt),
				:(Parameters.alpha*(Parameters.derivTime)*diff(Internal.dFilt) = Internal.errorD - Internal.dFilt),
				:(Internal.dderivTerm = Parameters.derivTime*diff(Internal.dFilt)),
				:(diff(Internal.outp)=Internal.doutp),
				:(Internal.outps=2*Internal.outp-1),
				:(Ports.output=(sign(Internal.outps)*1+1)/2),
				:(Ports.output=Internal.outp),
				:(Ports.output=Internal.outp),
				:(Parameters.intTime*Internal.dintTerm = Internal.errorI),
				:(Internal.doutp = Options.action*Parameters.gain*(Internal.dpropTerm + Internal.dintTerm + Internal.dderivTerm)),
				:(AWFactor=1),
				:(Parameters.intTime*Internal.dintTerm = Internal.errorI),
				:(Internal.doutp = Options.action*(Parameters.gain*Internal.dpropTerm + Internal.dintTerm + Internal.dderivTerm)),
				:(AWFactor=1),
				:(Parameters.intTime*Internal.dintTerm = Internal.errorI),
				:(Internal.doutp = Options.action*(Parameters.gain*(Internal.dpropTerm + Internal.dintTerm)*(1/"s" + Internal.dderivTerm)*"s")),
				:(AWFactor=1),
				:(Options.action*Parameters.gain*(Parameters.intTime*Internal.dintTerm-Internal.errorI) = Ports.output-Internal.outp),
				:(Internal.doutp = Options.action*Parameters.gain*(Internal.dpropTerm + Internal.dintTerm + Internal.dderivTerm)),
				:(AWFactor=1),
				:(Options.action*Parameters.gain*(Parameters.intTime*Internal.dintTerm-Internal.errorI) = Ports.output-Internal.outp),
				:(Internal.doutp = Options.action*(Parameters.gain*Internal.dpropTerm + Internal.dintTerm + Internal.dderivTerm)),
				:(AWFactor=1),
				:(Options.action*Parameters.gain*(Parameters.intTime*Internal.dintTerm-Internal.errorI) = Ports.output-Internal.outp),
				:(Internal.doutp = Options.action*(Parameters.gain*(Internal.dpropTerm + Internal.dintTerm)*(1/"s" + Internal.dderivTerm)*"s")),
				:(AWFactor=1),
				:(Parameters.intTime*Internal.dintTerm = AWFactor*Internal.errorI),
				:(Internal.doutp = Options.action*Parameters.gain*(Internal.dpropTerm + Internal.dintTerm + Internal.dderivTerm)),
				:(AWFactor=-tanh(sign(Internal.outps)*Internal.outps*100-102)),
				:(AWFactor=1),
				:(Parameters.intTime*Internal.dintTerm = AWFactor*Internal.errorI),
				:(Internal.doutp = Options.action*(Parameters.gain*Internal.dpropTerm + Internal.dintTerm + Internal.dderivTerm)),
				:(AWFactor=-tanh(sign(Internal.outps)*Internal.outps*100-102)),
				:(AWFactor=1),
				:(Parameters.intTime*Internal.dintTerm = AWFactor*Internal.errorI),
				:(Internal.doutp = Options.action*(Parameters.gain*(Internal.dpropTerm + Internal.dintTerm)*(1/"s" + Internal.dderivTerm)*"s")),
				:(AWFactor=-tanh(sign(Internal.outps)*Internal.outps*100-102)),
				:(AWFactor=1),
			],
			[
				"Input first order filter","Input first order filter","setPoint first order filter","setPoint first order filter","Error definition for proportional term","Error definition for derivative term","Error definition for integral term","Error definition for proportional term","Error definition for derivative term","Error definition for integral term","Calculate proportional term","Derivative term filter","Derivative term filter","Calculate derivative term","Unscaled output","Scale outp","Calculate clipped output when it�s saturated","Calculate clipped output when it�s not saturated","Calculate unclipped output","Calculate integral term","Sum of proportional, integral and derivative terms","Calculate AWFactor - Not in use in this mode","Calculate integral term","Sum of proportional, integral and derivative terms","Calculate AWFactor - Not in use in this mode","Calculate integral term","Sum of proportional, integral and derivative terms","Calculate AWFactor - Not in use in this mode","Calculate integral term with anti-windup and bumpless transfer","Sum of proportional, integral and derivative terms","Calculate AWFactor - Not in use in this mode","Calculate integral term with anti-windup and bumpless transfer","Sum of proportional, integral and derivative terms","Calculate AWFactor - Not in use in this mode","Calculate integral term with anti-windup and bumpless transfer","Sum of proportional, integral and derivative terms","Calculate AWFactor - Not in use in this mode","Calculate integral term with anti-windup","Sum of proportional, integral and derivative terms","Calculate AWFactor","Calculate AWFactor","Calculate integral term with anti-windup","Sum of proportional, integral and derivative terms","Calculate AWFactor","Calculate AWFactor","Calculate integral term with anti-windup","Sum of proportional, integral and derivative terms","Calculate AWFactor","Calculate AWFactor",
			],
			[:PID_Select,],
			[:Parameters,:Options,:Internal,:Ports,:AWFactor,]
		)
	end
	PID_Select::DanaSwitcher 
	Parameters::MParameters
	Options::MOptions
	Internal::MInternal_Variables
	Ports::MPorts
	AWFactor::DanaReal 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	initials::Array{Expr,1}
	initialNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export PIDIncr
function setEquationFlow(in::PIDIncr)
	if (Parameters.tau == 0) 
		addEquation(1)
	else
		addEquation(2)
	end
	if (Parameters.tauSet == 0) 
		addEquation(3)
	else
		addEquation(4)
	end
	if Options.autoMan == 1 
		addEquation(5)
		addEquation(6)
		addEquation(7)
	else
		addEquation(8)
		addEquation(9)
		addEquation(10)
	end
	addEquation(11)
	if (Parameters.derivTime == 0) 
		addEquation(12)
	else
		addEquation(13)
	end
	addEquation(14)
	addEquation(15)
	addEquation(16)
	if Options.clip == 1 
		if abs(Internal.outps)>1 
			addEquation(17)
		else
			addEquation(18)
		end
	else
		addEquation(19)
	end
	let switch=PID_Select
		if switch=="Ideal"
			addEquation(20)
			addEquation(21)
			addEquation(22)
		elseif switch=="Parallel"
			addEquation(23)
			addEquation(24)
			addEquation(25)
		elseif switch=="Series"
			addEquation(26)
			addEquation(27)
			addEquation(28)
		elseif switch=="Ideal_AWBT"
			addEquation(29)
			addEquation(30)
			addEquation(31)
		elseif switch=="Parallel_AWBT"
			addEquation(32)
			addEquation(33)
			addEquation(34)
		elseif switch=="Series_AWBT"
			addEquation(35)
			addEquation(36)
			addEquation(37)
		elseif switch=="Ideal_AW"
			addEquation(38)
			addEquation(39)
			if abs(Internal.outps)>1 && (Options.action*sign(Internal.outps)*Internal.errorI)>0 
				addEquation(40)
			else
				addEquation(41)
			end
		elseif switch=="Parallel_AW"
			addEquation(42)
			addEquation(43)
			if abs(Internal.outps)>1 && (Options.action*sign(Internal.outps)*Internal.errorI)>0 
				addEquation(44)
			else
				addEquation(45)
			end
		elseif switch=="Series_AW"
			addEquation(46)
			addEquation(47)
			if abs(Internal.outps)>1 && (Options.action*sign(Internal.outps)*Internal.errorI)>0 
				addEquation(48)
			else
				addEquation(49)
			end
		end
	end
end
function initial(in::PIDIncr)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
end
function atributes(in::PIDIncr,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/PIDIncr"
	fields[:Brief]="Model of incremental PIDs."
	fields[:Info]="== Inputs ==
* scaled processs variable.
* scaled bias.
* scaled setpoint.

== Outputs ==
* a scaled output.
"
	drive!(fields,_)
	return fields
end
PIDIncr(_::Dict{Symbol,Any})=begin
	newModel=PIDIncr()
	newModel.attributes=atributes(newModel,_)
	newModel
end
