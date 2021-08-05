using EPEC_CarbonTax
using Test
using Gurobi
#using GLPK
#using CPLEX


println("*****************EPEC Solution*****************")

#@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC)=Solver_EPEC(Gurobi.Optimizer,"results/EPEC_Solution.txt","results")

println("Loading inputs...")
println("Solving EPEC to get initial conditions to run the experiment...")

#=
@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC)=Solver_EPEC(Gurobi.Optimizer,"results/EPEC_Solution.txt","results")

println("")
println("Start the experiment with initial results from EPEC")
println("")
#Run Central Planner to get initial conditions for the MPEC-EPEC

x_e_value_Experiment=x_e_value_MPEC
x_w_value_Experiment=x_w_value_MPEC
=#

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC)=Solver_EPEC_Experiment(Gurobi.Optimizer,"results/EPEC_Solution_Experiment.txt","results")
