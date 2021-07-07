using EPEC_CarbonTax
using Test
using Gurobi
#using GLPK
#using CPLEX


println("*****************MPEC Solution*****************")

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC)=Solver_MPEC(Gurobi.Optimizer,"results/MPEC_Solution.txt")

#cd("C:\\Users\\braya\\.julia\\dev\\EPEC_CarbonTax\\test")
