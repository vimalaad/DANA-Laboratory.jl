module NamesOfTypes
  export addnamestoinventory,getdotexpr

  inventory=Dict{DataType,Dict{Symbol,Union(Expr,Symbol)}}()
  inventorytyp=Dict{DataType,Dict{Symbol,DataType}}()

  #return dot expression to address a variable of type with parent
  function getdotexpr(t::DataType,ex::Union(Expr,Symbol))
    if isa(ex,Symbol)
      if haskey(inventory,t)
        return inventory[t][ex]
      else
        return ex
      end
    else
      if ex.head==:.
        if isa(ex.args[1],Expr)
          return :($(getdotexpr(t,ex.args[1])).$(ex.args[2].value))
        elseif isa(ex.args[1],Symbol) 
          if haskey(inventory,t)
            tt::DataType=inventorytyp[t][ex.args[1]]
            return :($(inventory[t][ex.args[1]]).$(getdotexpr(tt,ex.args[2].value)))
          else
            i=1
            while t.names[i]!=ex.args[1]
              i+=1
            end
            return :($(ex.args[1]).$(getdotexpr(t.types[i],ex.args[2].value)))
          end
        end
      else
        return nothing
      end
    end 
  end
  
  function addnamestoinventory(t::DataType)
    item::Dict{Symbol,Union(Expr,Symbol)}=Dict{Symbol,Union(Expr,Symbol)}()
    itemtyp::Dict{Symbol,DataType}=Dict{Symbol,DataType}()
    sym,exp,typ=allnames_recurcive(t)
    for i in [1:length(sym)]
      item[sym[i]]=exp[i]
      itemtyp[sym[i]]=typ[i]
    end
    #println("drived type: " *string(t))
    inventory[t]=item
    inventorytyp[t]=itemtyp
  end
  
  function allnames_recurcive(t::DataType)
    parentNames::Array{Symbol,1}=Array(Symbol,0)
    parentTyp::Array{DataType,1}=Array(DataType,0)
    parentExprs::Array{Union(Expr,Symbol),1}=Array(Union(Expr,Symbol),0)
    
    ret::Array{Symbol,1}=Array(Symbol,0)
    retExpr::Array{Union(Expr,Symbol),1}=Array(Union(Expr,Symbol),0)
    rettyp::Array{DataType,1}=Array(DataType,0)
    
    na=t.names
    ty=t.types
    j=1
    for i in [1:length(na)]
      if beginswith(string(na[i]),"_P")
        ap,axp,typ=allnames_recurcive(ty[i])
        parentNames=vcat(parentNames,ap)
        parentTyp=vcat(parentTyp,typ)
        for j in [1:length(axp)]
          axp[j]=:($(na[i]).$(axp[j]))
        end
        parentExprs=vcat(parentExprs,axp)
      else
        push!(ret,na[i])
        push!(retExpr,na[i])
        push!(rettyp,ty[i])
      end
    end
    return vcat(ret,parentNames),vcat(retExpr,parentExprs),vcat(rettyp,parentTyp)
  end
end