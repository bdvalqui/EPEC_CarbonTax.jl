function Investment_OPF_MPEC_Reaction(optimizer,set_thermalgenerators_options_numbertechnologies,set_wind_options_numbertechnologies,set_thermalgenerators_options,set_wind_options,set_thermalgenerators_existingunits,set_winds_existingunits,set_thermalgenerators,set_winds,set_demands,set_nodes,set_nodes_ref,set_nodes_noref,set_scenarios,set_times,P,V,thermal_ownership_options,wind_ownership_options,x_w_p,x_e_p,Leader, p_D,D,max_demand,Υ_SR,γ,Τ,p_lambda_upper,wind,Ns_H,n_link,links,links_rev,F_max_dict,B_dict,MapG,MapD,MapW,tech_thermal,tech_wind,capacity_per_unit,var_om,invcost,maxBuilds,ownership,capacity_existingunits,fixedcost,EmissionsRate,HeatRate,fuelprice,life,RamUP,Technology,WACC,varcost_thermal,varcost_wind,CRF_thermal,CRF_wind,set_opt_winds_numbertechnologies,set_opt_thermalgenerators_numbertechnologies,set_thermalgenerators_options_par,set_wind_options_par)

#include("utils.jl")

largeduallimit=999999
largeprimallimit=999999
#largeduallimit=999999
#largeprimallimit=999999
m=Model(optimizer)

#GUROBI solver
#Absolute MIP gap tolerance
#set_optimizer_attribute(m, "MIPGapAbs", 1e-15)
#Relative MIP gap tolerance
set_optimizer_attribute(m, "MIPGap", 0.005)
#set_optimizer_attribute(m, "MIPFocus", 3)
#set_optimizer_attribute(m, "Method", 3)
#Default value 0.0002
#set_optimizer_attribute(m, "PerturbValue", 0.002)


#CPLEX solver
#Absolute MIP gap tolerance
#set_optimizer_attribute(m, "CPX_PARAM_EPAGAP", 1e-15)
#Relative MIP gap tolerance
#set_optimizer_attribute(m, "CPX_PARAM_EPGAP", 0.005)
#set_optimizer_attribute(m, "CPX_PARAM_MIPEMPHASIS", 2)
#set_optimizer_attribute(m, "CPX_PARAM_LPMETHOD", 6)
#Default value 10e-6
#set_optimizer_attribute(m, "CPX_PARAM_EPPER", 10e-8)


#@variable(m, f[link in links,t in set_times,s in set_scenarios])
@variable(m, θ[n in set_nodes,t in set_times,s in set_scenarios])
@variable(m, p_G_e[e in set_thermalgenerators,t in set_times,s in set_scenarios]>= 0)
@variable(m, p_G_w[w in set_winds,t in set_times,s in set_scenarios]>= 0)
@variable(m, r_d[d in set_demands,t in set_times,s in set_scenarios]>= 0)
@variable(m, r_w[w in set_winds,t in set_times,s in set_scenarios]>= 0)
@variable(m, x_e[e in set_thermalgenerators]>= 0)
@variable(m, x_w[w in set_winds]>= 0)
@variable(m, υ_SR[e in set_thermalgenerators,t in set_times,s in set_scenarios]>= 0)
#dual variables
@variable(m, λ[n in set_nodes,t in set_times,s in set_scenarios])
@variable(m, η_lower[link in links,t in set_times,s in set_scenarios]<= 0)
@variable(m, η_upper[link in links,t in set_times,s in set_scenarios]<= 0)
@variable(m, μ_G[e in set_thermalgenerators,t in set_times,s in set_scenarios]<= 0)
@variable(m, ψ_G[e in set_thermalgenerators,t in set_times,s in set_scenarios]>= 0)
@variable(m, ψ_G_w[w in set_winds,t in set_times,s in set_scenarios]>= 0)
@variable(m, μ_G_w[w in set_winds,t in set_times,s in set_scenarios])
@variable(m, β_d[d in set_demands,t in set_times,s in set_scenarios]>= 0)
@variable(m, β_w[w in set_winds,t in set_times,s in set_scenarios]>= 0)
@variable(m, γ_angles[t in set_times,s in set_scenarios])
@variable(m, ψ_SR[e in set_thermalgenerators,t in set_times,s in set_scenarios]>= 0)
@variable(m, λ_SR[t in set_times,s in set_scenarios])
@variable(m, μ_SR[e in set_thermalgenerators,t in set_times,s in set_scenarios]>= 0)

#binary variables
@variable(m, U_complementarity_1[e in set_thermalgenerators,t in set_times,s in set_scenarios], Bin)
@variable(m, U_complementarity_2[e in set_thermalgenerators,t in set_times,s in set_scenarios], Bin)
@variable(m, U_complementarity_3[link in links,t in set_times,s in set_scenarios], Bin)
@variable(m, U_complementarity_4[link in links,t in set_times,s in set_scenarios], Bin)
@variable(m, U_complementarity_5[w in set_winds,t in set_times,s in set_scenarios], Bin)
@variable(m, U_complementarity_6[d in set_demands,t in set_times,s in set_scenarios], Bin)
@variable(m, U_complementarity_7[w in set_winds,t in set_times,s in set_scenarios], Bin)
@variable(m, U_complementarity_8[e in set_thermalgenerators,t in set_times,s in set_scenarios], Bin)
@variable(m, U_complementarity_9[e in set_thermalgenerators,t in set_times,s in set_scenarios], Bin)

#Warm Start
#=
for t in set_times, s in set_scenarios, e in set_thermalgenerators
set_start_value(U_complementarity_1[e,t,s],U_complementarity_1_MPEC_par[e,t,s])
set_start_value(U_complementarity_2[e,t,s],U_complementarity_2_MPEC_par[e,t,s])
set_start_value(U_complementarity_8[e,t,s],U_complementarity_8_MPEC_par[e,t,s])
set_start_value(U_complementarity_9[e,t,s],U_complementarity_9_MPEC_par[e,t,s])
end

for t in set_times, s in set_scenarios, w in set_winds
set_start_value(U_complementarity_5[w,t,s],U_complementarity_5_MPEC_par[w,t,s])
set_start_value(U_complementarity_7[w,t,s],U_complementarity_7_MPEC_par[w,t,s])
end

for t in set_times, s in set_scenarios, d in set_demands
set_start_value(U_complementarity_6[d,t,s],U_complementarity_6_MPEC_par[d,t,s])
end


i=1
for j in links
for s in set_scenarios, t in set_times
set_start_value(U_complementarity_3[j,t,s],U_complementarity_3_MPEC_par[i,t,s])
set_start_value(U_complementarity_4[j,t,s],U_complementarity_4_MPEC_par[i,t,s])
end
global i=i+1
end
=#

#auxiliary variables to check
@variable(m, revenue_firm)

#define investments for follower

@objective(m, Max,-sum(sum((sum(varcost_thermal[e]*p_G_e[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]==Leader)
                          +sum(varcost_wind[w]*p_G_w[w,t,s]  for w in set_winds if tech_wind[w,ownership]== Leader)
                          +sum(Τ[s]*tech_thermal[e,EmissionsRate]*tech_thermal[e,HeatRate]*p_G_e[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]==Leader))*γ[s]*Ns_H[t] for s in set_scenarios) for t in set_times)
                 +sum(sum((-sum(varcost_thermal[e]*p_G_e[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]!=Leader)
                           -sum(varcost_wind[w]*p_G_w[w,t,s]  for w in set_winds if tech_wind[w,ownership]!= Leader)
                           -sum(V*r_d[d,t,s]  for d in set_demands)
                           -sum(P*r_w[w,t,s]  for w in set_winds if tech_wind[w,ownership]!= Leader)
                           -sum(Τ[s]*tech_thermal[e,EmissionsRate]*tech_thermal[e,HeatRate]*p_G_e[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]!=Leader)
                           +sum(sum(p_D[d,t]*λ[n,t,s] for d in set_demands if n == MapD[d][2]) for n in set_nodes)
                           +sum(μ_G_w[w,t,s]*(tech_wind[w,capacity_existingunits]+x_w_p[w])*wind[w,t] for w in set_winds if tech_wind[w,ownership]!= Leader)
                           +sum(F_max_dict[j]*(η_lower[j,t,s]+η_upper[j,t,s]) for j in links)
                           +λ_SR[t,s]*Υ_SR[t]
                           +sum(((tech_thermal[e,capacity_existingunits]+x_e_p[e])*tech_thermal[e,RamUP]/tech_thermal[e,capacity_per_unit])*μ_SR[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]!=Leader)
                           +sum(μ_G[e,t,s]*(tech_thermal[e,capacity_existingunits]+x_e_p[e]) for e in set_thermalgenerators if tech_thermal[e,ownership]!= Leader))*γ[s]*Ns_H[t] for s in set_scenarios) for t in set_times)
                 -sum(tech_thermal[e,invcost]*CRF_thermal[e]*x_e[e]  for e in set_thermalgenerators if tech_thermal[e,ownership]== Leader)
                 -sum(tech_wind[w,invcost]*CRF_wind[w]*x_w[w]  for w in set_winds if tech_wind[w,ownership]== Leader)
                 -sum(tech_thermal[e,fixedcost]*(tech_thermal[e,capacity_existingunits]+x_e[e])  for e in set_thermalgenerators if tech_thermal[e,ownership]== Leader)
                 -sum(tech_wind[w,fixedcost]*(tech_wind[w,capacity_existingunits]+x_w[w])  for w in set_winds if tech_wind[w,ownership]== Leader))

#=====================================================================================================================#
#Upper-level constraints
#=
@constraint(m, constraint1,  sum(tech_thermal[e,capacity_existingunits] for e in set_thermalgenerators)
                            +sum(tech_wind[w,capacity_existingunits] for w in set_winds)
                            +sum(x_w[w] for w in set_winds)
                            +sum(x_e[e] for e in set_thermalgenerators) >= D*(1+R))
=#

@constraint(m, constraint2[w in set_winds], x_w[w] <= tech_wind[w,maxBuilds])
#=====================================================================================================================#
#Derivates wrt Lagrangian Function
@constraint(m, constraint3[e in set_thermalgenerators,t in set_times,s in set_scenarios],
           varcost_thermal[e]+Τ[s]*tech_thermal[e,EmissionsRate]*tech_thermal[e,HeatRate]-λ[MapG[e][2],t,s]-ψ_G[e,t,s]-μ_G[e,t,s] == 0)

@constraint(m, constraint4[w in set_winds,t in set_times,s in set_scenarios],
           varcost_wind[w]-λ[MapW[w][2],t,s]-ψ_G_w[w,t,s]-μ_G_w[w,t,s] == 0)

@constraint(m, constraint5[d in set_demands,t in set_times,s in set_scenarios],
           V-λ[MapD[d][2],t,s]-β_d[d,t,s] == 0)

@constraint(m, constraint6[w in set_winds,t in set_times,s in set_scenarios],
           P-μ_G_w[w,t,s]-β_w[w,t,s] == 0)

@constraint(m, constraint7[n in set_nodes_ref,t in set_times,s in set_scenarios],
                sum(B_dict[j]*(λ[j[1],t,s]-λ[j[2],t,s]-η_upper[j,t,s] +η_lower[j,t,s]) for j in links if n == j[1])
                +sum(B_dict[j]*(η_upper[j,t,s] -η_lower[j,t,s]) for j in links_rev if n == j[2] )-γ_angles[t,s] == 0)

@constraint(m, constraint8[n in set_nodes_noref,t in set_times,s in set_scenarios],
               sum(B_dict[j]*(λ[j[1],t,s]-λ[j[2],t,s]-η_upper[j,t,s] +η_lower[j,t,s]) for j in links if n == j[1])
               +sum(B_dict[j]*(η_upper[j,t,s] -η_lower[j,t,s]) for j in links_rev if n == j[2] )== 0)
#=====================================================================================================================#
#Equality Constraints
@constraint(m, constraint9[w in set_winds,t in set_times,s in set_scenarios], p_G_w[w,t,s] +r_w[w,t,s] == (tech_wind[w,capacity_existingunits]+x_w[w])*wind[w,t])

@constraint(m, constraint10[t in set_times,s in set_scenarios], θ[set_nodes_ref,t,s] == 0 )

@constraint(m, constraint11[n in set_nodes, t in set_times,s in set_scenarios],
                            +sum(p_G_e[e,t,s] for e in set_thermalgenerators if n == MapG[e][2])
                            +sum(p_G_w[w,t,s] for w in set_winds if n == MapW[w][2])
                            +sum(r_d[d,t,s] for d in set_demands if n == MapD[d][2])
                            -sum(p_D[d,t]*max_demand for d in set_demands if n == MapD[d][2])
                            -sum(B_dict[j]*(θ[j[1],t,s]-θ[j[2],t,s]) for j in links if n == j[1])== 0)

#=====================================================================================================================#
#Complementarity Constraints

for e in set_thermalgenerators, t in set_times,s in set_scenarios
    @complements(m, U_complementarity_1[e,t,s],
                 tech_thermal[e,capacity_existingunits]+x_e[e]-p_G_e[e,t,s]-υ_SR[e,t,s], largeduallimit,
                 -μ_G[e,t,s], largeprimallimit)
end

for e in set_thermalgenerators, t in set_times,s in set_scenarios
    @complements(m, U_complementarity_2[e,t,s],
                 p_G_e[e,t,s], largeduallimit,
                 ψ_G[e,t,s], largeprimallimit)
end

for j in links, t in set_times,s in set_scenarios
    @complements(m, U_complementarity_3[j,t,s],
                 F_max_dict[j]+B_dict[j]*(θ[j[1],t,s]-θ[j[2],t,s]), largeduallimit,
                 -η_lower[j,t,s], largeprimallimit)
end

for j in links, t in set_times,s in set_scenarios
    @complements(m, U_complementarity_4[j,t,s],
                 F_max_dict[j]-B_dict[j]*(θ[j[1],t,s]-θ[j[2],t,s]), largeduallimit,
                 -η_upper[j,t,s], largeprimallimit)
end

for w in set_winds, t in set_times,s in set_scenarios
    @complements(m, U_complementarity_5[w,t,s],
                 p_G_w[w,t,s], largeduallimit,
                 ψ_G_w[w,t,s], largeprimallimit)
end

for d in set_demands, t in set_times,s in set_scenarios
    @complements(m, U_complementarity_6[d,t,s],
                 r_d[d,t,s], largeduallimit,
                 β_d[d,t,s], largeprimallimit)
end

for w in set_winds, t in set_times,s in set_scenarios
    @complements(m, U_complementarity_7[w,t,s],
                 r_w[w,t,s], largeduallimit,
                 β_w[w,t,s], largeprimallimit)
end

for e in set_thermalgenerators, t in set_times,s in set_scenarios
    @complements(m, U_complementarity_8[e,t,s],
                 (tech_thermal[e,capacity_existingunits]+x_e[e])*tech_thermal[e,RamUP]/tech_thermal[e,capacity_per_unit]-υ_SR[e,t,s], largeduallimit,
                 -μ_SR[e,t,s], largeprimallimit)
end

for e in set_thermalgenerators, t in set_times,s in set_scenarios
    @complements(m, U_complementarity_9[e,t,s],
                 υ_SR[e,t,s], largeduallimit,
                 ψ_SR[e,t,s], largeprimallimit)
end

#=====================================================================================================================#
# Constraints to fix investment decisions of the leader

for e in set_thermalgenerators_options_par
@constraint(m, x_e[e] == x_e_p[e])
end

for w in set_wind_options_par
@constraint(m, x_w[w] == x_w_p[w])
end


#=====================================================================================================================#
# Constraints to fix investment decisions of other firms
#=
for e in set_thermalgenerators_options if thermal_ownership_options[e]!=Leader
@constraint(m, x_e[e] == x_e_p[e])
end
end

for w in set_wind_options if wind_ownership_options[w]!=Leader
@constraint(m, x_w[w] == x_w_p[w])
end
end
=#
@constraint(m, Constraint14[e in set_thermalgenerators_existingunits], x_e[e] == x_e_p[e])
@constraint(m, Constraint15[w in set_winds_existingunits], x_w[w] == x_w_p[w])
@constraint(m, Constraint16[n in set_nodes,t in set_times,s in set_scenarios], λ[n,t,s] <= p_lambda_upper[s])
# Constraints to fix investment decisions for existing units

@constraint(m, constraint17[e in set_thermalgenerators,t in set_times,s in set_scenarios],
           -μ_G[e,t,s]-λ_SR[t,s]-μ_SR[e,t,s]-ψ_SR[e,t,s] == 0)

@constraint(m, constraint18[t in set_times,s in set_scenarios], sum(υ_SR[e,t,s] for e in set_thermalgenerators) == Υ_SR[t])

#Additional constraints to ensure that the investments are distributed across 2 buses.
#=
if Leader==1
global j=35
elseif Leader==2
global j=40
end

for e in set_thermalgenerators_options_numbertechnologies if thermal_ownership_options[e]==Leader
@constraint(m, x_e[e] == x_e[j])
global j=j+1
end
end

if Leader==1
global j=17
elseif Leader==2
global j=19
end

for w in set_wind_options_numbertechnologies if wind_ownership_options[w]==Leader
@constraint(m, x_w[w] == x_w[j])
global j=j+1
end
end
=#
# Compute Revenue to Compare
@constraint(m,revenue_firm==sum(sum((-sum(varcost_thermal[e]*p_G_e[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]!=Leader)
          -sum(varcost_wind[w]*p_G_w[w,t,s]  for w in set_winds if tech_wind[w,ownership]!= Leader)
          -sum(V*r_d[d,t,s]  for d in set_demands)
          -sum(P*r_w[w,t,s]  for w in set_winds if tech_wind[w,ownership]!= Leader)
          -sum(Τ[s]*tech_thermal[e,EmissionsRate]*tech_thermal[e,HeatRate]*p_G_e[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]!=Leader)
          +sum(sum(p_D[d,t]*λ[n,t,s] for d in set_demands if n == MapD[d][2]) for n in set_nodes)
          +sum(μ_G_w[w,t,s]*(tech_wind[w,capacity_existingunits]+x_w_p[w])*wind[w,t] for w in set_winds if tech_wind[w,ownership]!= Leader)
          +sum(F_max_dict[j]*(η_lower[j,t,s]+η_upper[j,t,s]) for j in links)
          +λ_SR[t,s]*Υ_SR[t]
          +sum(((tech_thermal[e,capacity_existingunits]+x_e_p[e])*tech_thermal[e,RamUP]/tech_thermal[e,capacity_per_unit])*μ_SR[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]!=Leader)
          +sum(μ_G[e,t,s]*(tech_thermal[e,capacity_existingunits]+x_e_p[e]) for e in set_thermalgenerators if tech_thermal[e,ownership]!= Leader))*γ[s]*Ns_H[t] for s in set_scenarios) for t in set_times))

@time optimize!(m)

#cd("C:\\Users\\braya\\Desktop\\Doctorado\\Doctorado EEUU\\Semesters\\Spring Semester 2021\\DTU Course\\Project\\Step 3\\Code\\Julia")
#Print output
println("Number of variables and Constraints:")
display(m)

status= termination_status(m)
println("The solution status is: $status")
println("")
println("The solution of firm $Leader's  problem")
println("")
profit_det_MPEC=objective_value(m)

println("Total Cost:",profit_det_MPEC)

println("Investment Decisions")

x_w_value_MPEC=zeros(length(set_winds))
for w in set_winds
println("Investment decision for candidate wind unit $w: ",JuMP.value.(x_w[w]))
x_w_value_MPEC[w]=JuMP.value.(x_w[w])
end

x_e_value_MPEC=zeros(length(set_thermalgenerators))
for e in set_thermalgenerators
println("Investment decision for candidate thermal unit $e: ",JuMP.value.(x_e[e]))
x_e_value_MPEC[e]=JuMP.value.(x_e[e])
end

p_G_e_value_MPEC=zeros(length(set_thermalgenerators),length(set_times),length(set_scenarios))
for t in set_times, s in set_scenarios, e in set_thermalgenerators
#println("Production level of thermal generator $e in time $t under scenario $s:",JuMP.value.(p_G_e[e,t,s]))
  p_G_e_value_MPEC[e,t,s]=JuMP.value.(p_G_e[e,t,s])
end

p_G_e_value_node1_MPEC=zeros(length(set_thermalgenerators),length(set_times),length(set_scenarios))

for e in set_thermalgenerators if 1 == MapG[e][2]
for t in set_times, s in set_scenarios
  p_G_e_value_node1_MPEC[e,t,s]=JuMP.value.(p_G_e[e,t,s])
end
end
end

p_G_e_value_node2_MPEC=zeros(length(set_thermalgenerators),length(set_times),length(set_scenarios))

for e in set_thermalgenerators if 2 == MapG[e][2]
for t in set_times, s in set_scenarios
  p_G_e_value_node2_MPEC[e,t,s]=JuMP.value.(p_G_e[e,t,s])
end
end
end

p_G_e_value_node3_MPEC=zeros(length(set_thermalgenerators),length(set_times),length(set_scenarios))

for e in set_thermalgenerators if 3 == MapG[e][2]
for t in set_times, s in set_scenarios
  p_G_e_value_node3_MPEC[e,t,s]=JuMP.value.(p_G_e[e,t,s])
end
end
end

p_G_w_value_MPEC=zeros(length(set_winds),length(set_times),length(set_scenarios))
for t in set_times, s in set_scenarios, w in set_winds
#println("Production level of wind unit $w in time $t under scenario $s:",JuMP.value.(p_G_w[w,t,s]))
  p_G_w_value_MPEC[w,t,s]=JuMP.value.(p_G_w[w,t,s])
end


p_G_w_value_node1_MPEC=zeros(length(set_winds),length(set_times),length(set_scenarios))
for w in set_winds if 1 == MapW[w][2]
for t in set_times, s in set_scenarios
  p_G_w_value_node1_MPEC[w,t,s]=JuMP.value.(p_G_w[w,t,s])
end
end
end

p_G_w_value_node2_MPEC=zeros(length(set_winds),length(set_times),length(set_scenarios))
for w in set_winds if 2 == MapW[w][2]
for t in set_times, s in set_scenarios
  p_G_w_value_node2_MPEC[w,t,s]=JuMP.value.(p_G_w[w,t,s])
end
end
end

p_G_w_value_node3_MPEC=zeros(length(set_winds),length(set_times),length(set_scenarios))
for w in set_winds if 3 == MapW[w][2]
for t in set_times, s in set_scenarios
  p_G_w_value_node3_MPEC[w,t,s]=JuMP.value.(p_G_w[w,t,s])
end
end
end

p_D_value_MPEC=zeros(length(set_demands),length(set_scenarios))
for d in set_demands, s in set_scenarios
  p_D_value_MPEC[d,s]=p_D[d,s]*max_demand
end
#println("Comsuption level of demand d: ",p_D_value)

υ_SR_value_MPEC=zeros(length(set_thermalgenerators),length(set_times),length(set_scenarios))
for t in set_times, s in set_scenarios, e in set_thermalgenerators
#println("Spinning reserves of thermal generator $e in time $t under scenario $s:",JuMP.value.(υ_SR[e,t,s]))
  υ_SR_value_MPEC[e,t,s]=JuMP.value.(υ_SR[e,t,s])
end

r_d_value_MPEC=zeros(length(set_demands),length(set_times),length(set_scenarios))
for t in set_times, s in set_scenarios, d in set_demands
#println("Unserved energy of demand $d in time $t under scenario $s:",JuMP.value.(r_d[d,t,s]))
  r_d_value_MPEC[d,t,s]=JuMP.value.(r_d[d,t,s])
end

r_w_value_MPEC=zeros(length(set_winds),length(set_times),length(set_scenarios))

for t in set_times, s in set_scenarios, w in set_winds
#println("Curtailment of wind unit $w in time $t under scenario $s: ",JuMP.value.(r_w[w,t,s]))
  r_w_value_MPEC[w,t,s]=JuMP.value.(r_w[w,t,s])
end

Electricity_prices_MPEC=zeros(length(set_nodes),length(set_times),length(set_scenarios))

for   t in set_times, s in set_scenarios,n in set_nodes
   Electricity_prices_MPEC[n,t,s]= JuMP.value.(λ[n,t,s])
println("Electricity Price in node $n in time $t under scenario $s: ", Electricity_prices_MPEC[n,t,s])
end

Spinning_prices_MPEC=zeros(length(set_times),length(set_scenarios))

for   t in set_times, s in set_scenarios
   Spinning_prices_MPEC[t,s]= JuMP.value.(λ_SR[t,s])
println("Spinning reserve Price time $t under scenario $s: ", Spinning_prices_MPEC[t,s])
end


θ_values_MPEC=zeros(length(set_nodes),length(set_times),length(set_scenarios))

for   t in set_times, s in set_scenarios,n in set_nodes
   θ_values_MPEC[n,t,s]= JuMP.value.(θ[n,t,s])
#println("Angle in node $n in time $t under scenario $s: ", θ_values_MPEC[n,t,s])
end

f_MPEC=zeros(n_link,length(set_times),length(set_scenarios))
i=1
for j in links
for s in set_scenarios, t in set_times
f_MPEC[i,t,s]=B_dict[j]*(θ_values_MPEC[j[1],t,s]-θ_values_MPEC[j[2],t,s])
println("Power Flow lines $j in time $t under scenario $s: ", f_MPEC[i,t,s])
end
global i=i+1
end

TotalEmissions_MPEC= sum(sum((sum(tech_thermal[e,EmissionsRate]*tech_thermal[e,HeatRate]*p_G_e_value_MPEC[e,t,s] for e in set_thermalgenerators))*γ[s]*Ns_H[t] for s in set_scenarios) for t in set_times)

println("Total Emissions:", TotalEmissions_MPEC)

TotalCost_MPEC=   sum(sum(sum((
                  +sum(varcost_thermal[e]*p_G_e_value_MPEC[e,t,s] for e in set_thermalgenerators)
                  +sum(varcost_wind[w]*p_G_w_value_MPEC[w,t,s]  for w in set_winds)
                  +sum(V*r_d_value_MPEC[d,t,s]  for d in set_demands)
                  +sum(P*r_w_value_MPEC[w,t,s]  for w in set_winds)
                  +sum(Τ[s]*tech_thermal[e,EmissionsRate]*tech_thermal[e,HeatRate]*p_G_e_value_MPEC[e,t,s] for e in set_thermalgenerators))*γ[s]*Ns_H[t] for s in set_scenarios) for t in set_times)
                  +sum(tech_thermal[e,invcost]*CRF_thermal[e]*x_e_value_MPEC[e]  for e in set_thermalgenerators)
                  +sum(tech_wind[w,invcost]*CRF_wind[w]*x_w_value_MPEC[w]  for w in set_winds)
                  +sum(tech_thermal[e,fixedcost]*(tech_thermal[e,capacity_existingunits]+x_e_value_MPEC[e])  for e in set_thermalgenerators)
                  +sum(tech_wind[w,fixedcost]*(tech_wind[w,capacity_existingunits]+x_w_value_MPEC[w])  for w in set_winds))

TotalCapCost_EPEC=sum(sum(tech_thermal[e,invcost]*CRF_thermal[e]*x_e_value_MPEC[e]  for e in set_thermalgenerators)
                      +sum(tech_wind[w,invcost]*CRF_wind[w]*x_w_value_MPEC[w]  for w in set_winds))

TotalFixedCost_EPEC=sum(sum(tech_thermal[e,fixedcost]*(tech_thermal[e,capacity_existingunits]+x_e_value_MPEC[e])  for e in set_thermalgenerators)
                     +sum(tech_wind[w,fixedcost]*(tech_wind[w,capacity_existingunits]+x_w_value_MPEC[w])  for w in set_winds))

TotalEmissionsCost_EPEC= sum(sum((sum(Τ[s]*tech_thermal[e,EmissionsRate]*tech_thermal[e,HeatRate]*p_G_e_value_MPEC[e,t,s] for e in set_thermalgenerators))*γ[s]*Ns_H[t] for s in set_scenarios) for t in set_times)

TotalOperatingCost_EPEC= sum(sum((sum(varcost_thermal[e]*p_G_e_value_MPEC[e,t,s] for e in set_thermalgenerators)
                                +sum(varcost_wind[w]*p_G_w_value_MPEC[w,t,s]  for w in set_winds))*γ[s]*Ns_H[t] for s in set_scenarios) for t in set_times)

TotalCurtailmentcost_EPEC=sum(sum((sum(P*r_w_value_MPEC[w,t,s]  for w in set_winds))*γ[s]*Ns_H[t] for s in set_scenarios) for t in set_times)

TotalCost_MPEC_Check=TotalCapCost_EPEC+TotalFixedCost_EPEC+TotalEmissionsCost_EPEC+TotalOperatingCost_EPEC+TotalCurtailmentcost_EPEC

println("Total Operating Cost:", TotalOperatingCost_EPEC)

println("Total Cost:", TotalCost_MPEC)

TotalOperatingCost_MPEC_Firm1=sum(sum(sum((sum(varcost_thermal[e]*p_G_e_value_MPEC[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]==1)
                                           +sum(varcost_wind[w]*p_G_w_value_MPEC[w,t,s]  for w in set_winds if tech_wind[w,ownership]==1))*γ[s]*Ns_H[t] for s in set_scenarios) for t in set_times))

#Note: Both operating cost and profits might different among solvers, but the total system cost should be the same.
println("Total Operating Cost, Firm 1:", TotalOperatingCost_MPEC_Firm1)

TotalOperatingCost_MPEC_Firm2=sum(sum(sum((sum(varcost_thermal[e]*p_G_e_value_MPEC[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]==2)
                                           +sum(varcost_wind[w]*p_G_w_value_MPEC[w,t,s]  for w in set_winds if tech_wind[w,ownership]==2))*γ[s]*Ns_H[t] for s in set_scenarios) for t in set_times))

println("Total Operating Cost, Firm 2:", TotalOperatingCost_MPEC_Firm2)


TotalOperatingCost_MPEC_Firm3=sum(sum(sum((sum(varcost_thermal[e]*p_G_e_value_MPEC[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]==3)
                                           +sum(varcost_wind[w]*p_G_w_value_MPEC[w,t,s]  for w in set_winds if tech_wind[w,ownership]==3))*γ[s]*Ns_H[t] for s in set_scenarios) for t in set_times))

println("Total Operating Cost, Firm 3:", TotalOperatingCost_MPEC_Firm3)


Totalrevenue_MPEC_Firm1= sum(sum(sum((sum(Electricity_prices_MPEC[MapG[e][2],t,s]*p_G_e_value_MPEC[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]==1)
                                     +sum(Electricity_prices_MPEC[MapW[w][2],t,s]*p_G_w_value_MPEC[w,t,s] for w in set_winds if tech_wind[w,ownership]==1)
                                     +sum(Spinning_prices_MPEC[t,s]*p_G_e_value_MPEC[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]==1))*γ[s]*Ns_H[t] for s in set_scenarios) for t in set_times))

println("MPEC Objective Function: ", objective_value(m))

println("Total Revenue, Firm 1:", Totalrevenue_MPEC_Firm1)

Totalrevenue_MPEC_Firm2= sum(sum(sum((sum(Electricity_prices_MPEC[MapG[e][2],t,s]*p_G_e_value_MPEC[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]==2)
                                     +sum(Electricity_prices_MPEC[MapW[w][2],t,s]*p_G_w_value_MPEC[w,t,s] for w in set_winds if tech_wind[w,ownership]==2)
                                     +sum(Spinning_prices_MPEC[t,s]*p_G_e_value_MPEC[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]==2))*γ[s]*Ns_H[t] for s in set_scenarios) for t in set_times))

println("Total Revenue, Firm 2:", Totalrevenue_MPEC_Firm2)

ObjectiveFunction_Revenue=JuMP.value.(revenue_firm)

println("MPEC Revenue: ", ObjectiveFunction_Revenue)

Totalrevenue_MPEC_Firm3= sum(sum(sum((sum(Electricity_prices_MPEC[MapG[e][2],t,s]*p_G_e_value_MPEC[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]==3)
                                     +sum(Electricity_prices_MPEC[MapW[w][2],t,s]*p_G_w_value_MPEC[w,t,s] for w in set_winds if tech_wind[w,ownership]==3)
                                     +sum(Spinning_prices_MPEC[t,s]*p_G_e_value_MPEC[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]==3))*γ[s]*Ns_H[t] for s in set_scenarios) for t in set_times))

println("Total Revenue, Firm 3:", Totalrevenue_MPEC_Firm3)

Total_Investments_Technology_EPEC=zeros(7)
Total_Investments_Technology_Firm1_EPEC=zeros(7)
Total_Investments_Technology_Firm2_EPEC=zeros(7)

for i in set_opt_thermalgenerators_numbertechnologies
Total_Investments_Technology_EPEC[i]=sum(x_e_value_MPEC[e] for e in set_thermalgenerators if tech_thermal[e,Technology]== i)
Total_Investments_Technology_Firm1_EPEC[i]=sum(x_e_value_MPEC[e] for e in set_thermalgenerators if tech_thermal[e,ownership]==1 && tech_thermal[e,Technology]== i)
Total_Investments_Technology_Firm2_EPEC[i]=sum(x_e_value_MPEC[e] for e in set_thermalgenerators if tech_thermal[e,ownership]==2 && tech_thermal[e,Technology]== i)
end

global j=6
for i in set_opt_winds_numbertechnologies
Total_Investments_Technology_EPEC[j]=sum(x_w_value_MPEC[w] for w in set_winds if tech_wind[w,Technology]== i)
Total_Investments_Technology_Firm1_EPEC[j]=sum(x_w_value_MPEC[w] for w in set_winds if tech_wind[w,ownership]==1 && tech_wind[w,Technology]== i)
Total_Investments_Technology_Firm2_EPEC[j]=sum(x_w_value_MPEC[w] for w in set_winds if tech_wind[w,ownership]==2 && tech_wind[w,Technology]== i)
global j=j+1
end

Total_Generation_Technology_EPEC=zeros(9,length(set_times))
Total_Generation_Technology_Existing_EPEC=zeros(9,length(set_times))
Total_Generation_Technology_Candidate_EPEC=zeros(9,length(set_times))

Total_Emissions_Technology_Existing_EPEC=zeros(9,length(set_times))
Total_Emissions_Technology_Candidate_EPEC=zeros(9,length(set_times))

Total_Emissions_Technology_Existing_Cummulative_EPEC=zeros(9)
Total_Emissions_Technology_Candidate_Cummulative_EPEC=zeros(9)

for i in 1:7
for t in set_times
Total_Generation_Technology_EPEC[i,t]=sum(p_G_e_value_MPEC[e,t,1] for e in set_thermalgenerators if tech_thermal[e,Technology]==i;init=0)
Total_Generation_Technology_Existing_EPEC[i,t]=sum(p_G_e_value_MPEC[e,t,1] for e in set_thermalgenerators if tech_thermal[e,capacity_existingunits]>0 && tech_thermal[e,Technology]==i;init=0)
Total_Generation_Technology_Candidate_EPEC[i,t]=sum(p_G_e_value_MPEC[e,t,1] for e in set_thermalgenerators if tech_thermal[e,capacity_existingunits]==0 && tech_thermal[e,Technology]==i;init=0)

Total_Emissions_Technology_Existing_EPEC[i,t]=sum(tech_thermal[e,EmissionsRate]*tech_thermal[e,HeatRate]*p_G_e_value_MPEC[e,t,1] for e in set_thermalgenerators if tech_thermal[e,capacity_existingunits]>0 && tech_thermal[e,Technology]==i;init=0)
Total_Emissions_Technology_Candidate_EPEC[i,t]=sum(tech_thermal[e,EmissionsRate]*tech_thermal[e,HeatRate]*p_G_e_value_MPEC[e,t,1] for e in set_thermalgenerators if tech_thermal[e,capacity_existingunits]==0 && tech_thermal[e,Technology]==i;init=0)

Total_Emissions_Technology_Existing_Cummulative_EPEC[i]=sum(sum(tech_thermal[e,EmissionsRate]*tech_thermal[e,HeatRate]*p_G_e_value_MPEC[e,t,1] for e in set_thermalgenerators if tech_thermal[e,capacity_existingunits]>0 && tech_thermal[e,Technology]==i;init=0)*Ns_H[t] for t in set_times)
Total_Emissions_Technology_Candidate_Cummulative_EPEC[i]=sum(sum(tech_thermal[e,EmissionsRate]*tech_thermal[e,HeatRate]*p_G_e_value_MPEC[e,t,1] for e in set_thermalgenerators if tech_thermal[e,capacity_existingunits]==0 && tech_thermal[e,Technology]==i;init=0)*Ns_H[t] for t in set_times)

end
end

global j=1
for i in 8:9
for t in set_times
Total_Generation_Technology_EPEC[i,t]=sum(p_G_w_value_MPEC[w,t,1] for w in set_winds if tech_wind[w,Technology]==j;init=0)
Total_Generation_Technology_Existing_EPEC[i,t]=sum(p_G_w_value_MPEC[w,t,1] for w in set_winds if tech_wind[w,capacity_existingunits]>0 && tech_wind[w,Technology]==j;init=0)
Total_Generation_Technology_Candidate_EPEC[i,t]=sum(p_G_w_value_MPEC[w,t,1] for w in set_winds if tech_wind[w,capacity_existingunits]==0 && tech_wind[w,Technology]==j;init=0)
end
global j=j+1
end


#Generation per node
#Node 1
Total_Generation_Technology_node1_EPEC=zeros(9,length(set_times))

for i in 1:7
for t in set_times
Total_Generation_Technology_node1_EPEC[i,t]=sum(p_G_e_value_node1_MPEC[e,t,1] for e in set_thermalgenerators if tech_thermal[e,Technology]==i;init=0)
end
end

global j=1
for i in 8:9
for t in set_times
Total_Generation_Technology_node1_EPEC[i,t]=sum(p_G_w_value_node1_MPEC[w,t,1] for w in set_winds if tech_wind[w,Technology]==j;init=0)
end
global j=j+1
end

#Generation per node
#Node 2
Total_Generation_Technology_node2_EPEC=zeros(9,length(set_times))

for i in 1:7
for t in set_times
Total_Generation_Technology_node2_EPEC[i,t]=sum(p_G_e_value_node2_MPEC[e,t,1] for e in set_thermalgenerators if tech_thermal[e,Technology]==i;init=0)
end
end

global j=1
for i in 8:9
for t in set_times
Total_Generation_Technology_node2_EPEC[i,t]=sum(p_G_w_value_node2_MPEC[w,t,1] for w in set_winds if tech_wind[w,Technology]==j;init=0)
end
global j=j+1
end

#Generation per node
#Node 3
Total_Generation_Technology_node3_EPEC=zeros(9,length(set_times))

for i in 1:7
for t in set_times
Total_Generation_Technology_node3_EPEC[i,t]=sum(p_G_e_value_node3_MPEC[e,t,1] for e in set_thermalgenerators if tech_thermal[e,Technology]==i;init=0)
end
end

global j=1
for i in 8:9
for t in set_times
Total_Generation_Technology_node3_EPEC[i,t]=sum(p_G_w_value_node3_MPEC[w,t,1] for w in set_winds if tech_wind[w,Technology]==j;init=0)
end
global j=j+1
end

TotalOperatingCost_demandblock_MPEC_Firm1=zeros(length(set_times))

for t in set_times
TotalOperatingCost_demandblock_MPEC_Firm1[t]=sum(sum((sum(varcost_thermal[e]*p_G_e_value_MPEC[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]==1)
                                           +sum(varcost_wind[w]*p_G_w_value_MPEC[w,t,s]  for w in set_winds if tech_wind[w,ownership]==1))*γ[s]*Ns_H[t] for s in set_scenarios))
end

TotalOperatingCost_demandblock_MPEC_Firm2=zeros(length(set_times))

for t in set_times
TotalOperatingCost_demandblock_MPEC_Firm2[t]=sum(sum((sum(varcost_thermal[e]*p_G_e_value_MPEC[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]==2)
                                           +sum(varcost_wind[w]*p_G_w_value_MPEC[w,t,s]  for w in set_winds if tech_wind[w,ownership]==2))*γ[s]*Ns_H[t] for s in set_scenarios))
end

TotalOperatingCost_demandblock_MPEC_Firm3=zeros(length(set_times))

for t in set_times
TotalOperatingCost_demandblock_MPEC_Firm3[t]=sum(sum((sum(varcost_thermal[e]*p_G_e_value_MPEC[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]==3)
                                           +sum(varcost_wind[w]*p_G_w_value_MPEC[w,t,s]  for w in set_winds if tech_wind[w,ownership]==3))*γ[s]*Ns_H[t] for s in set_scenarios))
end


Totalrevenue_demandblock_MPEC_Firm1=zeros(length(set_times))

for t in set_times
Totalrevenue_demandblock_MPEC_Firm1[t]= sum(sum((sum(Electricity_prices_MPEC[MapG[e][2],t,s]*p_G_e_value_MPEC[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]==1)
                                     +sum(Electricity_prices_MPEC[MapW[w][2],t,s]*p_G_w_value_MPEC[w,t,s] for w in set_winds if tech_wind[w,ownership]==1)
                                     +sum(Spinning_prices_MPEC[t,s]*p_G_e_value_MPEC[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]==1))*γ[s]*Ns_H[t] for s in set_scenarios))
end

Totalrevenue_demandblock_MPEC_Firm2=zeros(length(set_times))

for t in set_times
Totalrevenue_demandblock_MPEC_Firm2[t]= sum(sum((sum(Electricity_prices_MPEC[MapG[e][2],t,s]*p_G_e_value_MPEC[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]==2)
                                     +sum(Electricity_prices_MPEC[MapW[w][2],t,s]*p_G_w_value_MPEC[w,t,s] for w in set_winds if tech_wind[w,ownership]==2)
                                     +sum(Spinning_prices_MPEC[t,s]*p_G_e_value_MPEC[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]==2))*γ[s]*Ns_H[t] for s in set_scenarios))
end

Totalrevenue_demandblock_MPEC_Firm3=zeros(length(set_times))

for t in set_times
Totalrevenue_demandblock_MPEC_Firm3[t]= sum(sum((sum(Electricity_prices_MPEC[MapG[e][2],t,s]*p_G_e_value_MPEC[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]==3)
                                     +sum(Electricity_prices_MPEC[MapW[w][2],t,s]*p_G_w_value_MPEC[w,t,s] for w in set_winds if tech_wind[w,ownership]==3)
                                     +sum(Spinning_prices_MPEC[t,s]*p_G_e_value_MPEC[e,t,s] for e in set_thermalgenerators if tech_thermal[e,ownership]==3))*γ[s]*Ns_H[t] for s in set_scenarios))
end


U_complementarity_1_MPEC=zeros(length(set_thermalgenerators),length(set_times),length(set_scenarios))
U_complementarity_2_MPEC=zeros(length(set_thermalgenerators),length(set_times),length(set_scenarios))

for t in set_times, s in set_scenarios, e in set_thermalgenerators
  U_complementarity_1_MPEC[e,t,s]=JuMP.value.(U_complementarity_1[e,t,s])
end

for t in set_times, s in set_scenarios, e in set_thermalgenerators
  U_complementarity_2_MPEC[e,t,s]=JuMP.value.(U_complementarity_2[e,t,s])
end

U_complementarity_3_MPEC=zeros(n_link,length(set_times),length(set_scenarios))

global i=1
for j in links
for s in set_scenarios, t in set_times
U_complementarity_3_MPEC[i,t,s]=JuMP.value.(U_complementarity_3[j,t,s])
end
global i=i+1
end

U_complementarity_4_MPEC=zeros(n_link,length(set_times),length(set_scenarios))

global i=1
for j in links
for s in set_scenarios, t in set_times
U_complementarity_4_MPEC[i,t,s]=JuMP.value.(U_complementarity_4[j,t,s])
end
global i=i+1
end

U_complementarity_5_MPEC=zeros(length(set_winds),length(set_times),length(set_scenarios))
U_complementarity_6_MPEC=zeros(length(set_demands),length(set_times),length(set_scenarios))
U_complementarity_7_MPEC=zeros(length(set_winds),length(set_times),length(set_scenarios))
U_complementarity_8_MPEC=zeros(length(set_thermalgenerators),length(set_times),length(set_scenarios))
U_complementarity_9_MPEC=zeros(length(set_thermalgenerators),length(set_times),length(set_scenarios))

for t in set_times, s in set_scenarios, w in set_winds
  U_complementarity_5_MPEC[w,t,s]=JuMP.value.(U_complementarity_5[w,t,s])
end

for t in set_times, s in set_scenarios, d in set_demands
  U_complementarity_6_MPEC[d,t,s]=JuMP.value.(U_complementarity_6[d,t,s])
end


for t in set_times, s in set_scenarios, w in set_winds
  U_complementarity_7_MPEC[w,t,s]=JuMP.value.(U_complementarity_7[w,t,s])
end

for t in set_times, s in set_scenarios, e in set_thermalgenerators
  U_complementarity_8_MPEC[e,t,s]=JuMP.value.(U_complementarity_8[e,t,s])
end

for t in set_times, s in set_scenarios, e in set_thermalgenerators
  U_complementarity_9_MPEC[e,t,s]=JuMP.value.(U_complementarity_9[e,t,s])
end

return (profit_det_MPEC,x_w_value_MPEC,x_e_value_MPEC,Totalrevenue_MPEC_Firm1,TotalOperatingCost_MPEC_Firm1,Totalrevenue_MPEC_Firm2,TotalOperatingCost_MPEC_Firm2,Totalrevenue_MPEC_Firm3,TotalOperatingCost_MPEC_Firm3, Electricity_prices_MPEC, Spinning_prices_MPEC, υ_SR_value_MPEC,p_G_e_value_MPEC, p_G_w_value_MPEC, p_G_e_value_node1_MPEC, p_G_e_value_node2_MPEC, p_G_e_value_node3_MPEC, p_G_w_value_node1_MPEC, p_G_w_value_node2_MPEC, p_G_w_value_node3_MPEC, Electricity_prices_MPEC, TotalCost_MPEC,TotalEmissions_MPEC,Totalrevenue_demandblock_MPEC_Firm1, TotalOperatingCost_demandblock_MPEC_Firm1,Totalrevenue_demandblock_MPEC_Firm2, TotalOperatingCost_demandblock_MPEC_Firm2, Totalrevenue_demandblock_MPEC_Firm3, TotalOperatingCost_demandblock_MPEC_Firm3, TotalCapCost_EPEC, TotalFixedCost_EPEC, TotalEmissionsCost_EPEC, TotalOperatingCost_EPEC,TotalCurtailmentcost_EPEC, Total_Investments_Technology_Firm1_EPEC,Total_Investments_Technology_Firm2_EPEC,Total_Investments_Technology_EPEC,Total_Generation_Technology_EPEC,Total_Generation_Technology_Existing_EPEC,Total_Generation_Technology_Candidate_EPEC, Total_Generation_Technology_node1_EPEC, Total_Generation_Technology_node2_EPEC, Total_Generation_Technology_node3_EPEC,Total_Emissions_Technology_Existing_EPEC,Total_Emissions_Technology_Candidate_EPEC,Total_Emissions_Technology_Existing_Cummulative_EPEC,Total_Emissions_Technology_Candidate_Cummulative_EPEC)

end
