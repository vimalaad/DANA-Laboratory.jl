using EmlTranslator
emlPath="C:/vimalaad/julia-d85ee1fcaf/share/julia/site/v0.2/eml"
jEmlPath="C:/vimalaad/julia-d85ee1fcaf/share/julia/site/v0.2/DanaModels.jl/JuliaEMSOModels"
requirePath="DanaModels.jl/JuliaEMSOModels" 
function translateall(_path="") 
  dictSetUsings::Dict{String,Set{String}}=Dict{String,Set{String}}()
  allradyCompiled::Set{String}=Set{String}()
  if _path==""
    _path=Main.emlPath
  end
  emlFiles::Vector{ByteString} = readdir(_path)
  length(emlFiles)
  for _emlFile in emlFiles
    emlFile=replace(replace(_emlFile,"\\","/"),"//","/")
    if isdir(_path*"/"*emlFile)
      translateall(_path*"/"*emlFile)
    else
      if ismatch(r"[^.]*\.mso$"i,emlFile)
        println(" File name: ",emlFile,">> Translation starts........")
        ret=translate(_path*"/"*emlFile,allradyCompiled,dictSetUsings)
        if !isa(ret,Set)
          println(ret[2])
        end
      end 
    end
  end
end
