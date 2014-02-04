function toJuliaModel(model::String,compiledModel::IOBuffer)
  modelName::String=""
  thisParams::String="["
  thisVars::String="["
  thisAttribs::String=""
  pModel = r"^Model ([\w]*) (as ([\w,]*) )?(.*) end"
  modelnames::Array{String,1}=Array(String,0)
  modeltypes::Array{String,1}=Array(String,0)
  if (m=match(pModel,model))!=nothing     
    initials::IOBuffer=PipeBuffer()
    body::IOBuffer=PipeBuffer()
    constructor::IOBuffer=PipeBuffer()
    bModule::IOBuffer=PipeBuffer()
    modelName=m.captures[1]
    write(compiledModel,"type "*modelName*"\t"*modelName*"()=begin\t")
    write(constructor,"new(\t")
    #check if model as a child
    typeaddstr::String=""
    if m.captures[3]!=nothing
      pars=split(m.captures[3],',')
      for i = 1:length(pars)
        write(constructor,pars[i]*"(),;")
        write(body,"_P"*string(i)*"::",pars[i] ,";")
        push!(modelnames,"_P"*string(i))
        push!(modeltypes,pars[i])
      end
      typeaddstr="addnamestoinventory("*modelName*");"
    end
    model =  m.captures[4]
    model=replace(model,"ATTRIBUTES", "\nATTRIBUTES")
    model=replace(model,"PARAMETERS", "\nPARAMETERS")
    model=replace(model,"VARIABLES", "\nVARIABLES")
    model=replace(model,"EQUATIONS", "\nEQUATIONS")
    model=replace(model,"INITIAL", "\nINITIAL")
    model=replace(model,"SET", "\nSET")
    model=replace(model,"CONNECTIONS", "\nCONNECTIONS")
    pLine = r"\n([\w]+) *(.*)"
    offset=1
    while (m=match(pLine,model,offset))!=nothing 
      write(bModule,model[offset:m.offset-1])
      if m.captures[1]=="ATTRIBUTES"
        thisAttribs*=m.captures[2]
      else
        if m.captures[1]=="PARAMETERS"
          arrnames,arrtypes=toJuliaParVar(m.captures[2],body,constructor,compiledModel)
          for nameitm in arrnames
            thisParams*=":"*nameitm*","
          end
          modelnames=vcat(modelnames,arrnames)
          modeltypes=vcat(modeltypes,arrtypes)
        else
          if m.captures[1]=="VARIABLES"
            arrnames,arrtypes=toJuliaParVar(m.captures[2],body,constructor,nothing)
            for nameitm in arrnames
              thisVars*=":"*nameitm*","
            end
            modelnames=vcat(modelnames,arrnames)
            modeltypes=vcat(modeltypes,arrtypes)
          else
            #add to repository
            addtypetoinventory(modelName,modelnames,modeltypes)
            if m.captures[1]=="EQUATIONS"
              ret=toJuliaEQUATIONS(m.captures[2],body,constructor,modelName)
              if ret[1]==nothing
                return ret
              else
                write(bModule,ret)
              end
            else
              if m.captures[1]=="INITIAL"
                ret=toJuliaEQUATIONS(m.captures[2],body,compiledModel,modelName,"initials::Array{Expr,1};","initialNames::Array{String,1};","function initial(")
                if ret[1]==nothing
                  return ret
                else
                  write(bModule,ret)
                end
              else
                if m.captures[1]=="SET"
                  write(bModule,toJuliaSET(m.captures[2],modelName))
                end
              end
            end
          end
        end
      end
      offset=m.offset+sizeof(m.match)
    end
    #add to repository
    addtypetoinventory(modelName,modelnames,modeltypes)

    #write constructor
    write(compiledModel,takebuf_string(constructor))
    if thisParams!="["
      thisParams*="]"
      write(compiledModel,thisParams,',',";")
      write(body,"parameters::Array{Symbol,1};")
    end
    if thisVars!="["
      thisVars*="]"
      write(compiledModel,thisVars,";")
      write(body,"variables::Array{Symbol,1};")
    end
    if thisAttribs!=""
      write(bModule,toJuliaATTRIBUTES(thisAttribs,modelName))
      ##add outer constructor
      write(bModule,"$modelName(_::Dict{Symbol,Any})=begin\tnewModel=$modelName();newModel.attributes=atributes(newModel,_);newModel\nend;")
      write(body,"attributes::Dict{Symbol,Any};")
    end
    #write type
    #close type constructor
    write(compiledModel,"\n)\nend;")
    #type body
    write(compiledModel,takebuf_string(body),"\nend;")
    #module 
    write(compiledModel,"export ",modelName,";")
    write(compiledModel,takebuf_string(bModule))
    #add type names to inventory only if its a child
    if typeaddstr!=""
      write(compiledModel,typeaddstr)
    end
    #do model heve any thing else?
    write(compiledModel,model[offset:sizeof(model)])
    write(compiledModel,";")
  end
  return modelName
end
#************************************************************
function toJuliaCONNECTIONS(in::String)
  #TODO
  return in
end
#************************************************************
function toJuliaInitialization(varName::String, inits::String, jInits::IOBuffer)
  inits=replace(inits," *, *", ");")
  inits=replace(inits," *= *", "(")
  inits=replace(inits," final ", "final")
  inits=replace(inits,"\b(?:[\w]+\()", varName*"\.")
  write(jInits,inits)
end
#************************************************************
function toJuliaEQUATIONS(equationFlow::String, body::IOBuffer, constructor::IOBuffer, modelName::String, eqType::String="equations::Array{Expr,1};", eqNameType="equationNames::Array{String,1};", funcDec="function setEquationFlow(") 
  bEq::IOBuffer=PipeBuffer()
  bEquationNames::IOBuffer=PipeBuffer()
  pKeyWord=r" *((end)|((if.+?)then)|(switch ([\w]+))|(case ([^:]+):)|(when (.+?) switchto ([^;]+);)|(for ([\w]+) in (\[[^\]]+\]))|(\"[0-9]+)|(\#\*?[0-9]+)|(\'[0-9]+)|(else)|(([^=]+=[^;]+);))"
  offset::Int=1
  aKeyWords::Array{Int,1}=Array(Int,0)
  aWhen::Array{Int,1}=Array(Int,0)
  aBlockParam::Array{String,1}=Array(String,0)
  dWhen::Dict{Int,String}=Dict{Int,String}()
  currentBlock::Int=0
  firstCase::Bool=false
  eqCount::Int=0
  i::Int=0
  b::Int=0
  k::Int=0
  iWhen::Int=0
  
  equationString::String="\"1"
  
  write(body,eqType)
  write(body,eqNameType)
  
  write(constructor,"[\t")
  write(bEquationNames,"[\t")
  
  write(bEq,funcDec,"in::",modelName,")\t")
  while (m=match(pKeyWord,equationFlow,offset))!=nothing
    if m.offset!=offset
      #ERROR
      return nothing,"in toJuliaEquation: can't parse equation block/nm.match=" * m.match *"\nEQUATIONS=\n"*equationFlow*"\n"
    else
      i=2
      while m.captures[i]==nothing
        i+=1
      end
      if i==2
        #end
        pop!(aBlockParam)
        if last(aKeyWords)==12
          #end of for block
          pop!(aBlockParam)
        elseif last(aKeyWords)==5
          #end of let block
          write(bEq,"\nend;")
          #end of case
          write(bEq,"\nend;")
          pop!(aWhen)
        else
          write(bEq,"\nend;")
        end
        pop!(aKeyWords)
      elseif i==3
        #if
        push!(aKeyWords,i)
        push!(aBlockParam,"")
        ifConds::String=replace(replace(m.captures[4],r"\bequal\b","=="),r"\band\b","&&")
        write(bEq,ifConds,'\t')
      elseif i==5
        #switch
        push!(aKeyWords,i)
        push!(aBlockParam,m.captures[6])
        iWhen+=1
        push!(aWhen,iWhen)
        write(bEq,"let switch=",m.captures[6],'\t',"\$WHEN",string(iWhen),';')
        
        firstCase=true
      elseif i==7
        #case
        if last(aKeyWords)!=5
          return nothing,"in toJuliaEquation: case out of switch block"
        end
        if firstCase
          firstCase=false
        else
          write(bEq,"\nelse")
        end
        write(bEq,"if switch==",m.captures[8],'\t')
      elseif i==9
        #when
        if last(aKeyWords)!=5
          return nothing,"in toJuliaEquation: when out of switch block"
        end
        if !haskey(dWhen,last(aWhen))
          dWhen[last(aWhen)]=""
        end
        dWhen[last(aWhen)]*="if "*last(aBlockParam)*"=="*m.captures[10]*"\t"*"set(switch,"*m.captures[11]*");\nend;"
      elseif i==12
        #for
        push!(aKeyWords,i)
        push!(aBlockParam,m.captures[13])
        push!(aBlockParam,m.captures[14])
      elseif i==15
        #DString
        equationString=m.captures[15]
      elseif i==16
        #Comment
        write(bEq,m.captures[16],' ')
      elseif i==17
        #SString
        equationString=m.captures[17]
      elseif i==18
        #else
        write(bEq,"\nelse\t")
      elseif i==19
        #Equation
        b=1
        k=1
        equation=m.captures[20]
        while k<=length(aKeyWords)
          if aKeyWords[k]==12 #open for loop
            r=Regex("\\b"*aBlockParam[b]*"\\b")
            equation=replace(equation,r,aBlockParam[b+1])
            b+=1
          end
          k+=1
          b+=1
        end
        eqCount+=1
        write(bEq,"addEquation(",string(eqCount),");")
        write(constructor,":("*addparentbinding(modelName,equation)*"),;")
        write(bEquationNames,equationString,',')
        equationString="\"1"
      end
      offset+=length(m.match)
    end
  end
  
  write(constructor,"\n],;")
  write(bEquationNames,"\n],;")
  
  write(constructor,takebuf_string(bEquationNames))
  write(bEq,"\nend;")
  ret::String=takebuf_string(bEq)
  for i in [1:iWhen]
    if haskey(dWhen,i)
      ret=replace (ret,"\$WHEN"*string(i)*";",dWhen[i])
    else
      ret=replace (ret,"\$WHEN"*string(i)*";","")
    end
  end
  return ret
end  
#************************************************************
function toJuliaINITIAL(inits::String, body::IOBuffer, constructor::IOBuffer,modelName::String) 
  return "function initial(in::$modelName)\t"*replace(replace(inits,"; *", ");")," *= *", "(")*"\nend;"
end
#************************************************************
function toJuliaSET(set::String,modelName::String)
  return "function set(in::$modelName)\t"* addparentbinding(modelName,set) *"\nend;"
end
#************************************************************
function toJuliaATTRIBUTES(attribs::String,modelName::String)
  attribs="fields[:"*replace(replace(replace(replace(attribs," ",""),"=","]="),r";$",""),";",";fields[:")
  return "function atributes(in::$modelName,_::Dict{Symbol,Any})\tfields::Dict{Symbol,Any}=(Symbol=>Any)[];"*attribs*";drive!(fields,_);return fields\nend;"
end
#************************************************************
function toJuliaTypeDef( typeDef::String, compiledTypeDef::IOBuffer) 
  pTypedef = r"\b([a-zA-Z_][\w]*)\b as ([^;\(]*)\(([^;\)]*)\);"
  typeName::String=""
  if (m=match(pTypedef,typeDef))!=nothing
    typeName=m.captures[1]
    isBuiltIn::Bool=strip(m.captures[2]) in BuiltInTypes
    baseConstractor::String= isBuiltIn ? "fields" : "_" * m.captures[2] * "(fields).value"
    baseType::String= isBuiltIn ? "Dana" * strip(m.captures[2]) * "Parametric" : "Dana" * strip(m.captures[2])
    write(compiledTypeDef,"export " * typeName * ";typealias Dana" * m.captures[1] * " " * baseType * ";")
    write(compiledTypeDef,"type _",m.captures[1],"\t")
    write(compiledTypeDef,"function _",m.captures[1],"(_::Dict{Symbol,Any})\tfields::Dict{Symbol,Any}=(Symbol=>Any)[];")
    write(compiledTypeDef,"fields[:")
    inits::String = replace(replace(replace(replace(m.captures[3], "=", "]=")," final ", " final"),",",";fields[:")," ","")
    write(compiledTypeDef,inits,";drive!(fields,_);new(" * baseConstractor * ")" * "\nend;value::Dict{Symbol,Any}\nend")
    write(compiledTypeDef,";typealias " * m.captures[1] * " " * baseType * "{_" * m.captures[1] * "};")
  end
  return typeName
end
#************************************************************
function toJuliaParVar( typeDef::String, body::IOBuffer, constructor::IOBuffer, compiledModel) 
  offset::Int=1
  pTypedef = r"((in|out|outer) )?\b([a-zA-Z_][\w]*)\b(\([^\)]*\))? ?as ([^;\(]*)(\(([^;\)]+)\))?;"
  arrnames::Array{String,1}=Array(String,0)
  arrtypes::Array{String,1}=Array(String,0)
  while (m=match(pTypedef,typeDef,offset))!=nothing
    if m.captures[2]!=nothing
      if m.captures[2]=="in"
      #TODO
      elseif m.captures[2]=="out"
      #TODO
      elseif m.captures[2]=="outer"
        write(compiledModel,m.captures[3],"=outers.",m.captures[3],";")
      end
    end

    push!(arrnames,m.captures[3])
    push!(arrtypes,m.captures[3])

    isBuiltIn::Bool=strip(m.captures[5]) in BuiltInTypes
    baseConstractor::String= isBuiltIn ? "Dana" * m.captures[5] : m.captures[5]
    baseType::String= isBuiltIn ? "Dana" * m.captures[5] : m.captures[5]
    if m.captures[4]!=nothing
      write(body,m.captures[3],"::Array{",baseType,"};")
    else
      write(body,m.captures[3],"::",baseType,";")
    end
    if m.captures[4]!=nothing
      write(constructor,"fill(")
    end
    write(constructor,baseConstractor)
    if m.captures[6]!=nothing
      write(constructor,"((Symbol=>Any)[\t")
      write(constructor,":")
      inits::String = replace(replace(replace(m.captures[7],r" *= *","=>"),r", ?(?=[\w]*=)", ",;:")," final ", " final")
      if m.captures[4]!=nothing
        write(constructor,inits, "\n]),",m.captures[4],"),;")
      else
        write(constructor,inits, "\n]),;")
      end
    else
       m.captures[4]==nothing ? write(constructor, "(),;") : write(constructor, "()),;")
    end
    offset=m.offset+sizeof(m.match)
  end
  return arrnames,arrtypes
end
