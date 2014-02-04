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
#*--------------------------------------------------------------------
#* Models to simulate a power plant.
#*--------------------------------------------------------------------
#* Author: Argimiro R. Secchi
#* $Id: power_plant.mso 195 2007-03-07 20:30:12Z arge $
#*-------------------------------------------------------------------
# Declaracao de tipos
type Corrente
	Corrente()=begin
		new(
			VazaoMassica(),
			Pressao(),
			Temperatura(),
			Entropia(),
			Entalpia(),
			[:F,:P,:T,:S,:H,]
		)
	end
	F::VazaoMassica
	P::Pressao
	T::Temperatura
	S::Entropia
	H::Entalpia
	variables::Array{Symbol,1}
end
export Corrente
#Brief="Corrente para conex⭠o entre os equipamentos"
	