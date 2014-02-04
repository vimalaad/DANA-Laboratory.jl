# REF[1] Chemical Process Design and Integration ,By:Robin Smith ,Copyright 2005
# REF[2] dwsim3\DWSIM\Objects\PropertyPackages\PengRobinson\Helper Classes\PR.vb
# REF[3] CODATA Recommended Values of the Fundamental Physical Constants: 2006, http://physics.nist.gov
# REF[4] Perry handbook ED8

include("../pengRobinson.jl")
include("../../JSON.jl/src/JSON.jl")

module testPR
  using JSON
  using PengRobinson
  
	const BarToPascal=100000
	const BarToMPascal=0.1
	const MPascalToPascal=1000000


#		REF[1] /p58
#		Example 4.1 Using the Peng–Robinson equation of state:
#		a. determine the vapor compressibility of nitrogen at 273.15 K
#/		and 1.013 bar, 5 bar and 50 bar, and compare with an ideal gas.
#		For nitrogen, TC = 126.2 K, PC = 33.98 bar and w = 0.037.
#		Take R = 0.08314 bar·m3·kmol-1·K-1.
#      nitrogen cas-number : "7727-37-9"
  function test1()
    ctp=JSON.parse(readall(open("packages/VirtualLab.jl/DataBase/CTP.json")))
    kijPR=JSON.parse(readall(open("packages/VirtualLab.jl/DataBase/kij_pr.json")))
    CasNo="7727-37-9"
    component=ctp[CasNo]
    local T=273.15
    local P=[1.013*BarToPascal,5*BarToPascal,50*BarToPascal]
    TC=[component["Critical_Temperature"]] #must be 126.2
    PC=[component["Critical_Pressure"]] #must be BarToMPascal*33.98
    PC[1] = BarToPascal*33.98
    w=[component["Acentric_Factor"]] #0.0377
		w[1] = 0.037 #overWrite value
		Vx=[1.0]
		index = kijPR["*"][CasNo] #13
    VKij=zeros(Float64,(1,1))
		VKij[1,1]=kijPR[CasNo][index] #must {{0}}
		pr=PengRobinson.Initialize(TC, PC, Vx, w)
    PengRobinson.setT!(pr,T, VKij)
    for  i = 1:length(P) 
      PengRobinson.setP!(pr,P[i])
      z = PengRobinson.CalcZ(pr)
      print("root 1=",z[1],"\n","root 2=",z[2],"\n",)
      if i==1
        print("REF said:0.9992\n")
      end
      if i==2
        print("REF said:0.9963\n")
      end
      if i==3
        print("REF said:0.9727\n")
      end
    end
  end #test1 
  
  function test2()
    # b. determine the liquid density of benzene at 293.15 K and
    # compare this with the measured value of RhoL = 876.5 kg·m-3.
    # For benzene, TC = 562.05 K, PC = 48.95 bar and w = 0.210.
    ctp=JSON.parse(readall(open("packages/VirtualLab.jl/DataBase/CTP.json")))
    kijPR=JSON.parse(readall(open("packages/VirtualLab.jl/DataBase/kij_pr.json")))
    CasNo="71-43-2"
    component=ctp[CasNo]
		local T=293.15
    local P=[1.013*BarToPascal]
		TC=[component["Critical_Temperature"]] #must be 562.05
		PC=[component["Critical_Pressure"]] #must be BarToPascal*48.95;
		PC[1]*=MPascalToPascal
    w=[component["Acentric_Factor"]] #0.210
    w[1] = 0.210 #overWrite value
    Vx=[1.0]
		index = kijPR["*"][CasNo] 
    VKij=zeros(Float64,(1,1))
    VKij[1,1]=kijPR[CasNo][index] #must {{0}}
		pr=PengRobinson.Initialize(TC, PC, Vx, w);
		PengRobinson.setT!(pr, T, VKij)
		PengRobinson.setP!(pr, P[1] )
		z = PengRobinson.CalcZ(pr)
		print(z[1]," REF said:",0.95177,'\n',z[2]," REF said:",0.0036094,'\n')
  end #test2
end #module
