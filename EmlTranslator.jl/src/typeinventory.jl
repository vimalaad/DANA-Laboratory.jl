module typeinventory
  export addtypetoinventory,getdotexpr

  inventory=Dict{String,Dict{String,String}}()
  inventorytyp=Dict{String,Dict{String,String}}()

  #return dot expression to address a variable of type with parent
  function getdotexpr(typename::String,ex::String)
    ret::String=""
    if !haskey(inventory,typename)
      return ex
    end
    if search(ex, '.')==0
      if haskey(inventory[typename],ex)
        return inventory[typename][ex]
      else
        return ex
      end
    else
      args=split(ex,'.',2)
      if !haskey(inventory[typename],args[1])
        return ex
      end
      ret=(inventory[typename][args[1]])*"."*getdotexpr(inventorytyp[typename][args[1]],args[2])
    end 
    return ret
  end
  
  function addtypetoinventory(typename::String,na::Array{String,1},ty::Array{String,1})
    if haskey(inventory,typename)
      return
    end
    item::Dict{String,String}=Dict{String,String}()
    itemtyp::Dict{String,String}=Dict{String,String}()
    sym,exp,typ=addparentnames(typename,na,ty)
    for i = 1:length(sym)
      item[sym[i]]=exp[i]
      itemtyp[sym[i]]=typ[i]
    end
    inventory[typename]=item
    inventorytyp[typename]=itemtyp
  end
  
  function addparentnames(typename::String,na::Array{String,1},ty::Array{String,1})
    parentNames::Array{String,1}=Array(String,0)
    parentTyp::Array{String,1}=Array(String,0)
    parentExprs::Array{String,1}=Array(String,0)
    
    ret::Array{String,1}=Array(String,0)
    retExpr::Array{String,1}=Array(String,0)
    rettyp::Array{String,1}=Array(String,0)

    j=1
    for i in [1:length(na)]
      if beginswith(na[i],"_P")
        ap=collect(keys(inventory[ty[i]]))
        axp=collect(values(inventory[ty[i]]))
        typ=collect(values(inventory[ty[i]]))
        parentNames=vcat(parentNames,ap)
        parentTyp=vcat(parentTyp,typ)
        for j in [1:length(axp)]
          axp[j]=na[i]*"."*axp[j]
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