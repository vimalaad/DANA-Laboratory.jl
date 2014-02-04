module IdealGasEos
  #Units J,Kmol,Kelvin
  using DanaTypes
  export DANAIdealGasEos,setEquationFlow
  type  DANAIdealGasEos <: DanaModel
      DANAIdealGasEos()=begin
        new(NaN,8314.4621,NaN,NaN,"",NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,true,
          [
            :(P*v=R*T),
            :(Cp=C1+C2*T+C3*T^2+C4*T^3+C5*T^4),#Poly Cp
            :(Cp=C1+C2*((C3/T)/sinh(C3/T))^2+C4*((C5/T)/cosh(C5/T))^2),#Hyper Cp
            :(ICpOnTDT=C2*T+(C3*T^2)/2+(C4*T^3)/3+(C5*T^4)/4+C1*log(T)),#Integral of Cp/T Poly
            :(ICpOnTDT=(C2*C3*coth(C3/T)+C1*T*log(T)+C4*T*log(cosh(C5/T))-C2*T*log(Sinh(C3/T))-C4*C5*tanh(C5/T))/T),#Integral of Cp/T Hyper
            :(Cv=Cp-R),#Cv Def
            :(ICpDT=C1*T+1/60*T^2*(30*C2+T*(20*C3+3*T*(5*C4+4*C5*T)))),#Integ of Cp Poly
            :(ICpDT=C1*T+C2*C3*coth(C3/T)-C4*C5*tanh(C5/T)),#Integ of Cp Hyper
            :(u=ICpDT-R*T), #Internal energy dep
            :(h=ICpDT), #Enthalpy def
            :(s=ICpOnTDT-R*log(P)) #Entropy
          ],Array(Expr,0)
        )
      end
      v::Float64
      R::Float64
      T::Float64
      P::Float64
      CASNO::String
      Cp::Float64
      C1::Float64
      C2::Float64
      C3::Float64
      C4::Float64
      C5::Float64
      ICpOnTDT::Float64
      Cv::Float64
      ICpDT::Float64
      u::Float64
      h::Float64
      s::Float64
      usePolynomialEstimationOfCp::Bool
      equations::Array{Expr,1}
      equationsFlow::Array{Expr,1}
  end
  function setEquationFlow(this::DANAIdealGasEos)
    if this.usePolynomialEstimationOfCp
      this.equationsFlow=[this.equations[1],this.equations[2],this.equations[4],this.equations[6],this.equations[7],this.equations[9],this.equations[10],this.equations[11]]
    else
      this.equationsFlow=[this.equations[1],this.equations[3],this.equations[5],this.equations[6],this.equations[8],this.equations[9],this.equations[10],this.equations[11]]
    end
  end
end
