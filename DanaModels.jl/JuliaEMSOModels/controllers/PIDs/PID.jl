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
type PID
	PID()=begin
		[
			:(Internal.intTerm = 0),
			:(diff(Internal.dFilt) = 0/"s"),
			:(diff(Internal.inputFilt) = 0/"s"),
			:(diff(Internal.setPointFilt) = 0/"s"),
		],
		[
			"","","","",
		],
		new(
			DanaSwitcher ((Symbol=>Any)[
				:Brief=>"Type of PID",
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
				:(Internal.error = Internal.inputFilt*(Parameters.beta-1.0)),
				:(Internal.errorD= Internal.inputFilt*(Parameters.gamma-1.0)),
				:(Internal.errorI= 0),
				:(Internal.error = Parameters.beta*Internal.setPointFilt - Internal.inputFilt),
				:(Internal.errorD = Parameters.gamma*Internal.setPointFilt - Internal.inputFilt),
				:(Internal.errorI = Internal.setPointFilt-Internal.inputFilt),
				:(Internal.propTerm=Internal.error),
				:(Parameters.alpha*(Parameters.derivTime + 1e-3*"s")*diff(Internal.dFilt) = Internal.errorD - Internal.dFilt),
				:(Parameters.alpha*(Parameters.derivTime)*diff(Internal.dFilt) = Internal.errorD - Internal.dFilt),
				:(Internal.derivTerm = Parameters.derivTime*diff(Internal.dFilt)),
				:(Internal.outps=2*Internal.outp-1),
				:(Ports.output=(sign(Internal.outps)*1+1)/2),
				:(Ports.output=Internal.outp),
				:(Ports.output=Internal.outp),
				:(Parameters.intTime*diff(Internal.intTerm) = AWFactor*Internal.errorI),
				:(Internal.outp = Parameters.bias + Options.action*Parameters.gain*(Internal.propTerm + Internal.intTerm + Internal.derivTerm)),
				:(AWFactor=-tanh(sign(Internal.outps)*Internal.outps*100-102)),
				:(AWFactor=1),
				:(Parameters.intTime*diff(Internal.intTerm) = AWFactor*Internal.errorI),
				:(Internal.outp = Parameters.bias + Options.action*(Parameters.gain*Internal.propTerm + Internal.intTerm + Internal.derivTerm)),
				:(AWFactor=-tanh(sign(Internal.outps)*Internal.outps*100-102)),
				:(AWFactor=1),
				:(Parameters.intTime*diff(Internal.intTerm) = AWFactor*Internal.errorI),
				:(Internal.outp = Parameters.bias + Options.action*(Parameters.gain*(Internal.propTerm + Internal.intTerm)*(1 + Internal.derivTerm))),
				:(AWFactor=-tanh(sign(Internal.outps)*Internal.outps*100-102)),
				:(AWFactor=1),
				:(Parameters.intTime*diff(Internal.intTerm) = Internal.errorI),
				:(Internal.outp = Parameters.bias + Options.action*Parameters.gain*(Internal.propTerm + Internal.intTerm + Internal.derivTerm)),
				:(AWFactor=1),
				:(Parameters.intTime*diff(Internal.intTerm) = Internal.errorI),
				:(Internal.outp = Parameters.bias + Options.action*(Parameters.gain*Internal.propTerm + Internal.intTerm + Internal.derivTerm)),
				:(AWFactor=1),
				:(Parameters.intTime*diff(Internal.intTerm) = Internal.errorI),
				:(Internal.outp = Parameters.bias + Options.action*(Parameters.gain*(Internal.propTerm + Internal.intTerm)*(1 + Internal.derivTerm))),
				:(AWFactor=1),
				:(Options.action*Parameters.gain*(Parameters.intTime*diff(Internal.intTerm)-Internal.errorI) = Ports.output-Internal.outp),
				:(Internal.outp = Parameters.bias + Options.action*Parameters.gain*(Internal.propTerm + Internal.intTerm + Internal.derivTerm)),
				:(AWFactor=1),
				:(Options.action*Parameters.gain*(Parameters.intTime*diff(Internal.intTerm)-Internal.errorI) = Ports.output-Internal.outp),
				:(Internal.outp = Parameters.bias + Options.action*(Parameters.gain*Internal.propTerm + Internal.intTerm + Internal.derivTerm)),
				:(AWFactor=1),
				:(Options.action*Parameters.gain*(Parameters.intTime*diff(Internal.intTerm)-Internal.errorI) = Ports.output-Internal.outp),
				:(Internal.outp = Parameters.bias + Options.action*(Parameters.gain*(Internal.propTerm + Internal.intTerm)*(1 + Internal.derivTerm))),
				:(AWFactor=1),
			],
			[
				"Input first order filter","Input first order filter","setPoint first order filter","setPoint first order filter","Error definition for proportional term","Error definition for derivative term","Error definition for integral term","Error definition for proportional term","Error definition for derivative term","Error definition for integral term","Calculate proportional term","Derivative term filter","Derivative term filter","Calculate derivative term","Scale outp","Calculate clipped output when it�s saturated","Calculate clipped output when it�s not saturated","Calculate unclipped output","Calculate integral term with anti-windup","Sum of proportional, integral and derivative terms","Calculate AWFactor","Calculate AWFactor","Calculate integral term with anti-windup","Sum of proportional, integral and derivative terms","Calculate AWFactor","Calculate AWFactor","Calculate integral term with anti-windup","Sum of proportional, integral and derivative terms","Calculate AWFactor","Calculate AWFactor","Calculate integral term","Sum of proportional, integral and derivative terms","Calculate AWFactor - Not in use in this mode","Calculate integral term","Sum of proportional, integral and derivative terms","Calculate AWFactor - Not in use in this mode","Calculate integral term","Sum of proportional, integral and derivative terms","Calculate AWFactor - Not in use in this mode","Calculate integral term with anti-windup and bumpless transfer","Sum of proportional, integral and derivative terms","Calculate AWFactor - Not in use in this mode","Calculate integral term with anti-windup and bumpless transfer","Sum of proportional, integral and derivative terms","Calculate AWFactor - Not in use in this mode","Calculate integral term with anti-windup and bumpless transfer","Sum of proportional, integral and derivative terms","Calculate AWFactor - Not in use in this mode",
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
	initials::Array{Expr,1}
	initialNames::Array{String,1}
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export PID
function initial(in::PID)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
end
function setEquationFlow(in::PID)
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
	if Options.clip == 1 
		if abs(Internal.outps)>1 
			addEquation(16)
		else
			addEquation(17)
		end
	else
		addEquation(18)
	end
	let switch=PID_Select
		if switch=="Ideal_AW"
			addEquation(19)
			addEquation(20)
			if abs(Internal.outps)>1 && (Options.action*sign(Internal.outps)*Internal.errorI)>0 
				addEquation(21)
			else
				addEquation(22)
			end
		elseif switch=="Parallel_AW"
			addEquation(23)
			addEquation(24)
			if abs(Internal.outps)>1 && (Options.action*sign(Internal.outps)*Internal.errorI)>0 
				addEquation(25)
			else
				addEquation(26)
			end
		elseif switch=="Series_AW"
			addEquation(27)
			addEquation(28)
			if abs(Internal.outps)>1 && (Options.action*sign(Internal.outps)*Internal.errorI)>0 
				addEquation(29)
			else
				addEquation(30)
			end
		elseif switch=="Ideal"
			addEquation(31)
			addEquation(32)
			addEquation(33)
		elseif switch=="Parallel"
			addEquation(34)
			addEquation(35)
			addEquation(36)
		elseif switch=="Series"
			addEquation(37)
			addEquation(38)
			addEquation(39)
		elseif switch=="Ideal_AWBT"
			addEquation(40)
			addEquation(41)
			addEquation(42)
		elseif switch=="Parallel_AWBT"
			addEquation(43)
			addEquation(44)
			addEquation(45)
		elseif switch=="Series_AWBT"
			addEquation(46)
			addEquation(47)
			addEquation(48)
		end
	end
end
function atributes(in::PID,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=(Symbol=>Any)[]
	fields[:Pallete]=true
	fields[:Icon]="icon/PID"
	fields[:Brief]="Model of PIDs."
	fields[:Info]="== Inputs ==
* scaled processs variable.
* scaled bias.
* scaled setpoint.

== Outputs ==
* scaled output.
"
	drive!(fields,_)
	return fields
end
PID(_::Dict{Symbol,Any})=begin
	newModel=PID()
	newModel.attributes=atributes(newModel,_)
	newModel
end
