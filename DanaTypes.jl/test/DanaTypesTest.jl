using DanaTypes
using Base.Test
# test DanaBoolean
db1=DanaBoolean((Symbol=>Any)[:Brief=>"test",:Default=>true])
@test db1.value==true
@test db1.immute.brief=="test"
db2=DanaBoolean((Symbol=>Any)[:Default=>false])
@test db2.value==false
@test db2.immute.brief=="Boolean Value" #default brief
db3=DanaBoolean((Symbol=>Any)[])
@test db3.value==false #defualt 
@test db3.immute.brief=="Boolean Value" #default brief
db4=DanaBoolean()
@test db4.value==false #defualt 
@test db4.immute.brief=="Boolean Value" #default brief
db5=DanaBoolean((Symbol=>Any)[:Brief=>"test",:Default=>true,:finalBrief=>"finaltest",:finalDefault=>false])
@test db5.value==false #defualt 
@test db5.immute.brief=="finaltest" #default brief
# test DanaInteger
di1=DanaInteger((Symbol=>Any)[:Brief=>"test",:Default=>1,:Lower=>-1])
@test di1.value==1
@test di1.immute.brief=="test"
set(di1,-1)
@test di1.value==-1
ret=set(di1,-2)
isa(ret,DanaError) ? println(ret[2]) : true
@test di1.value==-1
di2=DanaInteger((Symbol=>Any)[:Default=>2])
@test di2.value==2
@test di2.immute.brief=="Integer Number" #default brief
di3=DanaInteger((Symbol=>Any)[])
@test di3.value==0 #defualt 
@test di3.immute.brief=="Integer Number" #default brief
di4=DanaInteger()
@test di4.value==0 #defualt 
@test di4.immute.brief=="Integer Number" #default brief
di5=DanaInteger((Symbol=>Any)[:Brief=>"test",:Default=>4,:finalBrief=>"finaltest",:finalDefault=>3])
@test di5.value==3 #defualt 
@test di5.immute.brief=="finaltest" #default brief
# test DanaSwitcher
ds1=DanaSwitcher((Symbol=>Any)[:Brief=>"test",:Default=>1,:Valid=>Set(-1,1)])
@test isequal(ds1,-1)[1]==nothing
set(ds1,1)
@test get(ds1)==1
@test ds1.immute.brief=="test"
set(ds1,-1)
@test get(ds1)[1]==-1
ret=set(ds1,-2)
isa(ret,DanaError) ? println(ret[2]) : true
@test get(ds1)==-1
@test isequal(ds1,-1)==true
# test DanaReal
dr1=DanaReal((Symbol=>Any)[:Brief=>"test",:Default=>1.0,:Lower=>-1.0])
@test set(dr1,1.0)==1.0
@test dr1.immute.brief=="test"
set(dr1,-1.0)
@test get(dr1)==-1.0
ret=set(dr1,-2.0)
isa(ret,DanaError) ? println(ret[2]) : true
@test get(dr1)==-1.0
dr2=DanaReal((Symbol=>Any)[:Default=>2.0])
@test get(dr2)[1]==nothing
@test dr2.immute.brief=="Real Number" #default brief
dr3=DanaReal((Symbol=>Any)[])
@test dr3.value==0.0 #defualt 
@test dr3.immute.brief=="Real Number" #default brief
dr4=DanaReal()
@test dr4.value==0.0 #defualt 
@test dr4.immute.brief=="Real Number" #default brief
dr5=DanaReal((Symbol=>Any)[:Brief=>"test",:Default=>4.0,:finalBrief=>"finaltest",:finalDefault=>1.0,:Upper=>1.0])
set(dr5,3.0) #3.0>upper
@test get(dr5)[1]==nothing #unset 
@test dr5.immute.brief=="finaltest" #default brief