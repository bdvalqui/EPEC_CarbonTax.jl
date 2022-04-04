function Solver_CentralPlanner_scenario(scenario_tax,optimizer::Type{<:AbstractOptimizer},resultfile::String="")
#function solver_DeterministicEquivalent(optimizer::Type{<:AbstractOptimizer},resultfile::String="",load_st2::Type{<:AbstractArray{Int64,2}})
#Deterministic Equivalent------------------------------------------------------#
println("Loading inputs...")

(set_opt_thermalgenerators_numbertechnologies,set_opt_winds_numbertechnologies,set_opt_thermalgenerators,set_opt_winds,set_thermalgenerators,set_winds,set_demands,set_nodes,set_nodes_ref,set_nodes_noref,set_scenarios,set_times,P,V,p_D,D,max_demand,Υ_SR,γ,Τ,p_lambda_upper,wind,wind_opt,Ns_H,n_link,links,links_rev,F_max_dict,B_dict,MapG,MapG_opt,MapD,MapW,MapW_opt,tech_thermal,tech_thermal_opt,tech_wind,tech_wind_opt,capacity_per_unit,var_om,invcost,maxBuilds,ownership,capacity_existingunits,fixedcost,EmissionsRate,HeatRate,fuelprice,life,RamUP,Technology,WACC,varcost_thermal,varcost_thermal_opt,varcost_wind,varcost_wind_opt,CRF_thermal_opt,CRF_wind_opt)=loadinputs_CentralPlanner_scenario(scenario_tax,"data")

(syscost_det,x_w_value,x_e_value,Total_Investments_Technology_CP)=Investment_OPF_original(optimizer,set_opt_thermalgenerators_numbertechnologies,set_opt_winds_numbertechnologies,set_opt_thermalgenerators,set_opt_winds,set_thermalgenerators,set_winds,set_demands,set_nodes,set_nodes_ref,set_nodes_noref,set_scenarios,set_times,P,V,p_D,D,max_demand,Υ_SR,γ,Τ,p_lambda_upper,wind,wind_opt,Ns_H,n_link,links,links_rev,F_max_dict,B_dict,MapG,MapG_opt,MapD,MapW,MapW_opt,tech_thermal,tech_thermal_opt,tech_wind,tech_wind_opt,capacity_per_unit,var_om,invcost,maxBuilds,ownership,capacity_existingunits,fixedcost,EmissionsRate,HeatRate,fuelprice,life,RamUP,Technology,WACC,varcost_thermal,varcost_thermal_opt,varcost_wind,varcost_wind_opt,CRF_thermal_opt,CRF_wind_opt)

resultfile != "" && open(resultfile, truncate = true) do f

    println(f,"*****************Central Planner Solution*****************")
    println(f,"")
    println(f,"Objective System Cost: ",syscost_det)
    println(f,"")
    println(f,"Wind Investments: ",x_w_value)
    println(f,"")
    println(f,"Thermal Investments: ",x_e_value)
    end

return (syscost_det,x_w_value,x_e_value,set_opt_winds_numbertechnologies,set_opt_thermalgenerators_numbertechnologies,Total_Investments_Technology_CP)
end
