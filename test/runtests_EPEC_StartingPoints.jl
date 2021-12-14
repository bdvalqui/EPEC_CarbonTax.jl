using EPEC_CarbonTax
using Test
using Gurobi
#using GLPK
#using CPLEX


println("*****************EPEC Solution*****************")

#@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC)=Solver_EPEC(Gurobi.Optimizer,"results/EPEC_Solution.txt","results")

#Number of Starting Points
Number_Runs=20
equilibrium_investments=zeros(7,Number_Runs)

share_starting_1_renew=0
share_starting_1_thermal=1
start_point=1

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Diag_StartingPoints(share_starting_1_renew,share_starting_1_thermal,start_point,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

share_starting_1_renew=0.1
share_starting_1_thermal=0.9
start_point=2

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Diag_StartingPoints(share_starting_1_renew,share_starting_1_thermal,start_point,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

share_starting_1_renew=0.2
share_starting_1_thermal=0.8
start_point=3

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Diag_StartingPoints(share_starting_1_renew,share_starting_1_thermal,start_point,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

share_starting_1_renew=0.3
share_starting_1_thermal=0.7
start_point=4

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Diag_StartingPoints(share_starting_1_renew,share_starting_1_thermal,start_point,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

share_starting_1_renew=0.4
share_starting_1_thermal=0.6
start_point=5

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Diag_StartingPoints(share_starting_1_renew,share_starting_1_thermal,start_point,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par


share_starting_1_renew=0.5
share_starting_1_thermal=0.5
start_point=6

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Diag_StartingPoints(share_starting_1_renew,share_starting_1_thermal,start_point,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

share_starting_1_renew=0.6
share_starting_1_thermal=0.4
start_point=7

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Diag_StartingPoints(share_starting_1_renew,share_starting_1_thermal,start_point,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

share_starting_1_renew=0.7
share_starting_1_thermal=0.3
start_point=8

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Diag_StartingPoints(share_starting_1_renew,share_starting_1_thermal,start_point,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

share_starting_1_renew=0.8
share_starting_1_thermal=0.2
start_point=9

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Diag_StartingPoints(share_starting_1_renew,share_starting_1_thermal,start_point,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

share_starting_1_renew=0.9
share_starting_1_thermal=0.1
start_point=10

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Diag_StartingPoints(share_starting_1_renew,share_starting_1_thermal,start_point,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

share_starting_1_renew=1
share_starting_1_thermal=0
start_point=11

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Diag_StartingPoints(share_starting_1_renew,share_starting_1_thermal,start_point,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

share_starting_1_renew=1.1
share_starting_1_thermal=0.1
start_point=12

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Diag_StartingPoints(share_starting_1_renew,share_starting_1_thermal,start_point,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

share_starting_1_renew=1.2
share_starting_1_thermal=0.2
start_point=13

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Diag_StartingPoints(share_starting_1_renew,share_starting_1_thermal,start_point,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par


share_starting_1_renew=1.3
share_starting_1_thermal=0.3
start_point=13

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Diag_StartingPoints(share_starting_1_renew,share_starting_1_thermal,start_point,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par


share_starting_1_renew=1.4
share_starting_1_thermal=0.4
start_point=14

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Diag_StartingPoints(share_starting_1_renew,share_starting_1_thermal,start_point,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par


share_starting_1_renew=1.5
share_starting_1_thermal=0.5
start_point=15

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Diag_StartingPoints(share_starting_1_renew,share_starting_1_thermal,start_point,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

share_starting_1_renew=0.1
share_starting_1_thermal=1.1
start_point=16

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Diag_StartingPoints(share_starting_1_renew,share_starting_1_thermal,start_point,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

share_starting_1_renew=0.2
share_starting_1_thermal=1.2
start_point=17

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Diag_StartingPoints(share_starting_1_renew,share_starting_1_thermal,start_point,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

share_starting_1_renew=0.3
share_starting_1_thermal=1.3
start_point=18

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Diag_StartingPoints(share_starting_1_renew,share_starting_1_thermal,start_point,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

share_starting_1_renew=0.4
share_starting_1_thermal=1.4
start_point=19

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Diag_StartingPoints(share_starting_1_renew,share_starting_1_thermal,start_point,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

share_starting_1_renew=0.5
share_starting_1_thermal=1.5
start_point=20

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Diag_StartingPoints(share_starting_1_renew,share_starting_1_thermal,start_point,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par


(equilibrium_investments_sol)=Plots_CapacityMix_All_Solutions(equilibrium_investments,Number_Runs,"results_startingpoints")


#cd("C:\\Users\\braya\\.julia\\dev\\EPEC_CarbonTax\\test")
