module DanaModels
  export controllers,costs,electrical,heat_exchangers,mixers_splitters,pressure_changers,reactors
  export stage_separators,streams,types,UserModels,power_plant
  module controllers
    export EMLComparator,EMLHiLoSelect,EMLiae,EMLise
    export EMLlag_1,EMLlead_lag,EMLmultiply
    export EMLPIDIncr,EMLPIDs,EMLratio,EMLsum
    include("../JuliaEMSOModels/controllers/Comparator.jl");
    include("../JuliaEMSOModels/controllers/HiLoSelect.jl");
    include("../JuliaEMSOModels/controllers/iae.jl");
    include("../JuliaEMSOModels/controllers/ise.jl");
    include("../JuliaEMSOModels/controllers/lag_1.jl");
    include("../JuliaEMSOModels/controllers/lead_lag.jl");
    include("../JuliaEMSOModels/controllers/multiply.jl");
    include("../JuliaEMSOModels/controllers/PIDIncr.jl");
    include("../JuliaEMSOModels/controllers/PIDs.jl");
    include("../JuliaEMSOModels/controllers/ratio.jl");
    include("../JuliaEMSOModels/controllers/sum.jl");
  end
  
  module costs
    export EMLcolumn_cost,EMLflash_cost,EMLHeatExchangerDetailed_cost
    export EMLHeatExchangerSimplified_cost,EMLreboiler_cost,EMLtank_cost
    include("../JuliaEMSOModels/costs/column_cost.jl")
    include("../JuliaEMSOModels/costs/flash_cost.jl")
    include("../JuliaEMSOModels/costs/HeatExchangerDetailed_cost.jl")
    include("../JuliaEMSOModels/costs/HeatExchangerSimplified_cost.jl")
    include("../JuliaEMSOModels/costs/reboiler_cost.jl")
    include("../JuliaEMSOModels/costs/tank_cost.jl")
  end
  
  module electrical
    export EMLelectrical
    include("../JuliaEMSOModels/electrical/electrical.jl")
  end
  
  module heat_exchangers
    export EMLDoublePipe,EMLDoublePipeIncr,EMLHairpin,EMLHairpinIncr
    export EMLheater,EMLHeatex,EMLHeatExchangerDetailed,EMLHEX_Engine,EMLPHE
    include("../JuliaEMSOModels/heat_exchangers/DoublePipe.jl")
    include("../JuliaEMSOModels/heat_exchangers/DoublePipeIncr.jl")
    include("../JuliaEMSOModels/heat_exchangers/Hairpin.jl")
    include("../JuliaEMSOModels/heat_exchangers/HairpinIncr.jl")
    include("../JuliaEMSOModels/heat_exchangers/heater.jl")
    include("../JuliaEMSOModels/heat_exchangers/Heatex.jl")
    include("../JuliaEMSOModels/heat_exchangers/HeatExchangerDetailed.jl")
    include("../JuliaEMSOModels/heat_exchangers/HEX_Engine.jl")
    include("../JuliaEMSOModels/heat_exchangers/PHE.jl")
  end
  
  module mixers_splitters
    export EMLmixer,EMLsepComp,EMLsplitter
    include("../JuliaEMSOModels/mixers_splitters/mixer.jl")
    include("../JuliaEMSOModels/mixers_splitters/sepComp.jl")
    include("../JuliaEMSOModels/mixers_splitters/splitter.jl")
  end
  
  module pressure_changers
    export EMLcompressor,EMLexpander,EMLpump,EMLturbine,EMLvalve
    include("../JuliaEMSOModels/pressure_changers/compressor.jl")
    include("../JuliaEMSOModels/pressure_changers/expander.jl")
    include("../JuliaEMSOModels/pressure_changers/pump.jl")
    include("../JuliaEMSOModels/pressure_changers/turbine.jl")
    include("../JuliaEMSOModels/pressure_changers/valve.jl")
  end
  
  module reactors
    export EMLbatch,EMLcstr,EMLequil,EMLgibbs,EMLpfr
    export EMLstoic,EMLtank_basic,EMLvol_tank,EMLyield
    include("../JuliaEMSOModels/reactors/batch.jl")
    include("../JuliaEMSOModels/reactors/cstr.jl")
    include("../JuliaEMSOModels/reactors/equil.jl")
    include("../JuliaEMSOModels/reactors/gibbs.jl")
    include("../JuliaEMSOModels/reactors/pfr.jl")
    include("../JuliaEMSOModels/reactors/stoic.jl")
    include("../JuliaEMSOModels/reactors/tank_basic.jl")
    include("../JuliaEMSOModels/reactors/vol_tank.jl")
    include("../JuliaEMSOModels/reactors/yield.jl")
  end
  
  module stage_separators
    export EMLbatch_dist,EMLcolumn,EMLcolumn_Eff,EMLcondenser
    export EMLflash,EMLreboiler,EMLtank,EMLtray,EMLtray_Eff
    include("../JuliaEMSOModels/stage_separators/batch_dist.jl")
    include("../JuliaEMSOModels/stage_separators/column.jl")
    include("../JuliaEMSOModels/stage_separators/column_Eff.jl")
    include("../JuliaEMSOModels/stage_separators/condenser.jl")
    include("../JuliaEMSOModels/stage_separators/flash.jl")
    include("../JuliaEMSOModels/stage_separators/reboiler.jl")
    include("../JuliaEMSOModels/stage_separators/tank.jl")
    include("../JuliaEMSOModels/stage_separators/tray.jl")
    include("../JuliaEMSOModels/stage_separators/tray_Eff.jl") 
  end
  
  module streams
    export EMLstreams
    include("../JuliaEMSOModels/streams.jl")  
  end
  
  module types
    export EMLtypes
    include("../JuliaEMSOModels/types.jl")
  end
  
  module UserModels
    export EMLUserTray,EMLUserColumn
    include("../JuliaEMSOModels/UserModels/UserTray.jl")
    include("../JuliaEMSOModels/UserModels/UserColumn.jl")
  end
  
  module power_plant
    export EMLpower_plant
    include("../JuliaEMSOModels/water_steam/power_plant.jl")
  end
end