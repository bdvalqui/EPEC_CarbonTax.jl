using EPEC_CarbonTax
using Test
using Gurobi
#using GLPK
#using CPLEX


println("*****************Central Planner Solution*****************")
#OPF------------------------------------------------------#

#@time (syscost_det,x_w_value,x_e_value,,set_opt_winds_numbertechnologies,set_opt_thermalgenerators_numbertechnologies)=Solver_CentralPlanner(Gurobi.Optimizer,"results/CentralPlanner_Solution.txt")

@time (syscost_det_OPF)=Solver_OPF(Gurobi.Optimizer,"results/OPF_Solution.txt")

#cd("C:\\Users\\braya\\.julia\\dev\\EPEC_CarbonTax\\test")
