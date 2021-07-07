function Solver_EPEC(optimizer::Type{<:AbstractOptimizer},resultfile::String="")

global iterations=1:3

#Deterministic Equivalent------------------------------------------------------#
println("Loading inputs...")

#Run Central Planner to get initial conditions for the MPEC-EPEC

(syscost_det,x_w_value,x_e_value,set_opt_winds_numbertechnologies,set_opt_thermalgenerators_numbertechnologies)=Solver_CentralPlanner(optimizer,"results/CentralPlanner_Solution.txt")

#Run MPEC
(set_thermalgenerators_options_numbertechnologies,set_wind_options_numbertechnologies,set_thermalgenerators_options,set_wind_options,set_thermalgenerators_existingunits,set_winds_existingunits,set_thermalgenerators,set_winds,set_demands,set_nodes,set_nodes_ref,set_nodes_noref,set_scenarios,set_times,P,V,thermal_ownership_options,wind_ownership_options,x_w_p,x_e_p,Leader, p_D,D,max_demand,Υ_SR,γ,Τ,p_lambda_upper,wind,Ns_H,n_link,links,links_rev,F_max_dict,B_dict,MapG,MapD,MapW,tech_thermal,tech_wind,capacity_per_unit,var_om,invcost,maxBuilds,ownership,capacity_existingunits,fixedcost,EmissionsRate,HeatRate,fuelprice,life,RamUP,Technology,WACC,varcost_thermal,varcost_wind,CRF_thermal,CRF_wind)=loadinputs(x_w_value,x_e_value,"data")

x_w_p_iter=zeros(length(set_winds),length(iterations))
x_e_p_iter=zeros(length(set_thermalgenerators),length(iterations))
p_G_e_value_MPEC_iter_Firm2=zeros(length(set_thermalgenerators),length(set_times),length(set_scenarios),length(iterations))
p_G_w_value_MPEC_iter_Firm2=zeros(length(set_winds),length(set_times),length(set_scenarios),length(iterations))


for iter in iterations
println("Iteration $iter...")
#Firm 1

global Leader=1
println("Firm $Leader Problem...")

(profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC)=Investment_OPF_MPEC(optimizer,set_thermalgenerators_options_numbertechnologies,set_wind_options_numbertechnologies,set_thermalgenerators_options,set_wind_options,set_thermalgenerators_existingunits,set_winds_existingunits,set_thermalgenerators,set_winds,set_demands,set_nodes,set_nodes_ref,set_nodes_noref,set_scenarios,set_times,P,V,thermal_ownership_options,wind_ownership_options,x_w_p,x_e_p,Leader, p_D,D,max_demand,Υ_SR,γ,Τ,p_lambda_upper,wind,Ns_H,n_link,links,links_rev,F_max_dict,B_dict,MapG,MapD,MapW,tech_thermal,tech_wind,capacity_per_unit,var_om,invcost,maxBuilds,ownership,capacity_existingunits,fixedcost,EmissionsRate,HeatRate,fuelprice,life,RamUP,Technology,WACC,varcost_thermal,varcost_wind,CRF_thermal,CRF_wind,set_opt_winds_numbertechnologies,set_opt_thermalgenerators_numbertechnologies)

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
println("Firm $Leader Problem...")

(profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC)=Investment_OPF_MPEC(optimizer,set_thermalgenerators_options_numbertechnologies,set_wind_options_numbertechnologies,set_thermalgenerators_options,set_wind_options,set_thermalgenerators_existingunits,set_winds_existingunits,set_thermalgenerators,set_winds,set_demands,set_nodes,set_nodes_ref,set_nodes_noref,set_scenarios,set_times,P,V,thermal_ownership_options,wind_ownership_options,x_w_p,x_e_p,Leader, p_D,D,max_demand,Υ_SR,γ,Τ,p_lambda_upper,wind,Ns_H,n_link,links,links_rev,F_max_dict,B_dict,MapG,MapD,MapW,tech_thermal,tech_wind,capacity_per_unit,var_om,invcost,maxBuilds,ownership,capacity_existingunits,fixedcost,EmissionsRate,HeatRate,fuelprice,life,RamUP,Technology,WACC,varcost_thermal,varcost_wind,CRF_thermal,CRF_wind,set_opt_winds_numbertechnologies,set_opt_thermalgenerators_numbertechnologies)

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

global profit_det_MPEC_val=profit_det_MPEC

#=
for t in set_times, s in set_scenarios, w in set_winds
global p_G_w_value_MPEC_iter_Firm2[w,t,s,iter]=p_G_w_value_MPEC[w,t,s]
end

for t in set_times, s in set_scenarios, e in set_thermalgenerators
global p_G_e_value_MPEC_iter_Firm2[e,t,s,iter]=p_G_e_value_MPEC[e,t,s]
end
=#

println("End of iteration $iter...")

end

resultfile != "" && open(resultfile, truncate = true) do f

    println(f,"*****************MPEC Solution*****************")
    println(f,"")
    println(f,"Objective Function (Firm $Leader): ",profit_det_MPEC_val)
    println(f,"")
    println(f,"Wind Investments per iteration: ",x_w_p)
    println(f,"")
    println(f,"Thermal Investments per iteration: ",x_e_p)
    end

return (profit_det_MPEC_val,x_w_p,x_e_p)
end
