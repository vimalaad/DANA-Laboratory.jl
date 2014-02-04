# this file is a part of Dana Virtula Laboratury project
# author:Reza Afzalan
# email:RAfzalan@Gmail.com
# 
#################################################################
# this module declares builtin types for Dana virtual laboratory
# this types must comply requiremnts of EML data model 
#################################################################


#################################################################
#         here is list of EML builtin data types
#
# Boolean Type for logical parameters or variables, with attributes:
# Brief textual brief description
# Default default value for parameters and initial guess for variables
#
#
# Integer Type for int variables or parameters, with attributes:
# Brief: textual brief description
# Default: default value for parameters and initial guess for variables
# Lower: lower limit
# Upper: upper limit
#
#
# Plugin Object for loading third party pieces of software providing special calculation
# services, see chapter 5.
#
# Real Type for continuous variables or parameters, with attributes:
# Brief: textual brief description
# Default: default value for parameters and initial guess for variables
# Lower: lower limit
# Upper: upper limit
# Unit: textual unit of measurement
#
#
# Switcher Type for textual parameters, with attributes:
# Brief textual brief description
# Valid the valid values for the switcher
# Default default value for the switcher
#
#################################################################
module DanaTypes
  export DanaBoolean,DanaInteger,DanaReal,DanaSwitcher,DanaPlugin,DanaError,AbsBulitIns
  export drive!,isequal,set,get
  export DanaBooleanParametric,DanaIntegerParametric,DanaRealParametric,DanaSwitcherParametric
  export outers
  export DanaModel
  typealias DanaError (Nothing,String)
  
  abstract DanaModel #abstract type for all models
  #################################################################
  # container for immut datas plus value
  # Q is value datatype and must be as immute default datatype
  # R non builtIn datatype
  abstract AbsBulitIns
  type Dana{T,Q,R}
    function Dana() 
      _immute=is(R,AbsBulitIns) ? T(Dict{Symbol,Any}()) : T(R(Dict{Symbol,Any}()).value)     
      typeof(_immute)==T ? new (_immute,_immute.default,true) : _immute
    end
    function Dana(_::Dict{Symbol,Any}) 
      _immute=is(R,AbsBulitIns) ? T(_) : T(R(_).value)     
      typeof(_immute)==T ? new (_immute,_immute.default,true) : _immute
    end
    immute::T
    value::Q
    unset::Bool
  end
  #get Dana value
  function get(x::Dana)
    return x.unset ? (nothing,"value is unset, use immute.default") : x.value
  end
  function unset(x::Dana)
    x.unset=true
  end
  #################################################################
  # Boolean datatype declaration 
  immutable _Boolean
    _Boolean(_::Dict{Symbol,Any})= begin
      b::String=haskey(_,:finalBrief) ?  _[:finalBrief] : haskey(_,:Brief) ? _[:Brief] : "Boolean Value"
      d::Bool=haskey(_,:finalDefault) ?  _[:finalDefault] : haskey(_,:Default) ? bool(_[:Default]) : false
      new(b,d)
    end
    brief::String 
    default::Bool 
  end
  #################################################################
  # Integer datatype declaration 
  immutable _Integer
    _Integer(_::Dict{Symbol,Any}) = begin
      b::String=haskey(_,:finalBrief) ?  _[:finalBrief] : haskey(_,:Brief) ? _[:Brief] : "Integer Number"
      d::Int=haskey(_,:finalDefault) ?  _[:finalDefault] : haskey(_,:Default) ? integer(_[:Default]) : 0
      l::Int=haskey(_,:finalLower) ?  _[:finalLower] : haskey(_,:Lower) ? integer(_[:Lower]) : typemin(Int)
      u::Int=haskey(_,:finalUpper) ?  _[:finalUpper] : haskey(_,:Upper) ? integer(_[:Upper]) : typemax(Int)
      new(b,d,l,u)
    end
    brief::String 
    default::Int 
    lower::Int
    upper::Int
  end
  #################################################################
  # Switcher datatype declaration 
  immutable _Switcher
    _Switcher(_::Dict{Symbol,Any}) = begin
      if !haskey(_,:finalValid) && !haskey(_,:Valid)
        return nothing,"in Switcher: valid values not found"
      end
      if !haskey(_,:finalDefault) && !haskey(_,:Default)
        return nothing,"in Switcher: default value not found"
      end
      b::String=haskey(_,:finalBrief) ?  _[:finalBrief] : (haskey(_,:Brief) ? _[:Brief] : "Switcher")
      d=haskey(_,:finalDefault) ?  _[:finalDefault] : _[:Default]
      e::Set=haskey(_,:finalValid) ?  Set(_[:finalValid]...) : (haskey(_,:Valid) ? Set(_[:Valid]...) : Set())
      if !isa(e,Set)
        return nothing,"in Switcher: invalid values, must be a set"
      end
      if !in(d,e)
        return nothing,"in Switcher: invalid default value"
      end
      new(b,d,e)
    end
    brief::String 
    default::Any   
    valid::Set
  end
  #################################################################
  # Real datatype declaration 
  immutable _Real
    _Real(_::Dict{Symbol,Any}) = begin
      b::String=haskey(_,:finalBrief) ?  _[:finalBrief] : haskey(_,:Brief) ? _[:Brief] : "Real Number"
      d::Float64=haskey(_,:finalDefault) ?  _[:finalDefault] : haskey(_,:Default) ? float(_[:Default]) : 0.0
      l::Float64=haskey(_,:finalLower) ?  _[:finalLower] : haskey(_,:Lower) ? float(_[:Lower]) : typemin(Float64)
      u::Float64=haskey(_,:finalUpper) ?  _[:finalUpper] : haskey(_,:Upper) ? float(_[:Upper]) : typemax(Float64)
      un::String=haskey(_,:finalUnit) ?  _[:finalUnit] : haskey(_,:Unit) ? _[:Unit] : ""
      new(b,d,l,u,un)
    end
    brief::String 
    default::Float64 
    lower::Float64 
    upper::Float64 
    unit::String 
  end
  #################################################################
  # Plugin datatype declaration 
  immutable DanaPlugin
    DanaPlugin(_::Dict{Symbol,Any}) = begin
      b::String=haskey(_,:finalBrief) ?  _[:finalBrief] : haskey(_,:Brief) ? _[:Brief] : "Plugin"
      new(b)
    end
    brief::String
  end 
  #################################################################
  typealias DanaBooleanParametric{R} Dana{_Boolean,Bool,R}
  typealias DanaBoolean Dana{_Boolean,Bool,AbsBulitIns}
  # set Boolean value
  function set(x::DanaBoolean,y::Bool)
      x.value=y
      x.unset=false
  end
  typealias DanaIntegerParametric{R} Dana{_Integer,Int,R}
  typealias DanaInteger Dana{_Integer,Int,AbsBulitIns}
  typealias DanaSwitcherParametric{R} Dana{_Switcher,Any,R}
  typealias DanaSwitcher Dana{_Switcher,Any,AbsBulitIns}
  #check Switcher value
  function isequal(x::DanaSwitcher,y::Any)
    return x.unset ? (nothing,"value is unset, use immute.default") : x.value==y
  end
  # set Switcher value
  function set(x::DanaSwitcher,y::Any)
    if !in(y,x.immute.valid)
      return nothing,"in set: invalid value " * string(y)
    else
      x.value=y
      x.unset=false
      return y
    end
  end
  typealias DanaRealParametric{R} Dana{_Real,Float64,R}
  typealias DanaReal Dana{_Real,Float64,AbsBulitIns}
  # set Integer,Real value
  function set(x::DanaReal,y::Float64)
    if y>=x.immute.lower && y<=x.immute.upper
      x.value=y
      x.unset=false
      return y
    else
      return nothing,"value must between " * string(x.immute.lower) * " and " * string(x.immute.upper)
    end
  end
  function set(x::DanaInteger,y::Int)
    if y>=x.immute.lower && y<=x.immute.upper
      x.value=y
      x.unset=false
      return y
    else
      return nothing,"value must between " * string(x.immute.lower) * " and " * string(x.immute.upper)
    end
  end
  #################################################################
  # driving childs from Dana datatypes
  function drive!(base::Dict{Symbol,Any},child::Dict{Symbol,Any})
    f(k,v)=!(haskey(base,k) && beginswith(string(k),"final"))
    merge!(base,filter(f,child))
  end 
  #################################################################
  module outers
    PP=0
    NComp=0
  end

end
