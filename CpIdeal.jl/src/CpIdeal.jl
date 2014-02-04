module CpIdeal
  export C0Poly,C0Hyper
  cp_polynomial=open("./share/julia/site/v0.2/CpIdeal.jl/src/Tables/perryHeatCapIdealGas(Table2-155).table");
  cp_hyperbolic=open("./share/julia/site/v0.2/CpIdeal.jl/src/Tables/perryHeatCapIdealGas(Table2-156).table");
  data_poly,header_poly=readdlm(cp_polynomial,';',has_header=true);
  data_hyper,header_hyper=readdlm(cp_hyperbolic,';',has_header=true);
  close(cp_polynomial)
  close(cp_hyperbolic)
  function C0Poly(CasNo::String)
    length=size(data_poly)[1]
    i=1
    while (i<=length && data_poly[i,4]!=CasNo) 
      i+=1;
    end
    if (i<=length)
      return (data_poly[i,6],data_poly[i,7],data_poly[i,8],data_poly[i,13],data_poly[i,14])
    end
  end
  function C0Hyper(CasNo::String)
    length=size(data_hyper)[1]
    i=1
    while (i<=length && data_hyper[i,4]!=CasNo)
      i+=1;
    end
    if (i<=length)
      return (data_hyper[i,6],data_hyper[i,7],data_hyper[i,8],data_hyper[i,9],data_hyper[i,10])
    end
  end
end