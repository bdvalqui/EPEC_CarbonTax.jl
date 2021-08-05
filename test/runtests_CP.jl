using EPEC_CarbonTax
using Test
using Gurobi
#using GLPK
#using CPLEX


println("*****************Central Planner Solution*****************")
#OPF------------------------------------------------------#

#@time (syscost_det,x_w_value,x_e_value,set_opt_winds_numbertechnologies,set_opt_thermalgenerators_numbertechnologies,Total_Investments_Technology_CP)=Solver_CentralPlanner(Gurobi.Optimizer,"results/CentralPlanner_Solution.txt")

@time (syscost_det_OPF,revenue_cost_CP,p_G_e_value_CP,p_G_e_value_node1_CP,p_G_e_value_node2_CP,p_G_e_value_node3_CP,p_G_w_value_node1_CP,p_G_w_value_node2_CP,p_G_w_value_node3_CP,υ_SR_value_CP,Dual_constraint10,Dual_constraint11,Total_Generation_Technology_CP,Total_Generation_Technology_Existing_CP,Total_Generation_Technology_Candidate_CP, Total_Generation_Technology_node1_CP, Total_Generation_Technology_node2_CP, Total_Generation_Technology_node3_CP)=Solver_OPF(Gurobi.Optimizer,"results/OPF_Solution.txt")

#(syscost_det_OPF,TotalEmissions,TotalRevenue_demandblock,TotalOpecost_demandblock,revenue_cost_CP,TotalCapCost,TotalFixedCost,TotalEmissionsCost,TotalOpecost,TotalCurtailmentcost,p_G_e_value_CP,p_G_e_value_node1_CP,p_G_e_value_node2_CP,p_G_e_value_node3_CP,p_G_w_value_CP,p_G_w_value_node1_CP,p_G_w_value_node2_CP,p_G_w_value_node3_CP,υ_SR_value_CP,Dual_constraint10,Dual_constraint11,Total_Generation_Technology_CP,Total_Generation_Technology_Existing_CP,Total_Generation_Technology_Candidate_CP, Total_Generation_Technology_node1_CP, Total_Generation_Technology_node2_CP, Total_Generation_Technology_node3_CP,x_w_value,x_e_value,Total_Investments_Technology_CP)=Solver_OPF_Experiment(Gurobi.Optimizer,"results/OPF_Solution_Experiment.txt")
#cd("C:\\Users\\braya\\.julia\\dev\\EPEC_CarbonTax\\test")
