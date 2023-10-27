Steps to run the model:

#Steps:

#Step 1: cd in ..."test" folder. Type the following in Julia REPL: 

cd("C:\\Users\\...\\test")

#Step 2: Activate enviroment. In Julia REPL:

press ]
activate .

#Step 3: Install the package in the current enviroment. Go to package manager mode.

dev ...\EPEC_CarbonTax.jl

#Step 4: Install CPLEX. Type the following in Julia REPL:

ENV["CPLEX_STUDIO_BINARIES"] = "C:\\GAMS\\40"
import Pkg
Pkg.add(name="CPLEX", version=" 1.0.0")
Pkg.build("CPLEX")

#Step 5: in Julia REPL type:

include("runtests_EPEC_StartingPoints_Nfirms")