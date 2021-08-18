using EPEC_CarbonTax
using Test
using Gurobi
#using GLPK
#using CPLEX


println("*****************EPEC Solution*****************")

#@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC)=Solver_EPEC(Gurobi.Optimizer,"results/EPEC_Solution.txt","results")

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC)=Solver_EPEC_4firms(Gurobi.Optimizer,"results/EPEC_Solution.txt","results")

#cd("C:\\Users\\braya\\.julia\\dev\\EPEC_CarbonTax\\test")
