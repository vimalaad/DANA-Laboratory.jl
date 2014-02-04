# REF[1] Chemical Process Design and Integration ,By:Robin Smith ,Copyright 2005
# REF[2] dwsim3\DWSIM\Objects\PropertyPackages\PengRobinson\Helper Classes\PR.vb
# REF[3] CODATA Recommended Values of the Fundamental Physical Constants: 2006, http://physics.nist.gov
# REF[4] Perry handbook ED8
module PengRobinson

  type PR
    n::Int32 # Number of components
    TSet::Bool
    PSet::Bool
    initialized::Bool
    ZCalced::Bool
    bml::Float64
    T::Float64
    P::Float64
    aml::Float64
    AG::Float64
    BG::Float64

    Tc::Array{Float64,1}
    Pc::Array{Float64,1}
    W::Array{Float64,1}
    Vx::Array{Float64,1}
    bi::Array{Float64,1}
    ci::Array{Float64,1}
    ai::Array{Float64,1}
    aml2::Array{Float64,1}
    compressibilityFactor::Array{Float64,1}

    VKij::Array{Float64,2}
    a::Array{Float64,2}

    PR(n)=new(n,false,false,false,false,0.0,0.0,0.0,0.0,0.0,0.0,zeros(n),zeros(n),zeros(n),zeros(n),zeros(n),zeros(n),zeros(n),zeros(n),zeros(n),zeros(n,n),zeros(n,n))
  end
  
	const R = 8.3144621 # REF[3]
	const epsilon = 0.0001 

  function Equation(parameters ,variables)
    eq = :(P*V-Z*R*T)
    for i = 1:length(eq.args)
      if haskey(parameters,eq.args[i])
        print(parameters[eq.args[i]])
      else
        print(eq.args[i])
        print('\n')
      end
    end
  end

	function Initialize(Tc_::Array{Float64,1}, Pc_::Array{Float64,1}, Vx_::Array{Float64,1}, W_::Array{Float64,1})
    this::PR = PR(length(Vx_))
		this.Tc = Tc_
		this.Pc = Pc_
		this.Vx = Vx_
		this.W = W_

		i = 1
		while i <= this.n
			this.bi[i] = 0.0778 * R * this.Tc[i] / this.Pc[i]
			this.ci[i] = 0.37464 + 1.54226 * this.W[i] - 0.26992 * this.W[i]^2 #4use in ZtoMinG
			this.bml += this.Vx[i] * this.bi[i]
			i = i+1
    end
		this.initialized = true
    return this
	end

	function setT!(this::PR, T_::Float64, VKij_::Array{Float64,2})
		if !this.initialized
      return 0
    end
		this.ZCalced = false
		this.PSet = false
		
		this.T = T_
    alpha = zeros(this.n)
		i = 1
		j = 1
		while i <= this.n
			k = 0.37464 + 1.54226 * this.W[i] - 0.26992 * this.W[i]^2
			alpha[i] = (1 + k * (1 - ((this.T / this.Tc[i])^0.5)))^2
			this.ai[i] = 0.45724 * alpha[i] * (R * this.Tc[i])^ 2 / this.Pc[i]
			i = i+1
		end 
		i = 1
		this.aml = 0
		while i<=this.n
			this.aml2[i] = 0
			j = 1
			while j<=this.n
        this.a[j,i] = (this.ai[i] * this.ai[j])^0.5 * (1 - this.VKij[i,j])
				this.aml += this.Vx[i] * this.Vx[j] * this.a[j,i]
				this.aml2[i] += this.Vx[j] * this.a[j,i] # 4use in CalcLNFug
				j = j + 1
			end
			i = i+1
		end
  
		this.TSet = true
    return this
	end

	function setP!(this::PR, P_::Float64) 
		if( ! this.TSet )
       return 0
    end
		this.P = P_
		this.AG = this.aml * this.P / (R * this.T)^2
		this.BG = this.bml * this.P / (R * this.T)
		this.PSet = true
    return this
	end

	function CalcZ(this::PR) 
		if !(this.PSet && this.TSet)
			return 0
    end
		local delta = -this.AG * this.BG + this.BG^2 + this.BG^3
		local gama = this.AG - 3 * this.BG^2 - 2 * this.BG
		local beta = this.BG - 1

		local Z = CalcRoots(beta,gama,delta)
		
		this.compressibilityFactor = Z

		this.ZCalced = true
		return Z
	end
	
	function CalcRoots(beta::Float64, gama::Float64, delta::Float64) #REF: Chemical Process Design and Integration /p84
    local roots_ = zeros(3)
		local roots = zeros(2)
		local q = (beta^2-3*gama)/9
		local r = (2*beta^3-9*beta*gama+27*delta)/54
 		if q^3-r^2 >= 0 # 3 roots
      local teta = acos(r/(q^(3.0/2.0)))
			roots_[1] = cos(teta/3)
			roots_[2] = cos((teta + 2*pi)/3)
			roots_[3] = cos((teta + 4*pi)/3)
			roots[1] = -2*(q^0.5)*min(roots_)-beta/3
			roots[2] = -2*(q^0.5)*max(roots_)-beta/3
    else # 1 root
      local tmp = sqrt(r^2-q^3)+abs(r)^(1.0/3.0)
			roots[1]=roots[2]=-1*sign(r)*(tmp+q/tmp)-beta/3
		end
		return roots
	end

  #CalcLnFug , CalcEnthalpy , CalcEntropy , CalcGibbsEnergy , CalcHelmoltzEnergy
	function CalcLnFug(this::PR , forcephase::Char )
		if ! ZCalced
      return 0
    end
		LN_CF = zeros(this.n)
		Z = 0.0
		if (forcephase != null && forcephase.length() > 0)
			if (forcephase.equals("L"))
				if (this.compressibilityFactor.length > 0)
					Z = this.compressibilityFactor[0]
				else
					Z = this.FindZ_ByRho()
        end
      else 
        if (forcephase.equals("V"))
          if (this.compressibilityFactor.length > 0)
            Z = this.compressibilityFactor[1]
          else
            Z = this.FindZ_ByRho()
          end
        end
      end
		else
			Z = this.compressibilityFactor[1]
		end
		i = 1
		while i<=this.n
			t1 = this.bi[i] * (Z - 1) / this.bml
			t2 = -log(Z - this.BG)
			t3 = AG * (2 * aml2[i] / this.aml - this.bi[i] / this.bml)
			t4 = log((Z + (1 + (2^0.5)) * this.BG) / (Z + (1 - 2^0.5 * this.BG)))
			t5 = 2 * ((2^0.5) * this.BG)
			LN_CF[i] = t1 + t2 - (t3 * t4 / t5)
			LN_CF[i] = LN_CF[i]
			i += 1
		end 
		return LN_CF
	end

	function CalcEnthalpy(this::PR, phasetype::Char, Hid::Float64) 
		if !this.ZCalced 
			return 0
    end
		local Z = 0.0
		if phasetype=='L'
			Z = this.compressibilityFactor[1]
    end
		if phasetype=='V'
			Z = this.compressibilityFactor[2]
    end
		return Hid + DHres(Z)
	end

	function CalcEntropy(this::PR, phasetype::Char, Sid::Float64) 
		if !this.ZCalced
			return 0
    end
		local Z = 0.0
		if phasetype=='L'
			Z = this.compressibilityFactor[1]
    end
		if phasetype=='V'
			Z = this.compressibilityFactor[2]
    end
		return Sid + DSres(Z)
	end

	function CalcGibbsEnergy(this::PR, phasetype::Char, Gid::Float64) 
		if ( !this.ZCalced )
			return 0
    end
		local Z = 0.0
		if phasetype=='L'
			Z = this.compressibilityFactor[1]
    end
		if phasetype=='V'
			Z = this.compressibilityFactor[2]
    end
    return Gid + (DHres(Z) - T * DSres(Z))
	end

	function CalcHelmoltzEnergy(this::PR, phasetype::Char, Aid::Float64) 
		if !this.ZCalced
			return 0
    end
		local Z = 0.0
		if phasetype=='L'
			Z = this.compressibilityFactor[0]
    end
		if phasetype=='V'
			Z = this.compressibilityFactor[1]
    end
		return Aid + DAres(Z)
	end

  function DHres(this::PR, Z::Float64)
    DAres(this, Z) + this.T * DSres(this, Z) + R * this.T * (Z - 1)
  end
	
	function DAres(this::PR, Z::Float64)
		V = (Z * R * this.T / this.P) # m3/mol
		return this.aml / (this.bml * ((2^(2 - 4 * -1))^ 0.5)) * log((2 * Z + this.BG * (2 - ((2^(2 - 4 * -1)))^ 0.5)) / (2 * Z + this.BG * (2 + ((2^(2 - 4 * -1)))^0.5))) - R * T * log((Z - this.BG) / Z) - R * this.T * log(V * 101325 / (R * 298.15))
  end

	function DSres( this::PR, Z::Float64 )
		aux1::Float64 = -R / 2 * (0.45724 / this.T)^ 0.5
		i = 1
		j = 1
		aux2 = 0.0
		while i<=this.n
			j = 1
			while j<=this.n
				aux2 += this.Vx[i] * this.Vx[j] * (1 - this.VKij[i,j]) * (this.ci[j] * (((this.ai[i] * this.Tc[j] / this.Pc[j]))^(0.5 + this.ci[i] * (((this.ai[j] * this.Tc[i] / this.Pc[i]))^(0.5)))))
				j = j + 1
			end
			i = i + 1
		end 

		dadT = (aux1 * aux2)
		return R * log((Z - this.BG) / Z) + R * log(Z) - 1 / ((8)^(0.5 * this.bml)) * dadT * log((2 * Z + this.BG * ((2 - 8)^(0.5))) / (2 * Z + this.BG * (2 + ((8)^(0.5)))))
	end
  
	function PhaseType( phase::Char ) 
		if ( ! ZCalced )
      return 0
    end  
		local beta = 0.0
		local Z = 0.0
		local retPos::Int = 0
		ZtoMinG(retPos)
		Z = this.compressibilityFactor[retPos]
		local BG2 = this.BG^2
		beta = 1 / this.P * (1 - (this.BG * Z^2 + this.AG * Z - 6 * BG2 * Z - 2 * this.BG * Z - 2 * this.AG * this.BG + 2 * BG2 + 2 * this.BG) / (Z * (3 * Z^2 - 2 * Z + 2 * this.BG * Z + this.AG - 3 * BG2 - 2 * this.BG)))
		phase = 'U'

		#If beta < 0.005 / 101322 Then phase = "L" Else phase = "V"
		#If beta > 0.9 / P And beta < 3 / P Then phase = "V" Else phase = "L"
		if Z < 0.302
			phase = 'L'
		else
			phase = 'V'
		end
		return beta
	end

  function ZtoMinG!(this::PR, retPos::Int32)
		i = 1
		j = 1
		k = 1
		l = 1
		G = zeros(this.n)
		for Z in this.compressibilityFactor
			H = DHres(this, Z)

			S = 0.0#DSres(this, Z)

			G[l] = H - this.T * S

			if (j == 1)
				k = 1
			else
				i = 1
				while i <= this.n
					if (G[l] <= G[k])
						k = l
          end
					i = i + 1
				end
			end
			l = l + 1
		end
		retPos = k
		return G[k]
	end
  
	function FindZ_ByRho()
		local aa = 0.0
		local bb = 0.0
		local P_lim = 0.0
		local rho_lim = 0.0
		local rho_calc = 0.0
		local rho_x = 0.0
		local rho_mc = 0.0
		rho_lim = ESTIMAR_RhoLim(aml, bml, T, P)
		P_lim = R * T * rho_lim / (1 - rho_lim * bml) - aml * (rho_lim^(2 / (1 + 2 * bml * rho_lim - (rho_lim * bml)^2)))
		rho_x = (rho_lim + rho_mc) / 2
		bb = 1 / P_lim * (1 / (rho_lim * (1 - rho_lim / rho_x)))
		aa = -bb / rho_x
		rho_calc = (1 / P + bb) / aa
		return P / (rho_calc * R * T)
	end
  
	function ESTIMAR_RhoLim(this::PR, am::Float64, bm::Float64, T::Float64, P::Float64)
		local i = 0

		local rinf = 0.0
		local rsup = this.P / (R * this.T)

		local fr = 0.0
		local fr_inf = 0.0
		local nsub = 10.0
		local delta_r = 0.0

		delta_r = (rsup - rinf) / nsub
		while !(fr * fr_inf < 0 || i == 11)
			i = i + 1
			fr = OF_Rho(rinf, am, bm, T)
			rinf = rinf + delta_r
			fr_inf = OF_Rho(rinf, am, bm, T)
		end 
		if (i == 11)
			return -100
		end
		rsup = rinf
		rinf = rinf - delta_r

		local aaa = 0.0
		local bbb = 0.0
		local ccc = 0.0
		local ddd = 0.0
		local eee = 0.0
		local min11 = 0.0
		local min22 = 0.0
		local faa = 0.0
		local fbb = 0.0
		local fcc = 0.0
		local ppp = 0.0
		local qqq = 0.0
		local rrr = 0.0
		local sss = 0.0
		local tol11 = 0.0
		local xmm = 0.0
		local ITMAX2 = 100
		local iter2 = 0

		aaa = rinf
		bbb = rsup
		ccc = rsup

		faa = OF_Rho(aaa, am, bm, T)
		fbb = OF_Rho(bbb, am, bm, T)
		fcc = fbb

		iter2 = 0
		while !(iter2 == ITMAX2)
			if ((fbb > 0 && fcc > 0) || (fbb < 0 && fcc < 0))
				ccc = aaa
				fcc = faa
				ddd = bbb - aaa
				eee = ddd
			end
			if (abs(fcc) < abs(fbb))
				aaa = bbb
				bbb = ccc
				ccc = aaa
				faa = fbb
				fbb = fcc
				fcc = faa
			end
			tol11 = 0.000001
			xmm = 0.5 * (ccc - bbb)
			if (abs(xmm) <= tol11) | (fbb == 0)
				return bbb
			end
			if (abs(eee) >= tol11) & (abs(faa) > abs(fbb))
				sss = fbb / faa
				if aaa == ccc
					ppp = 2 * xmm * sss
					qqq = 1 - sss
				else
					qqq = faa / fcc
					rrr = fbb / fcc
					ppp = sss * (2 * xmm * qqq * (qqq - rrr) - (bbb - aaa) * (rrr - 1))
					qqq = (qqq - 1) * (rrr - 1) * (sss - 1)
				end
				if (ppp > 0)
					qqq = -qqq
				end
				ppp = abs(ppp)
				min11 = 3 * xmm * qqq - abs(tol11 * qqq)
				min22 = abs(eee * qqq)
				local tvar2 = 0.0
				if min11 < min22
					tvar2 = min11
				end
				if min11 > min22
					tvar2 = min22
				end
				if 2 * ppp < tvar2
					eee = ddd
					ddd = ppp / qqq
				else
					ddd = xmm
					eee = ddd
				end
			else
				ddd = xmm
				eee = ddd
			end
			aaa = bbb
			faa = fbb
			if abs(ddd) > tol11
				bbb += ddd
			else
				bbb += sign(xmm) * tol11
			end
			fbb = OF_Rho(bbb, am, bm, T)
			iter2 += 1
		end 
		bbb = -100
		return bbb
	end
	
	function OF_Rho(rho::Float64, aml::Float64, bml::Float64, T::Float64)
		local retVal = 0.1 * R * T 
		retVal -= bml * rho * R * T * ((1 - bml * rho)^ -2)
		retVal += R * T * ((1 - bml * rho)^-1)
		retVal += aml * rho^2 * (1 + 2 * bml * rho - ((bml * rho)^ 2)) ^ -2 * (2 * bml - 2 * bml^2 * rho)
		retVal += 2 * aml * rho * ((1 + 2 * bml * rho - ((bml * rho)^2))^ -1)
		return retVal
	end

	function FindZ_SimplRootFinder( phasetype::Char, beta::Float64, gama::Float64, delta::Float64) 
		local mustZero, Z
		if phasetype=='V'
			Z = 1
			while ( Z> 0. && ! (abs(mustZero) < epsilon))
				mustZero = Z^3 + beta * Z^2 + gama * Z + delta
				Z -= 0.00001
      end
		else
			Z = 0
			while ( Z < 1. && ! (abs(mustZero) < epsilon))
				mustZero = Z^3 + beta * Z^2 + gama * Z + delta
				Z += 0.00001
			end 
		end
		if (Z>0 && Z<1)
			return Z
		else
			return 0
    end
	end
  
end # module PengRobinson 
module helperEquation
	function getEq(_argsArray,_eq::Function)
		ex=:((argsArray)->$_eq())
		exx=ex.args[2].args[2].args
		len=length(_argsArray)
    j=1
		for i in 1:len
			if isnan(_argsArray[i])
        exx=vcat(exx,:(argsArray[$j]))
        j+=1
      else
        exx=vcat(exx,_argsArray[i])
      end
		end
    ex.args[2].args[2].args=exx
		return eval(ex)
	end
end