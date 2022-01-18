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

set_wind_options_par=[13;14;15;16;17;18;19;20]
set_thermalgenerators_options_par=[25;26;27;28;29;30;31;32;33;34;35;36;37;38;39;40;41;42;43;44]
n_Gas_CT=1:4
set_Gac_CT=[27;32;37;42]
index_Gas_CT=[1;2;1;2]

n_Gas_CC_CCS=1:4
set_Gac_CC_CCS=[29;34;39;44]
index_Gas_CC_CCS=[1;2;1;2]

n_Solar=1:4
set_Solar=[14,16,18,20]
index_Solar=[1;2;1;2]
#========================================================================================================================#
#Firm A's decisions are variables. Firm B's decisions are parameters (Leader=1)

start_point=1

(x_w_p,x_e_p)=loadinputs_Reaction_Investments("data_reaction_function/$start_point")

Leader=1
Follower=2

#=
for i in n_Gas_CT if index_Gas_CT[i]==Leader
deleteat!(set_thermalgenerators_options_par, findall(x->x==set_Gac_CT[i],set_thermalgenerators_options_par))
end
end


for i in n_Gas_CC_CCS if index_Gas_CC_CCS[i]==Leader
deleteat!(set_thermalgenerators_options_par, findall(x->x==set_Gac_CC_CCS[i],set_thermalgenerators_options_par))
end
end
=#
for i in n_Solar if index_Solar[i]==Leader
deleteat!(set_wind_options_par, findall(x->x==set_Solar[i],set_wind_options_par))
end
end

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Reaction(x_w_p,x_e_p,start_point,Leader,Follower,set_thermalgenerators_options_par,set_wind_options_par,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

start_point=2

(x_w_p,x_e_p)=loadinputs_Reaction_Investments("data_reaction_function/$start_point")

Leader=1
Follower=2

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Reaction(x_w_p,x_e_p,start_point,Leader,Follower,set_thermalgenerators_options_par,set_wind_options_par,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par


start_point=3

(x_w_p,x_e_p)=loadinputs_Reaction_Investments("data_reaction_function/$start_point")

Leader=1
Follower=2
@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Reaction(x_w_p,x_e_p,start_point,Leader,Follower,set_thermalgenerators_options_par,set_wind_options_par,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

start_point=4

(x_w_p,x_e_p)=loadinputs_Reaction_Investments("data_reaction_function/$start_point")

Leader=1
Follower=2
@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Reaction(x_w_p,x_e_p,start_point,Leader,Follower,set_thermalgenerators_options_par,set_wind_options_par,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

start_point=5

(x_w_p,x_e_p)=loadinputs_Reaction_Investments("data_reaction_function/$start_point")

Leader=1
Follower=2
@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Reaction(x_w_p,x_e_p,start_point,Leader,Follower,set_thermalgenerators_options_par,set_wind_options_par,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

start_point=6

(x_w_p,x_e_p)=loadinputs_Reaction_Investments("data_reaction_function/$start_point")

Leader=1
Follower=2
@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Reaction(x_w_p,x_e_p,start_point,Leader,Follower,set_thermalgenerators_options_par,set_wind_options_par,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

start_point=7

(x_w_p,x_e_p)=loadinputs_Reaction_Investments("data_reaction_function/$start_point")

Leader=1
Follower=2
@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Reaction(x_w_p,x_e_p,start_point,Leader,Follower,set_thermalgenerators_options_par,set_wind_options_par,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

start_point=8

(x_w_p,x_e_p)=loadinputs_Reaction_Investments("data_reaction_function/$start_point")

Leader=1
Follower=2
@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Reaction(x_w_p,x_e_p,start_point,Leader,Follower,set_thermalgenerators_options_par,set_wind_options_par,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

start_point=9

(x_w_p,x_e_p)=loadinputs_Reaction_Investments("data_reaction_function/$start_point")

Leader=1
Follower=2
@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Reaction(x_w_p,x_e_p,start_point,Leader,Follower,set_thermalgenerators_options_par,set_wind_options_par,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

start_point=10

(x_w_p,x_e_p)=loadinputs_Reaction_Investments("data_reaction_function/$start_point")

Leader=1
Follower=2
@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Reaction(x_w_p,x_e_p,start_point,Leader,Follower,set_thermalgenerators_options_par,set_wind_options_par,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par
#========================================================================================================================#
#========================================================================================================================#
#========================================================================================================================#
#Firm B's decisions are variables. Firm A's decisions are parameters (Leader=2)

set_wind_options_par=[13;14;15;16;17;18;19;20]
set_thermalgenerators_options_par=[25;26;27;28;29;30;31;32;33;34;35;36;37;38;39;40;41;42;43;44]

start_point=11

(x_w_p,x_e_p)=loadinputs_Reaction_Investments("data_reaction_function/$start_point")

Leader=2
Follower=1

#=
for i in n_Gas_CT if index_Gas_CT[i]==Leader
deleteat!(set_thermalgenerators_options_par, findall(x->x==set_Gac_CT[i],set_thermalgenerators_options_par))
end
end
=#

for i in n_Gas_CC_CCS if index_Gas_CC_CCS[i]==Leader
deleteat!(set_thermalgenerators_options_par, findall(x->x==set_Gac_CC_CCS[i],set_thermalgenerators_options_par))
end
end

for i in n_Solar if index_Solar[i]==Leader
deleteat!(set_wind_options_par, findall(x->x==set_Solar[i],set_wind_options_par))
end
end

@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Reaction(x_w_p,x_e_p,start_point,Leader,Follower,set_thermalgenerators_options_par,set_wind_options_par,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

start_point=12

(x_w_p,x_e_p)=loadinputs_Reaction_Investments("data_reaction_function/$start_point")

Leader=2
Follower=1
@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Reaction(x_w_p,x_e_p,start_point,Leader,Follower,set_thermalgenerators_options_par,set_wind_options_par,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

start_point=13

(x_w_p,x_e_p)=loadinputs_Reaction_Investments("data_reaction_function/$start_point")

Leader=2
Follower=1
@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Reaction(x_w_p,x_e_p,start_point,Leader,Follower,set_thermalgenerators_options_par,set_wind_options_par,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

start_point=14

(x_w_p,x_e_p)=loadinputs_Reaction_Investments("data_reaction_function/$start_point")

Leader=2
Follower=1
@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Reaction(x_w_p,x_e_p,start_point,Leader,Follower,set_thermalgenerators_options_par,set_wind_options_par,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par

start_point=15

(x_w_p,x_e_p)=loadinputs_Reaction_Investments("data_reaction_function/$start_point")

Leader=2
Follower=1
@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Reaction(x_w_p,x_e_p,start_point,Leader,Follower,set_thermalgenerators_options_par,set_wind_options_par,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par


start_point=16

(x_w_p,x_e_p)=loadinputs_Reaction_Investments("data_reaction_function/$start_point")

Leader=2
Follower=1
@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Reaction(x_w_p,x_e_p,start_point,Leader,Follower,set_thermalgenerators_options_par,set_wind_options_par,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par


start_point=17

(x_w_p,x_e_p)=loadinputs_Reaction_Investments("data_reaction_function/$start_point")

Leader=2
Follower=1
@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Reaction(x_w_p,x_e_p,start_point,Leader,Follower,set_thermalgenerators_options_par,set_wind_options_par,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par


start_point=18

(x_w_p,x_e_p)=loadinputs_Reaction_Investments("data_reaction_function/$start_point")

Leader=2
Follower=1
@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Reaction(x_w_p,x_e_p,start_point,Leader,Follower,set_thermalgenerators_options_par,set_wind_options_par,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par


start_point=19

(x_w_p,x_e_p)=loadinputs_Reaction_Investments("data_reaction_function/$start_point")

Leader=2
Follower=1
@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Reaction(x_w_p,x_e_p,start_point,Leader,Follower,set_thermalgenerators_options_par,set_wind_options_par,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par


start_point=20

(x_w_p,x_e_p)=loadinputs_Reaction_Investments("data_reaction_function/$start_point")

Leader=2
Follower=1
@time (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firms_EPEC_par)=Solver_EPEC_Reaction(x_w_p,x_e_p,start_point,Leader,Follower,set_thermalgenerators_options_par,set_wind_options_par,Gurobi.Optimizer,"results/EPEC_Solution.txt","results_startingpoints/$start_point")

equilibrium_investments[:,start_point]=Total_Investments_Technology_EPEC_par


#(equilibrium_investments_sol)=Plots_CapacityMix_All_Solutions(equilibrium_investments,Number_Runs,Profits_Objective_Function,"results_startingpoints")



#cd("C:\\Users\\braya\\.julia\\dev\\EPEC_CarbonTax\\test")
