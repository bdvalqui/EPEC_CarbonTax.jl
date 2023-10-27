using EPEC_CarbonTax
using Test
#using Gurobi
#using GLPK
using CPLEX


println("*****************EPEC Solution*****************")

#@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC)=Solver_EPEC(Gurobi.Optimizer,"results/EPEC_Solution.txt","results")

#Number of Starting Points (Maximum 20 starting points; otherwise modify raw data in "data" folder)
Number_StartingPoints=20
start_points=[1,2,3,4,5]

#Number of Strategic Investors
Number_Firms=10
#Reference Scneario: scenario_tax=5 && scenario_ownership=5 (symmetric) && No Transmission Limits
#set_tax=[1,2,3,4,5] [0, 20, 50, 80 and 100 $/Ton]
set_tax=[5]
#scenario_tax=5
#set_ownership=[1,2,3,4,5]
#scenario_ownership=5  [1=Dirty-Symmetric,2=Dirty-Asymmetric,3=Clean-Symmetric,4=Clean-Asymmetric, 5=Reference]
scenario_ownership=5
Trans_Cap=100000
#TO Run Congested Scenario, Set Trans_Cap=5000, and  set_ownership=[1,3,5] [1=Dirty-Symmetric-Congested,3=Clean-Symmetric-Congested,5=Reference-Congested]
#set_ownership=[1,3,5]

equilibrium_investments=zeros(7,Number_StartingPoints)
Profits_Objective_Function=zeros(Number_StartingPoints,Number_Firms)
equilibrium_indicators=1000*ones(Number_StartingPoints)

Total_Investments_Technology_Firm1_EPEC_par_iter_dummy1_par=zeros(7,Number_StartingPoints)
Total_Investments_Technology_Firm1_EPEC_par_iter_diff_par=zeros(7,Number_StartingPoints)

for i in start_points

start_point=i
#for scenario_ownership in set_ownership
#for start_point in 1:Number_StartingPoints

for scenario_tax in set_tax

#scenario=scenario_ownership
global scenario=scenario_tax

#@time (Profits_Objective_Function_par,Total_Investments_Technology_EPEC_par,Nash_Equilibrium_Indicator_bin)=Solver_EPEC_Diag_StartingPoints_Nfirms(Number_Firms,start_point,scenario,scenario_tax,scenario_ownership,Trans_Cap,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$scenario/$start_point")

#@time (Leader)=Solver_EPEC_Diag_StartingPoints_Nfirms_PJM(Number_Firms,start_point,scenario,scenario_tax,scenario_ownership,Trans_Cap,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$scenario/$start_point")

@time (Profits_Objective_Function_par,Total_Investments_Technology_EPEC_par,Nash_Equilibrium_Indicator_bin)=Solver_EPEC_Diag_StartingPoints_Nfirms_PJM(Number_Firms,start_point,scenario,scenario_tax,scenario_ownership,Trans_Cap,CPLEX.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$scenario/$start_point")


global equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par
global Profits_Objective_Function[start_point,:]=Profits_Objective_Function_par
global equilibrium_indicators[start_point]=Nash_Equilibrium_Indicator_bin



end


end

println("Nash Equilibrium Indicator: $equilibrium_indicators")

println("Profits: $Profits_Objective_Function")

#end

#(equilibrium_investments_sol)=Plots_CapacityMix_All_Solutions(equilibrium_investments,Number_StartingPoints,Profits_Objective_Function,equilibrium_indicators,scenario,"results_startingpoints/$scenario")

#=
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

include("runtests_EPEC_StartingPoints_Nfirms.jl")
=#

#Profits_Objective_Function_par,Total_Investments_Technology_EPEC_par,Nash_Equilibrium_Indicator_bin