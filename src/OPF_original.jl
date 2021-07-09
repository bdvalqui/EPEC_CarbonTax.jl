function OPF_original(optimizer,x_w_value,x_e_value,set_opt_thermalgenerators_numbertechnologies,set_opt_winds_numbertechnologies,set_opt_thermalgenerators,set_opt_winds,set_thermalgenerators,set_winds,set_demands,set_nodes,set_nodes_ref,set_nodes_noref,set_scenarios,set_times,P,V,p_D,D,max_demand,Υ_SR,γ,Τ,p_lambda_upper,wind,wind_opt,Ns_H,n_link,links,links_rev,F_max_dict,B_dict,MapG,MapG_opt,MapD,MapW,MapW_opt,tech_thermal,tech_thermal_opt,tech_wind,tech_wind_opt,capacity_per_unit,var_om,invcost,maxBuilds,ownership,capacity_existingunits,fixedcost,EmissionsRate,HeatRate,fuelprice,life,RamUP,Technology,WACC,varcost_thermal,varcost_thermal_opt,varcost_wind,varcost_wind_opt,CRF_thermal_opt,CRF_wind_opt)

m=Model(optimizer)

@variable(m, f[link in links,t in set_times,s in set_scenarios] )
@variable(m, θ[n in set_nodes,t in set_times,s in set_scenarios])
@variable(m, p_G_e[e in set_thermalgenerators,t in set_times,s in set_scenarios]>= 0)
@variable(m, p_G_e_opt[e in set_opt_thermalgenerators,t in set_times,s in set_scenarios]>= 0)
@variable(m, p_G_w[w in set_winds,t in set_times,s in set_scenarios]>= 0)
@variable(m, p_G_w_opt[w in set_opt_winds,t in set_times,s in set_scenarios]>= 0)
@variable(m, r_d[d in set_demands,t in set_times,s in set_scenarios]>= 0)
@variable(m, r_w[w in set_winds,t in set_times,s in set_scenarios]>= 0)
@variable(m, r_w_opt[w in set_opt_winds,t in set_times,s in set_scenarios]>= 0)
#@variable(m, x_e[e in set_opt_thermalgenerators]>= 0)
#@variable(m, x_w[w in set_opt_winds]>= 0)
@variable(m, υ_SR[e in set_thermalgenerators,t in set_times,s in set_scenarios]>= 0)
@variable(m, υ_SR_opt[e in set_opt_thermalgenerators,t in set_times,s in set_scenarios]>= 0)

@objective(m, Min,sum(sum((
                  +sum(varcost_thermal[e]*p_G_e[e,t,s] for e in set_thermalgenerators)
                  +sum(varcost_thermal_opt[e]*p_G_e_opt[e,t,s]  for e in set_opt_thermalgenerators)
                  +sum(varcost_wind[w]*p_G_w[w,t,s]  for w in set_winds)
                  +sum(varcost_wind_opt[w]*p_G_w_opt[w,t,s]  for w in set_opt_winds)
                  +sum(V*r_d[d,t,s]  for d in set_demands)
                  +sum(P*r_w[w,t,s]  for w in set_winds)
                  +sum(P*r_w_opt[w,t,s]  for w in set_opt_winds)
                  +sum(Τ[s]*tech_thermal[e,EmissionsRate]*tech_thermal[e,HeatRate]*p_G_e[e,t,s] for e in set_thermalgenerators)
                  +sum(Τ[s]*tech_thermal_opt[e,EmissionsRate]*tech_thermal_opt[e,HeatRate]*p_G_e_opt[e,t,s] for e in set_opt_thermalgenerators))*γ[s]*Ns_H[t] for s in set_scenarios) for t in set_times)
                  +sum(tech_thermal_opt[e,invcost]*CRF_thermal_opt[e]*x_e_value[e]  for e in set_opt_thermalgenerators)
                  +sum(tech_wind_opt[w,invcost]*CRF_wind_opt[w]*x_w_value[w]  for w in set_opt_winds)
                  +sum(tech_thermal[e,fixedcost]*(tech_thermal[e,capacity_existingunits])  for e in set_thermalgenerators)
                  +sum(tech_wind[w,fixedcost]*(tech_wind[w,capacity_existingunits])  for w in set_winds)
                  +sum(tech_thermal_opt[e,fixedcost]*(x_e_value[e])  for e in set_opt_thermalgenerators)
                  +sum(tech_wind_opt[w,fixedcost]*(x_w_value[w])  for w in set_opt_winds))

#=
@constraint(m, constraint1,  sum(tech_thermal[e,capacity_existingunits] for e in set_thermalgenerators)
                            +sum(tech_wind[w,capacity_existingunits] for w in set_winds)
                            +sum(x_w_value[w] for w in set_opt_winds)
                            +sum(x_e_value[e] for e in set_opt_thermalgenerators) >= D*(1+R))
=#

@constraint(m, constraint2[w in set_opt_winds], x_w_value[w] <= tech_wind_opt[w,maxBuilds])

@constraint(m, constraint3[e in set_thermalgenerators,t in set_times,s in set_scenarios], p_G_e[e,t,s]+υ_SR[e,t,s] <= tech_thermal[e,capacity_existingunits])

@constraint(m, constraint4[e in set_opt_thermalgenerators,t in set_times,s in set_scenarios], p_G_e_opt[e,t,s]+ υ_SR_opt[e,t,s] <= x_e_value[e])

@constraint(m, constraint5[w in set_winds,t in set_times,s in set_scenarios], p_G_w[w,t,s] +r_w[w,t,s] == tech_wind[w,capacity_existingunits]*wind[w,t])

@constraint(m, constraint6[w in set_opt_winds,t in set_times,s in set_scenarios], p_G_w_opt[w,t,s] +r_w_opt[w,t,s] == x_w_value[w]*wind_opt[w,t])

@constraint(m, constraint7[j in links,t in set_times,s in set_scenarios], f[j,t,s] == B_dict[j]*(θ[j[1],t,s]-θ[j[2],t,s]))

@constraint(m, constraint8[j in links,t in set_times,s in set_scenarios], f[j,t,s] <= F_max_dict[j])

@constraint(m, constraint9[t in set_times,s in set_scenarios], θ[set_nodes_ref,t,s] == 0 )

@constraint(m, constraint10[n in set_nodes, t in set_times,s in set_scenarios],
              +sum(p_G_e[e,t,s] for e in set_thermalgenerators if n == MapG[e][2])
              +sum(p_G_e_opt[e,t,s] for e in set_opt_thermalgenerators if n == MapG_opt[e][2])
              +sum(p_G_w[w,t,s] for w in set_winds if n == MapW[w][2])
              +sum(p_G_w_opt[w,t,s] for w in set_opt_winds if n == MapW_opt[w][2])
              +sum(r_d[d,t,s] for d in set_demands if n == MapD[d][2])
              -sum(p_D[d,t]*max_demand for d in set_demands if n == MapD[d][2])
              -sum(f[j,t,s] for j in links if n == j[1])== 0)

@constraint(m, constraint11[t in set_times,s in set_scenarios], sum(υ_SR[e,t,s] for e in set_thermalgenerators) + sum(υ_SR_opt[e,t,s] for e in set_opt_thermalgenerators) == Υ_SR[t])

@constraint(m, constraint12[e in set_thermalgenerators,t in set_times,s in set_scenarios], υ_SR[e,t,s] <=tech_thermal[e,capacity_existingunits]*tech_thermal[e,RamUP]/tech_thermal[e,capacity_per_unit])

@constraint(m, constraint13[e in set_opt_thermalgenerators,t in set_times,s in set_scenarios], υ_SR_opt[e,t,s] <=x_e_value[e]*tech_thermal_opt[e,RamUP]/tech_thermal_opt[e,capacity_per_unit])

@time optimize!(m)

#cd("C:\\Users\\braya\\Desktop\\Doctorado\\Doctorado EEUU\\Semesters\\Spring Semester 2021\\DTU Course\\Project\\Step 3\\Code\\Julia")
#Print output
println("Number of variables and Constraints:")
display(m)

status = termination_status(m)
println("The solution status is: $status")
println("")
println("Optimal Power Flow Solution")
println("")
syscost_det_OPF=objective_value(m)

println("Total Cost:",syscost_det_OPF)

p_G_e_value=zeros(length(set_thermalgenerators),length(set_times),length(set_scenarios))
for t in set_times, s in set_scenarios, e in set_thermalgenerators
#println("Production level of existing thermal generator $e in time $t under scenario $s:",JuMP.value.(p_G_e[e,t,s]))
  p_G_e_value[e,t,s]=JuMP.value.(p_G_e[e,t,s])
end

p_G_e_value_node1=zeros(length(set_thermalgenerators),length(set_times),length(set_scenarios))

for e in set_thermalgenerators if 1 == MapG[e][2]
for t in set_times, s in set_scenarios
  p_G_e_value_node1[e,t,s]=JuMP.value.(p_G_e[e,t,s])
end
end
end


p_G_e_value_node2=zeros(length(set_thermalgenerators),length(set_times),length(set_scenarios))

for e in set_thermalgenerators if 2 == MapG[e][2]
for t in set_times, s in set_scenarios
  p_G_e_value_node2[e,t,s]=JuMP.value.(p_G_e[e,t,s])
end
end
end

p_G_e_value_node3=zeros(length(set_thermalgenerators),length(set_times),length(set_scenarios))

for e in set_thermalgenerators if 3 == MapG[e][2]
for t in set_times, s in set_scenarios
  p_G_e_value_node3[e,t,s]=JuMP.value.(p_G_e[e,t,s])
end
end
end

p_G_e_opt_value=zeros(length(set_opt_thermalgenerators),length(set_times),length(set_scenarios))
for t in set_times, s in set_scenarios, e in set_opt_thermalgenerators
#println("Production level of candidate thermal generator $e in time $t under scenario $s:",JuMP.value.(p_G_e_opt[e,t,s]))
  p_G_e_opt_value[e,t,s]=JuMP.value.(p_G_e_opt[e,t,s])
end

p_G_e_opt_value_node1=zeros(length(set_opt_thermalgenerators),length(set_times),length(set_scenarios))

for e in set_opt_thermalgenerators if 1 == MapG_opt[e][2]
for t in set_times, s in set_scenarios
  p_G_e_opt_value_node1[e,t,s]=JuMP.value.(p_G_e_opt[e,t,s])
end
end
end


p_G_e_opt_value_node2=zeros(length(set_opt_thermalgenerators),length(set_times),length(set_scenarios))

for e in set_opt_thermalgenerators if 2 == MapG_opt[e][2]
for t in set_times, s in set_scenarios
  p_G_e_opt_value_node2[e,t,s]=JuMP.value.(p_G_e_opt[e,t,s])
end
end
end

p_G_e_opt_value_node3=zeros(length(set_opt_thermalgenerators),length(set_times),length(set_scenarios))

for e in set_opt_thermalgenerators if 3 == MapG_opt[e][2]
for t in set_times, s in set_scenarios
  p_G_e_opt_value_node3[e,t,s]=JuMP.value.(p_G_e_opt[e,t,s])
end
end
end


υ_SR_value=zeros(length(set_thermalgenerators),length(set_times),length(set_scenarios))
for t in set_times, s in set_scenarios, e in set_thermalgenerators
#println("Spinning reserves of existing thermal generator $e in time $t under scenario $s:",JuMP.value.(υ_SR[e,t,s]))
  υ_SR_value[e,t,s]=JuMP.value.(υ_SR[e,t,s])
end

υ_SR_opt_value=zeros(length(set_opt_thermalgenerators),length(set_times),length(set_scenarios))
for t in set_times, s in set_scenarios, e in set_opt_thermalgenerators
#println("Spinning reserves of candidate thermal generator $e in time $t under scenario $s:",JuMP.value.(υ_SR_opt[e,t,s]))
  υ_SR_opt_value[e,t,s]=JuMP.value.(υ_SR_opt[e,t,s])
end

p_G_w_value=zeros(length(set_winds),length(set_times),length(set_scenarios))
for t in set_times, s in set_scenarios, w in set_winds
#println("Production level of renewable unit $w in time $t under scenario $s:",JuMP.value.(p_G_w[w,t,s]))
  p_G_w_value[w,t,s]=JuMP.value.(p_G_w[w,t,s])
end

p_G_w_value_node1=zeros(length(set_winds),length(set_times),length(set_scenarios))
for w in set_winds if 1 == MapW[w][2]
for t in set_times, s in set_scenarios
  p_G_w_value_node1[w,t,s]=JuMP.value.(p_G_w[w,t,s])
end
end
end

p_G_w_value_node2=zeros(length(set_winds),length(set_times),length(set_scenarios))
for w in set_winds if 2 == MapW[w][2]
for t in set_times, s in set_scenarios
  p_G_w_value_node2[w,t,s]=JuMP.value.(p_G_w[w,t,s])
end
end
end

p_G_w_value_node3=zeros(length(set_winds),length(set_times),length(set_scenarios))
for w in set_winds if 3 == MapW[w][2]
for t in set_times, s in set_scenarios
  p_G_w_value_node3[w,t,s]=JuMP.value.(p_G_w[w,t,s])
end
end
end

p_G_w_opt_value=zeros(length(set_opt_winds),length(set_times),length(set_scenarios))
for t in set_times, s in set_scenarios, w in set_opt_winds
#println("Production level of candidate renewable unit $w in time $t under scenario $s: ",JuMP.value.(p_G_w_opt[w,t,s]))
  p_G_w_opt_value[w,t,s]=JuMP.value.(p_G_w_opt[w,t,s])
end

p_G_w_opt_value_node1=zeros(length(set_opt_winds),length(set_times),length(set_scenarios))
for w in set_opt_winds if 1 == MapW_opt[w][2]
for t in set_times, s in set_scenarios
  p_G_w_opt_value_node1[w,t,s]=JuMP.value.(p_G_w_opt[w,t,s])
end
end
end

p_G_w_opt_value_node2=zeros(length(set_opt_winds),length(set_times),length(set_scenarios))
for w in set_opt_winds if 2 == MapW_opt[w][2]
for t in set_times, s in set_scenarios
  p_G_w_opt_value_node2[w,t,s]=JuMP.value.(p_G_w_opt[w,t,s])
end
end
end

p_G_w_opt_value_node3=zeros(length(set_opt_winds),length(set_times),length(set_scenarios))
for w in set_opt_winds if 3 == MapW_opt[w][2]
for t in set_times, s in set_scenarios
  p_G_w_opt_value_node3[w,t,s]=JuMP.value.(p_G_w_opt[w,t,s])
end
end
end

p_D_value=zeros(length(set_demands),length(set_scenarios))
for d in set_demands, s in set_scenarios
  p_D_value[d,s]=p_D[d,s]*max_demand
end
#println("Comsuption level of demand d: ",p_D_value)

r_d_value=zeros(length(set_demands),length(set_times),length(set_scenarios))
for t in set_times, s in set_scenarios, d in set_demands
#println("Unserved energy of demand $d in time $t under scenario $s:",JuMP.value.(r_d[d,t,s]))
  r_d_value[d,t,s]=JuMP.value.(r_d[d,t,s])
end

r_w_value=zeros(length(set_winds),length(set_times),length(set_scenarios))

for t in set_times, s in set_scenarios, w in set_winds
#println("Curtailment of renewable unit $w in time $t under scenario $s: ",JuMP.value.(r_w[w,t,s]))
  r_w_value[w,t,s]=JuMP.value.(r_w[w,t,s])
end

r_w_opt_value=zeros(length(set_opt_winds),length(set_times),length(set_scenarios))

for t in set_times, s in set_scenarios, w in set_opt_winds
#println("Curtailment of candidate renewable unit $w in time $t under scenario $s: ",JuMP.value.(r_w_opt[w,t,s]))
  r_w_opt_value[w,t,s]=JuMP.value.(r_w_opt[w,t,s])
end

Dual_constraint10=zeros(length(set_nodes),length(set_times),length(set_scenarios))

for   t in set_times, s in set_scenarios,n in set_nodes
   Dual_constraint10[n,t,s]= JuMP.dual(constraint10[n,t,s])/(Ns_H[t]*γ[s])
#println("Electricity Price in node $n in time $t under scenario $s: ", Dual_constraint10[n,t,s])
end

Dual_constraint11=zeros(length(set_times),length(set_scenarios))
for   t in set_times, s in set_scenarios,
   Dual_constraint11[t,s]= JuMP.dual(constraint11[t,s])/(Ns_H[t]*γ[s])
#println("Sprinning reserve Price in time $t under scenario $s: ", Dual_constraint11[t,s])
end


θ_values=zeros(length(set_nodes),length(set_times),length(set_scenarios))

for   t in set_times, s in set_scenarios,n in set_nodes
   θ_values[n,t,s]= JuMP.value.(θ[n,t,s])
#println("Angle in node $n in time $t under scenario $s: ", θ_values[n,t,s])
end


f_value=zeros(n_link,length(set_times),length(set_scenarios))
global i=1
for j in links
for s in set_scenarios, t in set_times
f_value[i,t,s]=B_dict[j]*(θ_values[j[1],t,s]-θ_values[j[2],t,s])
#println("Power Flow lines $j in time $t under scenario $s: ", f_value[i,t,s])
end
global i=i+1
end

TotalCapCost=sum(sum(tech_thermal_opt[e,invcost]*CRF_thermal_opt[e]*x_e_value[e]  for e in set_opt_thermalgenerators)
             +sum(tech_wind_opt[w,invcost]*CRF_wind_opt[w]*x_w_value[w]  for w in set_opt_winds))

TotalFixedCost=sum(sum(tech_thermal[e,fixedcost]*(tech_thermal[e,capacity_existingunits])  for e in set_thermalgenerators)
             +sum(tech_wind[w,fixedcost]*(tech_wind[w,capacity_existingunits])  for w in set_winds)
             +sum(tech_thermal_opt[e,fixedcost]*(x_e_value[e])  for e in set_opt_thermalgenerators)
             +sum(tech_wind_opt[w,fixedcost]*(x_w_value[w])  for w in set_opt_winds))

TotalEmissionsCost= sum(sum((sum(Τ[s]*tech_thermal[e,EmissionsRate]*tech_thermal[e,HeatRate]*p_G_e_value[e,t,s] for e in set_thermalgenerators)
                   +sum(Τ[s]*tech_thermal_opt[e,EmissionsRate]*tech_thermal_opt[e,HeatRate]*p_G_e_opt_value[e,t,s] for e in set_opt_thermalgenerators))*γ[s]*Ns_H[t] for s in set_scenarios) for t in set_times)

TotalEmissions= sum(sum((sum(tech_thermal[e,EmissionsRate]*tech_thermal[e,HeatRate]*p_G_e_value[e,t,s] for e in set_thermalgenerators)
                        +sum(tech_thermal_opt[e,EmissionsRate]*tech_thermal_opt[e,HeatRate]*p_G_e_opt_value[e,t,s] for e in set_opt_thermalgenerators))*γ[s]*Ns_H[t] for s in set_scenarios) for t in set_times)

println("Total Emissions:", TotalEmissions)

TotalOpecost=sum(sum((sum(varcost_thermal[e]*p_G_e_value[e,t,s] for e in set_thermalgenerators)
                    +sum(varcost_thermal_opt[e]*p_G_e_opt_value[e,t,s]  for e in set_opt_thermalgenerators)
                    +sum(varcost_wind[w]*p_G_w_value[w,t,s]  for w in set_winds)
                    +sum(varcost_wind_opt[w]*p_G_w_opt_value[w,t,s]  for w in set_opt_winds))*γ[s]*Ns_H[t] for s in set_scenarios) for t in set_times)

println("Total Operating Cost:", TotalOpecost)

TotalCurtailmentcost=sum(sum((sum(P*r_w_value[w,t,s]  for w in set_winds)
                        +sum(P*r_w_opt_value[w,t,s]  for w in set_opt_winds))*γ[s]*Ns_H[t] for s in set_scenarios) for t in set_times)

TotalCost=TotalCapCost+TotalFixedCost+TotalEmissionsCost+TotalOpecost+TotalCurtailmentcost

Totalrevenue=     sum(sum((sum(Dual_constraint10[MapG[e][2],t,s]*p_G_e_value[e,t,s] for e in set_thermalgenerators)
                  +sum(Dual_constraint10[MapG_opt[e][2],t,s]*p_G_e_opt_value[e,t,s]  for e in set_opt_thermalgenerators)
                  +sum(Dual_constraint10[MapW[w][2],t,s]*p_G_w_value[w,t,s]  for w in set_winds)
                  +sum(Dual_constraint10[MapW_opt[w][2],t,s]*p_G_w_opt_value[w,t,s]  for w in set_opt_winds)
                  +sum(Dual_constraint11[t,s]*υ_SR_value[e,t,s] for e in set_thermalgenerators)
                  +sum(Dual_constraint11[t,s]*υ_SR_opt_value[e,t,s]  for e in set_opt_thermalgenerators))*γ[s]*Ns_H[t] for s in set_scenarios) for t in set_times)

println("Total Revenue:", Totalrevenue)


Total_Generation_Technology_CP=zeros(9,length(set_times))
Total_Generation_Technology_Existing_CP=zeros(9,length(set_times))
Total_Generation_Technology_Candidate_CP=zeros(9,length(set_times))

for i in 1:7
for t in set_times
Total_Generation_Technology_CP[i,t]=sum(p_G_e_value[e,t,1] for e in set_thermalgenerators if tech_thermal[e,Technology]==i;init=0)+sum(p_G_e_opt_value[e,t,1] for e in set_opt_thermalgenerators if tech_thermal_opt[e,Technology]==i;init=0)

Total_Generation_Technology_Candidate_CP[i,t]=sum(p_G_e_opt_value[e,t,1] for e in set_opt_thermalgenerators if tech_thermal_opt[e,Technology]==i;init=0)

Total_Generation_Technology_Existing_CP[i,t]=sum(p_G_e_value[e,t,1] for e in set_thermalgenerators if tech_thermal[e,Technology]==i;init=0)
end
end

global j=1
for i in 8:9
for t in set_times
Total_Generation_Technology_CP[i,t]=sum(p_G_w_value[w,t,1] for w in set_winds if tech_wind[w,Technology]==j;init=0)+sum(p_G_w_opt_value[w,t,1] for w in set_opt_winds if tech_wind_opt[w,Technology]==j;init=0)

Total_Generation_Technology_Candidate_CP[i,t]=sum(p_G_w_opt_value[w,t,1] for w in set_opt_winds if tech_wind_opt[w,Technology]==j;init=0)

Total_Generation_Technology_Existing_CP[i,t]=sum(p_G_w_value[w,t,1] for w in set_winds if tech_wind[w,Technology]==j;init=0)
end
global j=j+1
end


TotalOpecost=sum(sum((sum(varcost_thermal[e]*p_G_e_value[e,t,s] for e in set_thermalgenerators)
                    +sum(varcost_thermal_opt[e]*p_G_e_opt_value[e,t,s]  for e in set_opt_thermalgenerators)
                    +sum(varcost_wind[w]*p_G_w_value[w,t,s]  for w in set_winds)
                    +sum(varcost_wind_opt[w]*p_G_w_opt_value[w,t,s]  for w in set_opt_winds))*γ[s]*Ns_H[t] for s in set_scenarios) for t in set_times)

TotalOpecost_demandblock=zeros(length(set_times))

for t in set_times
TotalOpecost_demandblock[t]=sum((sum(varcost_thermal[e]*p_G_e_value[e,t,s] for e in set_thermalgenerators)
                    +sum(varcost_thermal_opt[e]*p_G_e_opt_value[e,t,s]  for e in set_opt_thermalgenerators)
                    +sum(varcost_wind[w]*p_G_w_value[w,t,s]  for w in set_winds)
                    +sum(varcost_wind_opt[w]*p_G_w_opt_value[w,t,s]  for w in set_opt_winds))*γ[s]*Ns_H[t] for s in set_scenarios)
end

println("Total Operating Cost:", TotalOpecost)

TotalCost=TotalCapCost+TotalFixedCost+TotalEmissionsCost+TotalOpecost

TotalRevenue_demandblock=zeros(length(set_times))

for t in set_times
TotalRevenue_demandblock[t]=sum((sum(Dual_constraint10[MapG[e][2],t,s]*p_G_e_value[e,t,s] for e in set_thermalgenerators)
                  +sum(Dual_constraint10[MapG_opt[e][2],t,s]*p_G_e_opt_value[e,t,s]  for e in set_opt_thermalgenerators)
                  +sum(Dual_constraint10[MapW[w][2],t,s]*p_G_w_value[w,t,s]  for w in set_winds)
                  +sum(Dual_constraint10[MapW_opt[w][2],t,s]*p_G_w_opt_value[w,t,s]  for w in set_opt_winds)
                  +sum(Dual_constraint11[t,s]*υ_SR_value[e,t,s] for e in set_thermalgenerators)
                  +sum(Dual_constraint11[t,s]*υ_SR_opt_value[e,t,s]  for e in set_opt_thermalgenerators))*γ[s]*Ns_H[t] for s in set_scenarios)
end

revenue_cost_CP=zeros(6)
revenue_cost_CP[1]=Totalrevenue*0.2
revenue_cost_CP[2]=TotalOpecost*0.2
revenue_cost_CP[3]=Totalrevenue*0.2
revenue_cost_CP[4]=TotalOpecost*0.2
revenue_cost_CP[3]=Totalrevenue*0.6
revenue_cost_CP[4]=TotalOpecost*0.6

#Thermal Generation
p_G_e_value_CP=zeros(18,length(set_times),length(set_scenarios))
p_G_e_value_node1_CP=zeros(18,length(set_times),length(set_scenarios))
p_G_e_value_node2_CP=zeros(18,length(set_times),length(set_scenarios))
p_G_e_value_node3_CP=zeros(18,length(set_times),length(set_scenarios))
p_G_w_value_node1_CP=zeros(8,length(set_times),length(set_scenarios))
p_G_w_value_node2_CP=zeros(8,length(set_times),length(set_scenarios))
p_G_w_value_node3_CP=zeros(8,length(set_times),length(set_scenarios))
υ_SR_value_CP=zeros(18,length(set_times),length(set_scenarios))

for t in set_times, s in set_scenarios, e in 1:8
p_G_e_value_CP[e,t,s]=p_G_e_value[e,t,s]
υ_SR_value_CP[e,t,s]=υ_SR_value[e,t,s]
p_G_e_value_node1_CP[e,t,s]=p_G_e_value_node1[e,t,s]
p_G_e_value_node2_CP[e,t,s]=p_G_e_value_node2[e,t,s]
p_G_e_value_node3_CP[e,t,s]=p_G_e_value_node3[e,t,s]
end

global j=1
for e in 9:18
for t in set_times
for s in set_scenarios
p_G_e_value_CP[e,t,s]=p_G_e_opt_value[j,t,s]
υ_SR_value_CP[e,t,s]=υ_SR_opt_value[j,t,s]
p_G_e_value_node1_CP[e,t,s]=p_G_e_opt_value_node1[j,t,s]
p_G_e_value_node2_CP[e,t,s]=p_G_e_opt_value_node2[j,t,s]
p_G_e_value_node3_CP[e,t,s]=p_G_e_opt_value_node3[j,t,s]
end
end
global j=j+1
end

#Wind Generation
p_G_w_value_CP=zeros(8,length(set_times),length(set_scenarios))

for t in set_times, s in set_scenarios, w in 1:4
p_G_w_value_CP[w,t,s]=p_G_w_value[w,t,s]
p_G_w_value_node1_CP[w,t,s]=p_G_w_value_node1[w,t,s]
p_G_w_value_node2_CP[w,t,s]=p_G_w_value_node2[w,t,s]
p_G_w_value_node3_CP[w,t,s]=p_G_w_value_node3[w,t,s]
end

global j=1
for w in 5:8
for t in set_times
for s in set_scenarios
p_G_w_value_CP[w,t,s]=p_G_w_opt_value[j,t,s]
p_G_w_value_node1_CP[w,t,s]=p_G_w_opt_value_node1[j,t,s]
p_G_w_value_node2_CP[w,t,s]=p_G_w_opt_value_node2[j,t,s]
p_G_w_value_node3_CP[w,t,s]=p_G_w_opt_value_node3[j,t,s]
end
end
global j=j+1
end

#================================#
Total_Generation_Technology_node1_CP=zeros(9,length(set_times))

for i in 1:7
for t in set_times
Total_Generation_Technology_node1_CP[i,t]=sum(p_G_e_value_node1[e,t,1] for e in set_thermalgenerators if tech_thermal[e,Technology]==i;init=0)+sum(p_G_e_opt_value_node1[e,t,1] for e in set_opt_thermalgenerators if tech_thermal_opt[e,Technology]==i;init=0)
end
end

global j=1
for i in 8:9
for t in set_times
Total_Generation_Technology_node1_CP[i,t]=sum(p_G_w_value_node1[w,t,1] for w in set_winds if tech_wind[w,Technology]==j;init=0)+sum(p_G_w_opt_value_node1[w,t,1] for w in set_opt_winds if tech_wind_opt[w,Technology]==j;init=0)
end
global j=j+1
end

#================================#
Total_Generation_Technology_node2_CP=zeros(9,length(set_times))

for i in 1:7
for t in set_times
Total_Generation_Technology_node2_CP[i,t]=sum(p_G_e_value_node2[e,t,1] for e in set_thermalgenerators if tech_thermal[e,Technology]==i;init=0)+sum(p_G_e_opt_value_node2[e,t,1] for e in set_opt_thermalgenerators if tech_thermal_opt[e,Technology]==i;init=0)
end
end

global j=1
for i in 8:9
for t in set_times
Total_Generation_Technology_node2_CP[i,t]=sum(p_G_w_value_node2[w,t,1] for w in set_winds if tech_wind[w,Technology]==j;init=0)+sum(p_G_w_opt_value_node2[w,t,1] for w in set_opt_winds if tech_wind_opt[w,Technology]==j;init=0)
end
global j=j+1
end

#===================================#
Total_Generation_Technology_node3_CP=zeros(9,length(set_times))

for i in 1:7
for t in set_times
Total_Generation_Technology_node3_CP[i,t]=sum(p_G_e_value_node3[e,t,1] for e in set_thermalgenerators if tech_thermal[e,Technology]==i;init=0)+sum(p_G_e_opt_value_node3[e,t,1] for e in set_opt_thermalgenerators if tech_thermal_opt[e,Technology]==i;init=0)
end
end

global j=1
for i in 8:9
for t in set_times
Total_Generation_Technology_node3_CP[i,t]=sum(p_G_w_value_node3[w,t,1] for w in set_winds if tech_wind[w,Technology]==j;init=0)+sum(p_G_w_opt_value_node3[w,t,1] for w in set_opt_winds if tech_wind_opt[w,Technology]==j;init=0)
end
global j=j+1
end


return (syscost_det_OPF,TotalEmissions,TotalRevenue_demandblock,TotalOpecost_demandblock,revenue_cost_CP,TotalCapCost,TotalFixedCost,TotalEmissionsCost,TotalOpecost,TotalCurtailmentcost,p_G_e_value_CP,p_G_e_value_node1_CP,p_G_e_value_node2_CP,p_G_e_value_node3_CP,p_G_w_value_CP,p_G_w_value_node1_CP,p_G_w_value_node2_CP,p_G_w_value_node3_CP,υ_SR_value_CP,Dual_constraint10,Dual_constraint11,Total_Generation_Technology_CP,Total_Generation_Technology_Existing_CP,Total_Generation_Technology_Candidate_CP, Total_Generation_Technology_node1_CP, Total_Generation_Technology_node2_CP, Total_Generation_Technology_node3_CP)

end
