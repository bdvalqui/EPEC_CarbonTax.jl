function Solver_EPEC_4firms(optimizer::Type{<:AbstractOptimizer},resultfile::String="",folder::String="")

#global data_prices_EPEC=zeros(3,24)
#global data_prices_CP=zeros(3,24)

global iterations=1:3

#Deterministic Equivalent------------------------------------------------------#
println("Loading inputs...")
println("Solving Central Planner to get initial conditions...")
#Run Central Planner to get initial conditions for the MPEC-EPEC

(syscost_det,x_w_value,x_e_value,set_opt_winds_numbertechnologies,set_opt_thermalgenerators_numbertechnologies,Total_Investments_Technology_CP)=Solver_CentralPlanner(optimizer,"results/CentralPlanner_Solution.txt")
println("")
println("Loading inputs EPEC...")
#Run MPEC
(set_thermalgenerators_options_numbertechnologies,set_wind_options_numbertechnologies,set_thermalgenerators_options,set_wind_options,set_thermalgenerators_existingunits,set_winds_existingunits,set_thermalgenerators,set_winds,set_demands,set_nodes,set_nodes_ref,set_nodes_noref,set_scenarios,set_times,P,V,thermal_ownership_options,wind_ownership_options,x_w_p,x_e_p,Leader, p_D,D,max_demand,Υ_SR,γ,Τ,p_lambda_upper,wind,Ns_H,n_link,links,links_rev,F_max_dict,B_dict,MapG,MapD,MapW,tech_thermal,tech_wind,capacity_per_unit,var_om,invcost,maxBuilds,ownership,capacity_existingunits,fixedcost,EmissionsRate,HeatRate,fuelprice,life,RamUP,Technology,WACC,varcost_thermal,varcost_wind,CRF_thermal,CRF_wind)=loadinputs_4firms(x_w_value,x_e_value,"data")

x_w_p_iter=zeros(length(set_winds),length(iterations))
x_e_p_iter=zeros(length(set_thermalgenerators),length(iterations))
#p_G_e_value_MPEC_iter_Firm3=zeros(length(set_thermalgenerators),length(set_times),length(set_scenarios),length(iterations))
#p_G_w_value_MPEC_iter_Firm3=zeros(length(set_winds),length(set_times),length(set_scenarios),length(iterations))

#=(data_prices_CP,data_prices_EPEC)=Plots_Prices(data_prices_CP,data_prices_EPEC,set_times,Τ)
Total_Investments_Technology_CP=zeros(7)
Total_Investments_Technology_EPEC=zeros(7)
Total_Investments_Technology_Firm1_EPEC=zeros(7)
Total_Investments_Technology_Firm2_EPEC=zeros(7)
=#

for iter in iterations
println("")
println("Iteration $iter...")
#Firm 1

global Leader=1
println("")
println("Firm $Leader Problem...")
println("")

(profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Totalrevenue_MPEC_Firm1,TotalOperatingCost_MPEC_Firm1,Totalrevenue_MPEC_Firm2,TotalOperatingCost_MPEC_Firm2,Totalrevenue_MPEC_Firm3,TotalOperatingCost_MPEC_Firm3,Totalrevenue_MPEC_Firm4,TotalOperatingCost_MPEC_Firm4, Electricity_prices_MPEC, Spinning_prices_MPEC, υ_SR_value_MPEC,p_G_e_value_MPEC, p_G_w_value_MPEC, p_G_e_value_node1_MPEC, p_G_e_value_node2_MPEC, p_G_e_value_node3_MPEC, p_G_w_value_node1_MPEC, p_G_w_value_node2_MPEC, p_G_w_value_node3_MPEC, Electricity_prices_MPEC, TotalCost_MPEC,TotalEmissions_MPEC,Totalrevenue_demandblock_MPEC_Firm1, TotalOperatingCost_demandblock_MPEC_Firm1,Totalrevenue_demandblock_MPEC_Firm2, TotalOperatingCost_demandblock_MPEC_Firm2, Totalrevenue_demandblock_MPEC_Firm3, TotalOperatingCost_demandblock_MPEC_Firm3, Totalrevenue_demandblock_MPEC_Firm4, TotalOperatingCost_demandblock_MPEC_Firm4,TotalCapCost_EPEC, TotalFixedCost_EPEC, TotalEmissionsCost_EPEC, TotalOperatingCost_EPEC,TotalCurtailmentcost_EPEC, Total_Investments_Technology_Firm1_EPEC,Total_Investments_Technology_Firm2_EPEC,Total_Investments_Technology_Firm3_EPEC,Total_Investments_Technology_EPEC,Total_Generation_Technology_EPEC,Total_Generation_Technology_Existing_EPEC,Total_Generation_Technology_Candidate_EPEC, Total_Generation_Technology_node1_EPEC, Total_Generation_Technology_node2_EPEC, Total_Generation_Technology_node3_EPEC)=Investment_OPF_MPEC_4firms(optimizer,set_thermalgenerators_options_numbertechnologies,set_wind_options_numbertechnologies,set_thermalgenerators_options,set_wind_options,set_thermalgenerators_existingunits,set_winds_existingunits,set_thermalgenerators,set_winds,set_demands,set_nodes,set_nodes_ref,set_nodes_noref,set_scenarios,set_times,P,V,thermal_ownership_options,wind_ownership_options,x_w_p,x_e_p,Leader, p_D,D,max_demand,Υ_SR,γ,Τ,p_lambda_upper,wind,Ns_H,n_link,links,links_rev,F_max_dict,B_dict,MapG,MapD,MapW,tech_thermal,tech_wind,capacity_per_unit,var_om,invcost,maxBuilds,ownership,capacity_existingunits,fixedcost,EmissionsRate,HeatRate,fuelprice,life,RamUP,Technology,WACC,varcost_thermal,varcost_wind,CRF_thermal,CRF_wind,set_opt_winds_numbertechnologies,set_opt_thermalgenerators_numbertechnologies)


for w in set_wind_options if wind_ownership_options[w]==Leader
global x_w_p[w]=x_w_value_MPEC[w]
global x_w_p_iter[w,iter]=x_w_value_MPEC[w]
end
end

for e in set_thermalgenerators_options if thermal_ownership_options[e]==Leader
global x_e_p[e]=x_e_value_MPEC[e]
global x_e_p_iter[e,iter]=x_e_value_MPEC[e]
end
end

global Leader=2
println("")
println("Firm $Leader Problem...")
println("")

(profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Totalrevenue_MPEC_Firm1,TotalOperatingCost_MPEC_Firm1,Totalrevenue_MPEC_Firm2,TotalOperatingCost_MPEC_Firm2,Totalrevenue_MPEC_Firm3,TotalOperatingCost_MPEC_Firm3,Totalrevenue_MPEC_Firm4,TotalOperatingCost_MPEC_Firm4, Electricity_prices_MPEC, Spinning_prices_MPEC, υ_SR_value_MPEC,p_G_e_value_MPEC, p_G_w_value_MPEC, p_G_e_value_node1_MPEC, p_G_e_value_node2_MPEC, p_G_e_value_node3_MPEC, p_G_w_value_node1_MPEC, p_G_w_value_node2_MPEC, p_G_w_value_node3_MPEC, Electricity_prices_MPEC, TotalCost_MPEC,TotalEmissions_MPEC,Totalrevenue_demandblock_MPEC_Firm1, TotalOperatingCost_demandblock_MPEC_Firm1,Totalrevenue_demandblock_MPEC_Firm2, TotalOperatingCost_demandblock_MPEC_Firm2, Totalrevenue_demandblock_MPEC_Firm3, TotalOperatingCost_demandblock_MPEC_Firm3, Totalrevenue_demandblock_MPEC_Firm4, TotalOperatingCost_demandblock_MPEC_Firm4,TotalCapCost_EPEC, TotalFixedCost_EPEC, TotalEmissionsCost_EPEC, TotalOperatingCost_EPEC,TotalCurtailmentcost_EPEC, Total_Investments_Technology_Firm1_EPEC,Total_Investments_Technology_Firm2_EPEC,Total_Investments_Technology_Firm3_EPEC,Total_Investments_Technology_EPEC,Total_Generation_Technology_EPEC,Total_Generation_Technology_Existing_EPEC,Total_Generation_Technology_Candidate_EPEC, Total_Generation_Technology_node1_EPEC, Total_Generation_Technology_node2_EPEC, Total_Generation_Technology_node3_EPEC)=Investment_OPF_MPEC_4firms(optimizer,set_thermalgenerators_options_numbertechnologies,set_wind_options_numbertechnologies,set_thermalgenerators_options,set_wind_options,set_thermalgenerators_existingunits,set_winds_existingunits,set_thermalgenerators,set_winds,set_demands,set_nodes,set_nodes_ref,set_nodes_noref,set_scenarios,set_times,P,V,thermal_ownership_options,wind_ownership_options,x_w_p,x_e_p,Leader, p_D,D,max_demand,Υ_SR,γ,Τ,p_lambda_upper,wind,Ns_H,n_link,links,links_rev,F_max_dict,B_dict,MapG,MapD,MapW,tech_thermal,tech_wind,capacity_per_unit,var_om,invcost,maxBuilds,ownership,capacity_existingunits,fixedcost,EmissionsRate,HeatRate,fuelprice,life,RamUP,Technology,WACC,varcost_thermal,varcost_wind,CRF_thermal,CRF_wind,set_opt_winds_numbertechnologies,set_opt_thermalgenerators_numbertechnologies)

for w in set_wind_options if wind_ownership_options[w]==Leader
global x_w_p[w]=x_w_value_MPEC[w]
global x_w_p_iter[w,iter]=x_w_value_MPEC[w]
end
end

for e in set_thermalgenerators_options if thermal_ownership_options[e]==Leader
global x_e_p[e]=x_e_value_MPEC[e]
global x_e_p_iter[e,iter]=x_e_value_MPEC[e]
end
end

global Leader=3
println("")
println("Firm $Leader Problem...")
println("")

(profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Totalrevenue_MPEC_Firm1,TotalOperatingCost_MPEC_Firm1,Totalrevenue_MPEC_Firm2,TotalOperatingCost_MPEC_Firm2,Totalrevenue_MPEC_Firm3,TotalOperatingCost_MPEC_Firm3,Totalrevenue_MPEC_Firm4,TotalOperatingCost_MPEC_Firm4, Electricity_prices_MPEC, Spinning_prices_MPEC, υ_SR_value_MPEC,p_G_e_value_MPEC, p_G_w_value_MPEC, p_G_e_value_node1_MPEC, p_G_e_value_node2_MPEC, p_G_e_value_node3_MPEC, p_G_w_value_node1_MPEC, p_G_w_value_node2_MPEC, p_G_w_value_node3_MPEC, Electricity_prices_MPEC, TotalCost_MPEC,TotalEmissions_MPEC,Totalrevenue_demandblock_MPEC_Firm1, TotalOperatingCost_demandblock_MPEC_Firm1,Totalrevenue_demandblock_MPEC_Firm2, TotalOperatingCost_demandblock_MPEC_Firm2, Totalrevenue_demandblock_MPEC_Firm3, TotalOperatingCost_demandblock_MPEC_Firm3, Totalrevenue_demandblock_MPEC_Firm4, TotalOperatingCost_demandblock_MPEC_Firm4,TotalCapCost_EPEC, TotalFixedCost_EPEC, TotalEmissionsCost_EPEC, TotalOperatingCost_EPEC,TotalCurtailmentcost_EPEC, Total_Investments_Technology_Firm1_EPEC,Total_Investments_Technology_Firm2_EPEC,Total_Investments_Technology_Firm3_EPEC,Total_Investments_Technology_EPEC,Total_Generation_Technology_EPEC,Total_Generation_Technology_Existing_EPEC,Total_Generation_Technology_Candidate_EPEC, Total_Generation_Technology_node1_EPEC, Total_Generation_Technology_node2_EPEC, Total_Generation_Technology_node3_EPEC)=Investment_OPF_MPEC_4firms(optimizer,set_thermalgenerators_options_numbertechnologies,set_wind_options_numbertechnologies,set_thermalgenerators_options,set_wind_options,set_thermalgenerators_existingunits,set_winds_existingunits,set_thermalgenerators,set_winds,set_demands,set_nodes,set_nodes_ref,set_nodes_noref,set_scenarios,set_times,P,V,thermal_ownership_options,wind_ownership_options,x_w_p,x_e_p,Leader, p_D,D,max_demand,Υ_SR,γ,Τ,p_lambda_upper,wind,Ns_H,n_link,links,links_rev,F_max_dict,B_dict,MapG,MapD,MapW,tech_thermal,tech_wind,capacity_per_unit,var_om,invcost,maxBuilds,ownership,capacity_existingunits,fixedcost,EmissionsRate,HeatRate,fuelprice,life,RamUP,Technology,WACC,varcost_thermal,varcost_wind,CRF_thermal,CRF_wind,set_opt_winds_numbertechnologies,set_opt_thermalgenerators_numbertechnologies)

for w in set_wind_options if wind_ownership_options[w]==Leader
global x_w_p[w]=x_w_value_MPEC[w]
global x_w_p_iter[w,iter]=x_w_value_MPEC[w]
end
end

for e in set_thermalgenerators_options if thermal_ownership_options[e]==Leader
global x_e_p[e]=x_e_value_MPEC[e]
global x_e_p_iter[e,iter]=x_e_value_MPEC[e]
end
end

end

global TotalCost_Emissions=zeros(4)
global TotalCost_Emissions[3]=TotalCost_MPEC
global TotalCost_Emissions[4]=TotalEmissions_MPEC

global profit_det_MPEC_val=profit_det_MPEC

global revenue_cost_EPEC=zeros(8)
global revenue_cost_EPEC[1]=Totalrevenue_MPEC_Firm1
global revenue_cost_EPEC[2]=TotalOperatingCost_MPEC_Firm1
global revenue_cost_EPEC[3]=Totalrevenue_MPEC_Firm2
global revenue_cost_EPEC[4]=TotalOperatingCost_MPEC_Firm2
global revenue_cost_EPEC[5]=Totalrevenue_MPEC_Firm3
global revenue_cost_EPEC[6]=TotalOperatingCost_MPEC_Firm3
global revenue_cost_EPEC[7]=Totalrevenue_MPEC_Firm4
global revenue_cost_EPEC[8]=TotalOperatingCost_MPEC_Firm4

global data_prices_EPEC=Electricity_prices_MPEC[:,:,1]

global df_revenue_cost_EPEC= DataFrame(revenue_cost_EPEC',:auto)
global df_EPEC_prices = DataFrame(Electricity_prices_MPEC[:,:,1], :auto)
global df_EPEC_spinning_prices = DataFrame(Spinning_prices_MPEC[:,1]', :auto)
global df_EPEC_spinning_reserves= DataFrame(υ_SR_value_MPEC[:,:,1], :auto)
global df_EPEC_thermalinvestments = DataFrame(x_e_p_iter,:auto)
global df_EPEC_windinvestments = DataFrame(x_w_p_iter,:auto)
global df_EPEC_thermalgeneration =  DataFrame(p_G_e_value_MPEC[:,:,1], :auto)
global df_EPEC_windgeneration =  DataFrame(p_G_w_value_MPEC[:,:,1], :auto)
global df_node1_EPEC_thermalgeneration =  DataFrame(p_G_e_value_node1_MPEC[:,:,1], :auto)
global df_node2_EPEC_thermalgeneration =  DataFrame(p_G_e_value_node2_MPEC[:,:,1], :auto)
global df_node3_EPEC_thermalgeneration =  DataFrame(p_G_e_value_node3_MPEC[:,:,1], :auto)
global df_node1_EPEC_windgeneration =  DataFrame(p_G_w_value_node1_MPEC[:,:,1], :auto)
global df_node2_EPEC_windgeneration =  DataFrame(p_G_w_value_node2_MPEC[:,:,1], :auto)
global df_node3_EPEC_windgeneration =  DataFrame(p_G_w_value_node3_MPEC[:,:,1], :auto)

global df_Total_Investments_Technology_Firm1_EPEC=DataFrame(Total_Investments_Technology_Firm1_EPEC',:auto)

global df_Total_Investments_Technology_Firm2_EPEC=DataFrame(Total_Investments_Technology_Firm2_EPEC',:auto)

global df_Total_Investments_Technology_Firm3_EPEC=DataFrame(Total_Investments_Technology_Firm3_EPEC',:auto)

global Total_Revenue_Cost_demandblock_EPEC=zeros(length(set_times),8)

for t in set_times
global Total_Revenue_Cost_demandblock_EPEC[t,1]=Totalrevenue_demandblock_MPEC_Firm1[t]
global Total_Revenue_Cost_demandblock_EPEC[t,2]=TotalOperatingCost_demandblock_MPEC_Firm1[t]
global Total_Revenue_Cost_demandblock_EPEC[t,3]=Totalrevenue_demandblock_MPEC_Firm2[t]
global Total_Revenue_Cost_demandblock_EPEC[t,4]=TotalOperatingCost_demandblock_MPEC_Firm2[t]
global Total_Revenue_Cost_demandblock_EPEC[t,5]=Totalrevenue_demandblock_MPEC_Firm3[t]
global Total_Revenue_Cost_demandblock_EPEC[t,6]=TotalOperatingCost_demandblock_MPEC_Firm3[t]
global Total_Revenue_Cost_demandblock_EPEC[t,7]=Totalrevenue_demandblock_MPEC_Firm4[t]
global Total_Revenue_Cost_demandblock_EPEC[t,8]=TotalOperatingCost_demandblock_MPEC_Firm4[t]
end

global df_Total_Revenue_Cost_demandblock_EPEC = DataFrame(Total_Revenue_Cost_demandblock_EPEC,:auto)

global Cost_Detail=zeros(5,2)

global Cost_Detail[1,2]=TotalCapCost_EPEC
global Cost_Detail[2,2]=TotalFixedCost_EPEC
global Cost_Detail[3,2]=TotalEmissionsCost_EPEC
global Cost_Detail[4,2]=TotalOperatingCost_EPEC
global Cost_Detail[5,2]=TotalCurtailmentcost_EPEC

global Total_Investments_Technology_EPEC_par=Total_Investments_Technology_EPEC
global Total_Investments_Technology_Firm1_EPEC_par=Total_Investments_Technology_Firm1_EPEC
global Total_Investments_Technology_Firm2_EPEC_par=Total_Investments_Technology_Firm2_EPEC
global Total_Investments_Technology_Firm3_EPEC_par=Total_Investments_Technology_Firm3_EPEC

global Total_Generation_Technology_EPEC_par=Total_Generation_Technology_EPEC
global Total_Generation_Technology_Existing_EPEC_par=Total_Generation_Technology_Existing_EPEC
global Total_Generation_Technology_Candidate_EPEC_par=Total_Generation_Technology_Candidate_EPEC
global Total_Generation_Technology_node1_EPEC_par=Total_Generation_Technology_node1_EPEC
global Total_Generation_Technology_node2_EPEC_par=Total_Generation_Technology_node2_EPEC
global Total_Generation_Technology_node3_EPEC_par=Total_Generation_Technology_node3_EPEC
println("")
println("")
println("End of iteration $iter...")
println("")
println("------------------------------------------------------------------------------")
end

#Central Planner

df_CP_thermalinvestments = DataFrame(x_e_value',:auto)
df_CP_windinvestments = DataFrame(x_w_value',:auto)

(syscost_det_OPF,TotalEmissions,TotalRevenue_demandblock,TotalOpecost_demandblock,revenue_cost_CP,TotalCapCost,TotalFixedCost,TotalEmissionsCost,TotalOpecost,TotalCurtailmentcost,p_G_e_value_CP,p_G_e_value_node1_CP,p_G_e_value_node2_CP,p_G_e_value_node3_CP,p_G_w_value_CP,p_G_w_value_node1_CP,p_G_w_value_node2_CP,p_G_w_value_node3_CP,υ_SR_value_CP,Dual_constraint10,Dual_constraint11,Total_Generation_Technology_CP,Total_Generation_Technology_Existing_CP,Total_Generation_Technology_Candidate_CP, Total_Generation_Technology_node1_CP, Total_Generation_Technology_node2_CP, Total_Generation_Technology_node3_CP)=Solver_OPF(optimizer,"results/OPF_Solution.txt")


#===================================#
df_revenue_cost_CP= DataFrame(revenue_cost_CP',:auto)
df_CP_prices = DataFrame(Dual_constraint10[:,:,1], :auto)
df_CP_spinning_prices = DataFrame(Dual_constraint11[:,1]', :auto)
df_CP_spinning_reserves = DataFrame(υ_SR_value_CP[:,:,1], :auto)
df_CP_thermalgeneration =  DataFrame(p_G_e_value_CP[:,:,1], :auto)
df_node1_CP_thermalgeneration =  DataFrame(p_G_e_value_node1_CP[:,:,1], :auto)
df_node2_CP_thermalgeneration =  DataFrame(p_G_e_value_node2_CP[:,:,1], :auto)
df_node3_CP_thermalgeneration =  DataFrame(p_G_e_value_node3_CP[:,:,1], :auto)
df_CP_windgeneration =  DataFrame(p_G_w_value_CP[:,:,1], :auto)
df_node1_CP_windgeneration =  DataFrame(p_G_w_value_node1_CP[:,:,1], :auto)
df_node2_CP_windgeneration =  DataFrame(p_G_w_value_node2_CP[:,:,1], :auto)
df_node3_CP_windgeneration =  DataFrame(p_G_w_value_node3_CP[:,:,1], :auto)

global data_prices_CP=Dual_constraint10[:,:,1]

CSV.write(folder *"/Results_revenue_cost_CP$Τ.csv", df_revenue_cost_CP)
CSV.write(folder *"/Results_prices_CP$Τ.csv", df_CP_prices)
CSV.write(folder *"/Results_prices_spinning_CP$Τ.csv", df_CP_spinning_prices)
CSV.write(folder *"/Results_reserves_spinning_CP$Τ.csv", df_CP_spinning_reserves)
CSV.write(folder *"/Results_thermalgeneration_CP$Τ.csv", df_CP_thermalgeneration)
CSV.write(folder *"/Results_thermalgeneration_node1_CP$Τ.csv", df_node1_CP_thermalgeneration)
CSV.write(folder *"/Results_thermalgeneration_node2_CP$Τ.csv", df_node2_CP_thermalgeneration)
CSV.write(folder *"/Results_thermalgeneration_node3_CP$Τ.csv", df_node3_CP_thermalgeneration)
CSV.write(folder *"/Results_windgeneration_CP$Τ.csv", df_CP_windgeneration)
CSV.write(folder *"/Results_windgeneration_node1_CP$Τ.csv", df_node1_CP_windgeneration)
CSV.write(folder *"/Results_windgeneration_node2_CP$Τ.csv", df_node2_CP_windgeneration)
CSV.write(folder *"/Results_windgeneration_node3_CP$Τ.csv", df_node3_CP_windgeneration)
CSV.write(folder *"/Results_thermalinvestments_CP$Τ.csv", df_CP_thermalinvestments)
CSV.write(folder *"/Results_windinvestments_CP$Τ.csv", df_CP_windinvestments)

global TotalCost_Emissions[1]=syscost_det
global TotalCost_Emissions[2]=TotalEmissions

df_TotalCost_Emissions = DataFrame(TotalCost_Emissions', :auto)
CSV.write(folder *"/Results_Total_Cost_Emissions$Τ.csv", df_TotalCost_Emissions)

global Total_Revenue_Cost_demandblock_CP=zeros(length(set_times),2)

for t in set_times
global Total_Revenue_Cost_demandblock_CP[t,1]=TotalRevenue_demandblock[t]
global Total_Revenue_Cost_demandblock_CP[t,2]=TotalOpecost_demandblock[t]
end

df_Total_Revenue_Cost_demandblock_CP = DataFrame(Total_Revenue_Cost_demandblock_CP,:auto)

CSV.write(folder *"/Results_Total_Revenue_Cost_demandblock_CP$Τ.csv", df_Total_Revenue_Cost_demandblock_CP)

global Cost_Detail[1,1]=TotalCapCost
global Cost_Detail[2,1]=TotalFixedCost
global Cost_Detail[3,1]=TotalEmissionsCost
global Cost_Detail[4,1]=TotalOpecost
global Cost_Detail[5,1]=TotalCurtailmentcost

df_Cost_Detail=DataFrame(Cost_Detail,:auto)
CSV.write(folder *"/Results_Total_Detail_Cost$Τ.csv", df_Cost_Detail)

#EPEC

df_EPEC_thermalinvestments = DataFrame(x_e_p_iter,:auto)
df_EPEC_windinvestments = DataFrame(x_w_p_iter,:auto)

CSV.write(folder *"/Results_thermalinvestments_EPEC$Τ.csv", df_EPEC_thermalinvestments)
CSV.write(folder *"/Results_windinvestments_EPEC$Τ.csv", df_EPEC_windinvestments)

CSV.write(folder *"/Results_revenue_cost_EPEC$Τ.csv", df_revenue_cost_EPEC)
CSV.write(folder *"/Results_prices_EPEC$Τ.csv", df_EPEC_prices)
CSV.write(folder *"/Results_spinning_prices_EPEC$Τ.csv", df_EPEC_spinning_prices)
CSV.write(folder *"/Results_spinning_reserves_EPEC$Τ.csv", df_EPEC_spinning_reserves)
CSV.write(folder *"/Results_thermalgeneration_EPEC$Τ.csv", df_EPEC_thermalgeneration)
CSV.write(folder *"/Results_thermalgeneration_node1_EPEC$Τ.csv", df_node1_EPEC_thermalgeneration)
CSV.write(folder *"/Results_thermalgeneration_node2_EPEC$Τ.csv", df_node2_EPEC_thermalgeneration)
CSV.write(folder *"/Results_thermalgeneration_node3_EPEC$Τ.csv", df_node3_EPEC_thermalgeneration)
CSV.write(folder *"/Results_windgeneration_EPEC$Τ.csv", df_EPEC_windgeneration)
CSV.write(folder *"/Results_windgeneration_node1_EPEC$Τ.csv", df_node1_EPEC_windgeneration)
CSV.write(folder *"/Results_windgeneration_node2_EPEC$Τ.csv", df_node2_EPEC_windgeneration)
CSV.write(folder *"/Results_windgeneration_node3_EPEC$Τ.csv", df_node3_EPEC_windgeneration)
CSV.write(folder *"/Results_thermalinvestments_EPEC$Τ.csv", df_EPEC_thermalinvestments)
CSV.write(folder *"/Results_windinvestments_EPEC$Τ.csv", df_EPEC_windinvestments)

CSV.write(folder *"/Results_Total_Revenue_Cost_demandblock_EPEC$Τ.csv", df_Total_Revenue_Cost_demandblock_EPEC)

CSV.write(folder *"/Results_Total_Investments_Firm1_EPEC$Τ.csv", df_Total_Investments_Technology_Firm1_EPEC)

CSV.write(folder *"/Results_Total_Investments_Firm2_EPEC$Τ.csv", df_Total_Investments_Technology_Firm2_EPEC)

CSV.write(folder *"/Results_Total_Investments_Firm3_EPEC$Τ.csv", df_Total_Investments_Technology_Firm3_EPEC)


(data_prices_CP_res,data_prices_EPEC_res)=Plots_Prices(data_prices_CP,data_prices_EPEC,set_times,Τ)

(Total_Investments_Technology_CP_res,Total_Investments_Technology_EPEC_res)=Plots_CapacityMix_4firms(Total_Investments_Technology_CP,Total_Investments_Technology_EPEC_par,Total_Investments_Technology_Firm1_EPEC_par,Total_Investments_Technology_Firm2_EPEC_par,Total_Investments_Technology_Firm3_EPEC_par,Τ)

(Total_Generation_Technology_CP_res)=Plots_Generation(Total_Generation_Technology_CP,Total_Generation_Technology_Existing_CP,Total_Generation_Technology_Candidate_CP, Total_Generation_Technology_node1_CP, Total_Generation_Technology_node2_CP, Total_Generation_Technology_node3_CP,Total_Generation_Technology_EPEC_par,Total_Generation_Technology_Existing_EPEC_par,Total_Generation_Technology_Candidate_EPEC_par, Total_Generation_Technology_node1_EPEC_par, Total_Generation_Technology_node2_EPEC_par, Total_Generation_Technology_node3_EPEC_par,set_times,Τ)

(Total_Revenue_Cost_demandblock_CP_res)=Plots_Rev_Ope_4firms(Total_Revenue_Cost_demandblock_CP,Total_Revenue_Cost_demandblock_EPEC,set_times,Τ)

#(Total_Investments_Technology_CP_res,Total_Investments_Technology_EPEC_res)=Plots_CapacityMix(Total_Investments_Technology_CP,Total_Investments_Technology_EPEC,Total_Investments_Technology_Firm1_EPEC,Total_Investments_Technology_Firm2_EPEC)

resultfile != "" && open(resultfile, truncate = true) do f

    println(f,"*****************EPEC Solution*****************")
    println(f,"")
    println(f,"Objective Function (Firm $Leader): ",profit_det_MPEC_val)
    println(f,"")
    println(f,"Wind Investments per iteration: ",x_w_p)
    println(f,"")
    println(f,"Thermal Investments per iteration: ",x_e_p)
    end


return (profit_det_MPEC_val,x_w_p,x_e_p)
end
