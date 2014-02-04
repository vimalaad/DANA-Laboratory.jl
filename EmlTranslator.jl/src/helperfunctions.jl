#************************************************************
function writeStringToFile(txt::String,outPutFile::String)
  ios::IOStream=open(outPutFile,"w")
  write(ios,txt)
  close(ios)
end
#************************************************************
function addTabByCount(juliaCode::IOBuffer, tabCount::Int)
  tab_::Int=0;
  while (tab_<tabCount)
    write(juliaCode,'\t')
    tab_+=1
  end
end
#************************************************************
function createJuliaGetProperty(name::String)
  return "function " * name * "()\treturn " * name * ";\nend;"
end
#************************************************************
function createJuliaSetProperty( name::String, ProType::String)
  return "function " * name * "(newVal::" * ProType *")\t" * name * "=newVal;\nend;"
end
#************************************************************
function addparentbinding(modelName::String,block::String)   
  pVar::Regex = r"\b[a-zA-Z_][\w\.]*[\w]\b"
  offset::Int=1
  bRet::IOBuffer=PipeBuffer()
  while (m=match(pVar,block,offset))!=nothing
    write(bRet,block[offset:m.offset-1],getdotexpr(modelName,m.match))
    offset=m.offset+sizeof(m.match)
  end
  write(bRet,block[offset:sizeof(block)])
  return takebuf_string(bRet)
end
#************************************************************
function libRelatedPath(absPath::String)
  return replace(absPath,Main.jEmlPath,"")
end

