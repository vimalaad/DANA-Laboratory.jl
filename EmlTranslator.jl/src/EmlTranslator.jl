include("typeinventory.jl")

module EmlTranslator
  export translate
  using typeinventory
  global const BuiltInTypes=["Boolean","Integer","Real","Plugin","Switcher"]
  include("helperfunctions.jl")
  include("toJuliaSmthng.jl")
#************************************************************
  function translate(_filePath::String,allradyCompiled::Set{String},dictSetUsings::Dict{String,Set{String}})
    requirepath=Main.requirePath
    if in(_filePath,allradyCompiled) #check if allrady compiled
      println(basename(_filePath)*">>>>allrady compiled ")
      return dictSetUsings[_filePath]
    else
      println(">>>>translate ",basename(_filePath))
      push!(allradyCompiled,_filePath)
      dictSetUsings[_filePath]=Set{String}()
    end
    jComments::Vector{String} = Array(String,0)
		jBComments::Vector{String} = Array(String,0)
		jDStrings::Vector{String} = Array(String,0)
    push!(jDStrings,"") #defualt empty string
		jSStrings::Vector{String} = Array(String,0)
    sModelFile::String=readall(open(_filePath))
    #*****************************************************
		outPutDirectory::String = replace(replace(_filePath,r"\.[^.]*$", ""),Main.emlPath, Main.jEmlPath)
    if !(isdir(outPutDirectory))
      #println("make dir:",outPutDirectory)
      mkpath(outPutDirectory)
    end
		# step 1 _ remove all comments (include blocks) and strings and replace them with suitable flag then write results in 3 jArray and include all in a jsonObject 
    bModelFile::IOBuffer = takeFileApart(sModelFile,jComments,jBComments,jDStrings,jSStrings)
		# step 2 extra white spaces
		sModelFile=takebuf_string(bModelFile)
		sModelFile=replace(sModelFile,r"\s+", " ")
		sModelFile=replace(sModelFile," ;", ";")
		##step 3 separate model and flow sheets
		sModelFile=replace(sModelFile," Model ", "\nModel ")
		sModelFile=replace(sModelFile," FlowSheet ", "\nFlowSheet ")
		sModelFile=replace(sModelFile,r" end (?!.*end)", " end\n")
		#step 4 remove models , flow sheets and typeDefs
		sModelFileSplit::Array{String} = split(sModelFile,'\n')
		pTypedef::Regex = r"[\w]* as [^;]*;"
		pUsing::Regex = r" *using ([\"'])([^;]+);"
    sUsing::String=""
		bComments::IOBuffer=IOBuffer()
    bMainModule::IOBuffer=PipeBuffer()
    #create a module for all models included in this file
    write(bMainModule,"module ","EML",basename(outPutDirectory),"\t")
    #all modules must load BuiltIn and using it
		write(bMainModule,"using DanaTypes;using NamesOfTypes;")
		for i in 1:length(sModelFileSplit)
      if beginswith(sModelFileSplit[i],"Model ")
				compiledModel::IOBuffer=PipeBuffer()
				seekstart(bComments)
        write(compiledModel,readall(bComments))
				ret = toJuliaModel(sModelFileSplit[i],compiledModel)
        modelName::String=""
        if ret[1]!=nothing
          modelName=ret
          #add all files & a file per model to module
          write(bMainModule,"include(\"" * basename(outPutDirectory) * "/" * modelName *".jl\");")
        else
          return ret
        end
        writeStringToFile(takePartsTogether(formatJulia(takebuf_string(compiledModel)),jComments,jBComments,jDStrings,jSStrings),outPutDirectory*"\\"*modelName*".jl")
      else
				if beginswith(sModelFileSplit[i],"FlowSheet ")
          #TODO
				else
          offset::Int=1
          truncate(bComments,0)
					while (m=match(pTypedef,sModelFileSplit[i],offset))!=nothing
						compiledType::IOBuffer=PipeBuffer()
            seekstart(bComments)
						write(compiledType,readall(bComments))
            write(bComments,sModelFileSplit[i][offset:m.offset-1])
            offset=m.offset+sizeof(m.match)
						typeName::String = toJuliaTypeDef(m.match,compiledType) 
            write(bMainModule,"include(\"" * basename(outPutDirectory) * "/" * typeName *".jl\");")
            writeStringToFile(takePartsTogether(formatJulia(takebuf_string(compiledType)),jComments,jBComments,jDStrings,jSStrings),outPutDirectory*"\\"*typeName*".jl")
          end
          write(bComments,sModelFileSplit[i][offset:sizeof(sModelFileSplit[i])])
          seekstart(bComments)
					sModelFileSplit[i]=readall(bComments)
          offset=1
          truncate(bComments,0)
					while (m=match(pUsing,sModelFileSplit[i],offset))!=nothing 
						if m.captures[1]=="\""
							sUsing=jDStrings[integer(m.captures[2])]
						else
							if m.captures[1]=="'"
                sUsing=jSStrings[integer(m.captures[2])]
              end
            end
            write(bComments,sModelFileSplit[i][offset:m.offset-1])
            if isfile(Main.emlPath*"/"*sUsing*".mso")
              setUsing=translate(Main.emlPath*"/"*sUsing*".mso",allradyCompiled,dictSetUsings)
              write(bMainModule,"require(\"$requirepath/" * sUsing *".jl\");")
            elseif isfile(dirname(_filePath)*"/"*sUsing*".mso")
              setUsing=translate(dirname(_filePath)*"/"*sUsing*".mso",allradyCompiled,dictSetUsings)
              write(bMainModule,"require(\"$requirepath" * dirname(libRelatedPath(outPutDirectory)) * "/" * sUsing *".jl\");")
            else
              return nothing,"in translate: invalid using " * sUsing
            end
            push!(dictSetUsings[_filePath],basename(sUsing))
            write(bMainModule,"using EML",basename(sUsing),";")
            for item in setUsing
              if !in(item,dictSetUsings[_filePath])
                write(bMainModule,"using EML",item,";")
                push!(dictSetUsings[_filePath],item)
              end
            end
            offset=m.offset+sizeof(m.match)
          end
          write(bComments,sModelFileSplit[i][offset:sizeof(sModelFileSplit[i])])
          seekstart(bComments)
					sModelFileSplit[i]=readall(bComments)
        end
      end
		end
    #close module
    write (bMainModule,"\nend;")
    writeStringToFile(formatJulia(takebuf_string(bMainModule)),outPutDirectory*".jl") 
    return dictSetUsings[_filePath]
  end
#************************************************************
	function takeFileApart(sModelFile::String,jComments::Vector{String},jBComments::Vector{String},jDStrings::Vector{String},jSStrings::Vector{String})
    oLength::Int = sizeof(sModelFile)
		i::Int=1
		commentStart::Bool = false
		blockCommentStart::Bool = false
		sStringStart::Bool = false
		dStringStart::Bool = false
		commentArrayOrString::IOBuffer=PipeBuffer()
		bModelFile::IOBuffer=PipeBuffer()
		c::Char=' '
		while i<=oLength
			c = sModelFile[i]
			if (blockCommentStart &&  (c != '*' || sModelFile[i+1]!='#')) || (commentStart && c != '\n') || (dStringStart && c != '"') || (sStringStart && c != '\'') #something started and continue 
				if sStringStart && c=='$'
          write(commentArrayOrString,'\\')
        end
        write(commentArrayOrString,c)
			else #start something or ready to stop 
				if commentStart #stop line comment
          commentStart=false
          push!(jComments,takebuf_string(commentArrayOrString))
          write(bModelFile,"#"*string(length(jComments))*" ")
				else
          if blockCommentStart #stop block comment
            i+=1
            blockCommentStart = false
            push!(jBComments,takebuf_string(commentArrayOrString))
            write(bModelFile,"#*"*string(length(jBComments)))
          else
            if dStringStart #stop double quoted string
              dStringStart = false
              push!(jDStrings,replace(takebuf_string(commentArrayOrString),"\\","\\\\"))
              write(bModelFile,'"')
              write(bModelFile,string(length(jDStrings)))
            else 
              if sStringStart #stop single quoted string
                sStringStart = false
                push!(jSStrings,takebuf_string(commentArrayOrString))
                write(bModelFile,'\'')
                write(bModelFile,string(length(jSStrings)))
              else
                if c == '"' #start string
                  dStringStart = true
                else
                  if c == '\'' #start string
                    sStringStart = true
                  else
                    if c == '#' #start some comment
                      if sModelFile[i+1]!='*' #line
                        commentStart = true
                      else
                        blockCommentStart = true #block
                        i+=1
                      end
                    else
                      write(bModelFile,c)
                    end
                  end
                end
              end
            end
          end
				end
			end
			i+=1
		end
    return bModelFile
  end
#************************************************************
	function takePartsTogether(sModelFile::String,jComments::Vector{String},jBComments::Vector{String},jDStrings::Vector{String},jSStrings::Vector{String})
    bModelFile::IOBuffer = PipeBuffer()
		oLength::Int = sizeof(sModelFile)
		i::Int=1
    tabs::Int=0
    bTab::Bool=false
    bNewLine::Bool=false
		c::Char=' '
		blockCommentStart::Bool = false
		while i<=oLength
			c = sModelFile[i]
      if bNewLine && c==' '
        i+=1
        continue
      else
        bNewLine=false
      end
			if c=='\t'
				if !bTab
					tabs=0
        end
				bTab=true
				tabs+=1
			else
				bTab=false
      end
			if (c=='"') || (c=='\'') || (c=='#')
        if (c=='#') && (sModelFile[i+1]=='*')
          blockCommentStart=true
					i+=1
				end
				sI::String=""
				nc::Char=sModelFile[i+1]
				while (nc >= '0') && (nc <= '9')
          i+=1
					sI*=string(sModelFile[i])
					nc=sModelFile[i+1]
				end
				index::Int=integer(sI)
				if c=='"'
					write(bModelFile,'"')
					write(bModelFile,jDStrings[index])
					write(bModelFile,'"')
				else
					if c=='\''
						write(bModelFile,'"')
						write(bModelFile,jSStrings[index])
						write(bModelFile,'"')
					else
            if c=='#'
              write(bModelFile,'#')
              bNewLine=true
              if blockCommentStart
                write(bModelFile,replace(jBComments[index],'\n',"\n#"),'\n')
                blockCommentStart=false
              else
                write(bModelFile,jComments[index])
                write(bModelFile,'\n')
                j::Int=0
                while j<tabs
                  write(bModelFile,'\t')
                  j+=1
                end
                if sModelFile[i+1]==' '
                  i+=1
                end
              end
            end
          end
        end
			else
				write(bModelFile,c)
      end
			i+=1
		end
		return takebuf_string(bModelFile)
	end
#************************************************************
	function formatJulia(juliaUnFormated::String)
		index::Int=1
		tabCount::Int=0
    cb::Int=0
    p::Int=0
    b::Int=0
		c::Char=' '
		juliaCode::IOBuffer=PipeBuffer()
		while index<=length(juliaUnFormated)
			c=juliaUnFormated[index]
      index+=1
      if c=='\n' 
        tabCount-=1
        write(juliaCode,c)
        addTabByCount(juliaCode,tabCount)
      else
        if (c==';') && (cb*p*b*c==0)
          if (index<=length(juliaUnFormated)) && (juliaUnFormated[index]!='\n')
            write(juliaCode,'\n')
            addTabByCount(juliaCode,tabCount)
          end
        else
          if c=='\t'
            write(juliaCode,'\n')
            tabCount+=1
            addTabByCount(juliaCode,tabCount)
            continue
          end
          write(juliaCode,c)
          c=='(' ? p+=1 : continue
          c==')' ? p-=1 : continue
          c=='{' ? cb+=1 : continue
          c=='}' ? cb-=1 : continue
          c=='[' ? b+=1 : continue
          c==']' ? b-=1 : continue
        end
      end
		end
    return takebuf_string(juliaCode)
	end
end