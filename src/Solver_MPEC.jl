function Solver_MPEC(optimizer::Type{<:AbstractOptimizer},resultfile::String="")

#Deterministic Equivalent------------------------------------------------------#
println("Loading inputs...")

#Run Central Planner to get initial conditions for the MPEC-EPEC

(syscost_det,x_w_value,x_e_value,set_opt_winds_numbertechnologies,set_opt_thermalgenerators_numbertechnologies,Total_Investments_Technology_CP)=Solver_CentralPlanner(optimizer,"results/CentralPlanner_Solution.txt")

#Run MPEC
(set_thermalgenerators_options_numbertechnologies,set_wind_options_numbertechnologies,set_thermalgenerators_options,set_wind_options,set_thermalgenerators_existingunits,set_winds_existingunits,set_thermalgenerators,set_winds,set_demands,set_nodes,set_nodes_ref,set_nodes_noref,set_scenarios,set_times,P,V,thermal_ownership_options,wind_ownership_options,x_w_p,x_e_p,Leader, p_D,D,max_demand,Υ_SR,γ,Τ,p_lambda_upper,wind,Ns_H,n_link,links,links_rev,F_max_dict,B_dict,MapG,MapD,MapW,tech_thermal,tech_wind,capacity_per_unit,var_om,invcost,maxBuilds,ownership,capacity_existingunits,fixedcost,EmissionsRate,HeatRate,fuelprice,life,RamUP,Technology,WACC,varcost_thermal,varcost_wind,CRF_thermal,CRF_wind)=loadinputs(x_w_value,x_e_value,"data")

(profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Totalrevenue_MPEC_Firm1,TotalOperatingCost_MPEC_Firm1,Totalrevenue_MPEC_Firm2,TotalOperatingCost_MPEC_Firm2,Totalrevenue_MPEC_Firm3,TotalOperatingCost_MPEC_Firm3, Electricity_prices_MPEC, Spinning_prices_MPEC, υ_SR_value_MPEC,p_G_e_value_MPEC, p_G_w_value_MPEC, p_G_e_value_node1_MPEC, p_G_e_value_node2_MPEC, p_G_e_value_node3_MPEC, p_G_w_value_node1_MPEC, p_G_w_value_node2_MPEC, p_G_w_value_node3_MPEC, Electricity_prices_MPEC, TotalCost_MPEC,TotalEmissions_MPEC,Totalrevenue_demandblock_MPEC_Firm1, TotalOperatingCost_demandblock_MPEC_Firm1,Totalrevenue_demandblock_MPEC_Firm2, TotalOperatingCost_demandblock_MPEC_Firm2, Totalrevenue_demandblock_MPEC_Firm3, TotalOperatingCost_demandblock_MPEC_Firm3, TotalCapCost_EPEC, TotalFixedCost_EPEC, TotalEmissionsCost_EPEC, TotalOperatingCost_EPEC,TotalCurtailmentcost_EPEC, Total_Investments_Technology_Firm1_EPEC,Total_Investments_Technology_Firm2_EPEC,Total_Investments_Technology_EPEC,Total_Generation_Technology_EPEC,Total_Generation_Technology_Existing_EPEC,Total_Generation_Technology_Candidate_EPEC, Total_Generation_Technology_node1_EPEC, Total_Generation_Technology_node2_EPEC, Total_Generation_Technology_node3_EPEC,Total_Emissions_Technology_Existing_EPEC,Total_Emissions_Technology_Candidate_EPEC,Total_Emissions_Technology_Existing_Cummulative_EPEC,Total_Emissions_Technology_Candidate_Cummulative_EPEC)=Investment_OPF_MPEC(optimizer,set_thermalgenerators_options_numbertechnologies,set_wind_options_numbertechnologies,set_thermalgenerators_options,set_wind_options,set_thermalgenerators_existingunits,set_winds_existingunits,set_thermalgenerators,set_winds,set_demands,set_nodes,set_nodes_ref,set_nodes_noref,set_scenarios,set_times,P,V,thermal_ownership_options,wind_ownership_options,x_w_p,x_e_p,Leader,p_D,D,max_demand,Υ_SR,γ,Τ,p_lambda_upper,wind,Ns_H,n_link,links,links_rev,F_max_dict,B_dict,MapG,MapD,MapW,tech_thermal,tech_wind,capacity_per_unit,var_om,invcost,maxBuilds,ownership,capacity_existingunits,fixedcost,EmissionsRate,HeatRate,fuelprice,life,RamUP,Technology,WACC,varcost_thermal,varcost_wind,CRF_thermal,CRF_wind,set_opt_winds_numbertechnologies,set_opt_thermalgenerators_numbertechnologies)

resultfile != "" && open(resultfile, truncate = true) do f

    println(f,"*****************MPEC Solution*****************")
    println(f,"")
    println(f,"Objective Function (Firm $Leader): ",profit_det_MPEC)
    println(f,"")
    println(f,"Wind Investments: ",x_w_value_MPEC)
    println(f,"")
    println(f,"Thermal Investments: ",x_e_value_MPEC)
    end

return (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC)
end
