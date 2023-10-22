function loadinputs_CentralPlanner_scenario_PJM(scenario_tax,Trans_Cap,folder::String)

    #Congestion
    #Trans_Cap=CSV.File(folder *"/congestion_parameter.csv") |> Tables.matrix
#sce=CSV.File(folder *"/scenario.csv") |> Tables.matrix
    #sce=5
    #Sets
    #Investemnt Options
    set_opt_thermalgenerators_numbertechnologies=1:5
    set_opt_winds_numbertechnologies=1:2
    set_opt_thermalgenerators = 1:10
    set_opt_winds = 1:4

    #Existing Units
    set_thermalgenerators = 1:12
    set_winds = 1:6
    set_demands = 1
    set_nodes = 1:3
    set_nodes_ref=1
    set_nodes_noref=2:3
    #Operating conditions-scenarios-clsuters
    set_scenarios= 1
    set_times= 1:8
    #Penalty
    P=100000
    V=1000000
    max_demand=1
    R=0.15

    #For now I will keep demand, I need to change this to 2050. Analyze whether demand is enough to incentivize investments.     

    #demand_PJM_2050.csv based on demand_PJM.csv with annual load growth of 0.01 and 33 years in the future. PJM data is from 2017.

    p_D_rowdata=CSV.File(folder *"/demand_PJM_2050.csv") |> Tables.matrix
    p_D=p_D_rowdata'

    p_D_MW=p_D*max_demand
    D= maximum(sum(p_D_MW, dims=1))

    Υ_SR=zeros(length(set_times))

    for t in set_times
    Υ_SR[t]=p_D[t]*0.1
    end

    #Scenarios
    a=1/length(set_scenarios)
    γ=zeros(length(set_scenarios))
    for s in set_scenarios
    γ[s]=a
    end

    p_lambda_upper_par=CSV.File(folder *"/upper_bound_price_PJM.csv") |> Tables.matrix


    p_Carbprice_par=CSV.File(folder *"/carbontax_scenarios.csv") |> Tables.matrix

    Τ=[p_Carbprice_par[scenario_tax]]
    p_lambda_upper=[p_lambda_upper_par[scenario_tax]]

    wind_rowdata= CSV.File(folder *"/wind_existing_PJM.csv") |> Tables.matrix
    wind=wind_rowdata'

    wind_opt_rowdata= CSV.File(folder *"/wind_options_PJM.csv") |> Tables.matrix
    wind_opt=wind_opt_rowdata'

    Ns_H= CSV.File(folder *"/weights_PJM.csv") |> Tables.matrix



    network=[ 1  2  Trans_Cap  500;
              1  3  100000     500;
              2  3  100000     500;
              2  1  Trans_Cap  500;
              3  1  100000     500;
              3  2  100000     500]

    start_node=network[:,1]
    end_node=network[:,2]
    F_max=network[:,3]
    B=network[:,4]

    n_node=3
    n_link=6

    links = Array{Tuple{Int64, Int64},2}(undef, n_link, 1)

    for i=1:n_link
      links[i] = (start_node[i], end_node[i])
    end

    links_rev = Array{Tuple{Int64, Int64},2}(undef, n_link, 1)

    for i=1:n_link
      links_rev[i] = (end_node[i], start_node[i])
    end

    F_max_dict=Dict()
    B_dict=Dict()

    for i=1:n_link
      F_max_dict[(start_node[i], end_node[i])] = F_max[i]
      B_dict[(start_node[i], end_node[i])] = B[i]
    end

    MapG=[(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,2),(8,2),(9,2),(10,2),(11,2),(12,2)]
    MapG_opt=[(1,1),(2,1),(3,1),(4,1),(5,1),(6,2),(7,2),(8,2),(9,2),(10,2)]
    #Define this according to zones
    MapD=[(1,2)]
    MapW=[(1,2),(2,2),(3,2),(4,3),(5,3),(6,3)]
    MapW_opt=[(1,2),(2,2),(3,3),(4,3)]

    #NREL 2020 Data
    nodes_th=2
    nodes_rn=2

    #Nuclear and Coal in this case

    #=
    #Original PJM Capacity 
    tech_thermal=[600		4.40		0		10000000		1		53284/2		39695		0.0955		10.78		2.10		75		90		6
                  500		2.20		0		10000000		1		53896/2		12863		0.0531		7.93		3.3		  55		425		4
                  100		4.50		0		10000000		1		10067/2		11395		0.0531		13.92		3.6		  55		600		3
                  350		2.50		0		10000000		1		34242/2		20767		0.0531		12.01		2.64		55		425		7
                  1500	2.30		0		10000000		1		34509/2		118988		0		    10.46		0.66		60		0		  8
                  350		4.50		0		10000000		1		7954/2		11659		0.0741		17.05		3.18		55		600		9
                  600		4.40		0		10000000		1		53284/2		39695		0.0955		10.78		2.10		75		90		6
                  500		2.20		0		10000000		1		53896/2		12863		0.0531		7.93		3.3		  55		425		4
                  100		4.50		0		10000000		1		10067/2		11395		0.0531		13.92		3.6		  55		600		3
                  350		2.50		0		10000000		1		34242/2		20767		0.0531		12.01		2.64		55		425		7
                  1500	2.30		0		10000000		1		34509/2		118988		0		    10.46		0.66		60		0		  8
                  350		4.50		0		10000000		1		7954/2		11659		0.0741		17.05		3.18		55		600		9]
     =#
     #Retirements scenario PJM Capacity 
    #Order=Coal, CC, CT, ST, Nuclear, Oil
     #Ret Scenario3
     #Retirement Parameter
     #CC
     R_c=1
     #Coal, Steam Turbine and Oil
     R_t=1
     #Nuclear
     R_n=1

    #=

     #Ret Scenario2
     #Retirement Parameter
     #CC
     R_c=0.8
     #Coal, Steam Turbine and Oil
     R_t=1
     #Nuclear
     R_n=1

    #Ret Scenario1 
     #Retirement Parameter
     #CC
     R_c=0.6
     #Coal, Steam Turbine and Oil
     R_t=1
     #Nuclear
     R_n=1

    =#


    #Indices for set_tech
    capacity_per_unit=1
    var_om=2
    invcost=3
    maxBuilds=4
    ownership=5
    capacity_existingunits=6
    fixedcost=7
    EmissionsRate=8
    HeatRate=9
    fuelprice=10
    life=11
    RamUP=12
    Technology=13
    WACC=0.08

    tech_thermal=[600		4.40		0		10000000		1		(53284/2)*R_t		39695		0.0955		10.78		2.10		75		90		6
                  500		2.20		0		10000000		1		(53896/2)*R_c		12863		0.0531		7.93		3.3		  55		425		4
                  100		4.50		0		10000000		1		10067/2		      11395		0.0531		13.92		3.6		  55		600		3
                  350		2.50		0		10000000		1		(34242/2)*R_t		20767		0.0531		12.01		2.64		55		425		7
                  1500	2.30		0		10000000		1		(34509/2)*R_n		118988		0		    10.46		0.66		60		0		  8
                  350		4.50		0		10000000		1		(7954/2)*R_t		11659		0.0741		17.05		3.18		55		600		9
                  600		4.40		0		10000000		1		(53284/2)*R_t		39695		0.0955		10.78		2.10		75		90		6
                  500		2.20		0		10000000		1		(53896/2)*R_c		12863		0.0531		7.93		3.3		  55		425		4
                  100		4.50		0		10000000		1		10067/2		      11395		0.0531		13.92		3.6		  55		600		3
                  350		2.50		0		10000000		1		(34242/2)*R_t		20767		0.0531		12.01		2.64		55		425		7
                  1500	2.30		0		10000000		1		(34509/2)*R_n		118988		0		    10.46		0.66		60		0		  8
                  350		4.50		0		10000000		1		(7954/2)*R_t		11659		0.0741		17.05		3.18		55		600		9]

  Coal=[1,7] 
  CC=[2,8] 
  CT=[3,9]  
  #CT=[3,10]
  ST=[4,10]  
  Oil=[6,12]

  for i in Coal
    tech_thermal[i,var_om]=4.40
    tech_thermal[i,fuelprice]=2.09
    tech_thermal[i,HeatRate]=10.40
  end

  for i in CC
    tech_thermal[i,var_om]=2.20
    tech_thermal[i,fuelprice]=3.30
    tech_thermal[i,HeatRate]=7.72
  end

  for i in CT
    tech_thermal[i,var_om]=4.5
    tech_thermal[i,fuelprice]=3.60
    tech_thermal[i,HeatRate]=13.35
  end

  for i in ST
    tech_thermal[i,var_om]=4.40
    tech_thermal[i,fuelprice]=2.64
    tech_thermal[i,HeatRate]=12.15
  end


  for i in Oil
    tech_thermal[i,var_om]=4.5
    tech_thermal[i,fuelprice]=3.18
    tech_thermal[i,HeatRate]=17.41
  end


    tech_thermal_opt=[   650         6.9        5299096        10000000            1              0               53114        0.0096            9.751         2.01        75   96     1
                         650         10.7       6830748        10000000            1              0               58242        0.0096            12.507        2.01        75   96     2
                         65          4.5        982962         10000000            1              0               11395        0.0531            9.5145        2.81        55   600    3
                         440         2.2        1088328        10000000            1              0               12863        0.0531            6.4005        2.81        55   425    4
                         440         5.7        2778138        10000000            1              0               26994        0.0053             7.525        2.81        55   425    5
                         650         6.9        5299096        10000000            1              0               53114        0.0096            9.751         2.01        75   96     1
                         650         10.7       6830748        10000000            1              0               58242        0.0096            12.507        2.01        75   96     2
                         65          4.5        982962         10000000            1              0               11395        0.0531            9.5145        2.81        55   600    3
                         440         2.2        1088328        10000000            1              0               12863        0.0531            6.4005        2.81        55   425    4
                         440         5.7        2778138        10000000            1              0               26994        0.0053             7.525        2.81        55   425    5]

    tech_wind=[   300		0		1604886		10000000		1		10704/2		43205		0		0		0		30		0		1
                  300		0		1599902		10000000		1		6464/2		18760		0		0		0		30		0		2
                  300		0		1599902		10000000		1		8381/2		11944		0		0		0		30		0		3
                  300		0		1604886		10000000		1		10704/2		43205		0		0		0		30		0		1
                  300		0		1599902		10000000		1		6464/2		18760		0		0		0		30		0		2
                  300		0		1599902		10000000		1		8381/2		11944		0		0		0		30		0		3]
                  
    tech_wind_opt=[300         0.0              1604886        10000000             1             0                43205        0                    0          0.00        30    0  1
                   300         0.0              1599902        10000000             1             0                18760        0                    0          0.00        30    0  2
                   300         0.0              1604886        10000000             1             0                43205        0                    0          0.00        30    0  1
                   300         0.0              1599902        10000000             1             0                18760        0                    0          0.00        30    0  2]




    varcost_thermal=zeros(length(set_thermalgenerators))
    for i in 1:length(set_thermalgenerators)
    varcost_thermal[i]=tech_thermal[i,var_om]+tech_thermal[i,HeatRate]*tech_thermal[i,fuelprice]
    end

    varcost_thermal_opt=zeros(length(set_opt_thermalgenerators))
    for i in 1:length(set_opt_thermalgenerators)
    varcost_thermal_opt[i]=tech_thermal_opt[i,var_om]+tech_thermal_opt[i,HeatRate]*tech_thermal_opt[i,fuelprice]
    end

    varcost_wind=zeros(length(set_winds))
    for i in 1:length(set_winds)
    varcost_wind[i]=tech_wind[i,var_om]+tech_wind[i,HeatRate]*tech_wind[i,fuelprice]
    end

    varcost_wind_opt=zeros(length(set_opt_winds))
    for i in 1:length(set_opt_winds)
    varcost_wind_opt[i]=tech_wind_opt[i,var_om]+tech_wind_opt[i,HeatRate]*tech_wind_opt[i,fuelprice]
    end

    CRF_thermal_opt=zeros(length(set_opt_thermalgenerators))

    for i in 1:length(set_opt_thermalgenerators)
    CRF_thermal_opt[i]=WACC/(1 - (1 / ( (1 + WACC)^tech_thermal_opt[i,life])))
    end

    CRF_wind_opt=zeros(length(set_opt_winds))

    for i in 1:length(set_opt_winds)
    CRF_wind_opt[i]=WACC/(1 - (1 / ( (1 + WACC)^tech_wind_opt[i,life])))
    end

return (set_opt_thermalgenerators_numbertechnologies,set_opt_winds_numbertechnologies,set_opt_thermalgenerators,set_opt_winds,set_thermalgenerators,set_winds,set_demands,set_nodes,set_nodes_ref,set_nodes_noref,set_scenarios,set_times,P,V,p_D,D,max_demand,Υ_SR,γ,Τ,p_lambda_upper,wind,wind_opt,Ns_H,n_link,links,links_rev,F_max_dict,B_dict,MapG,MapG_opt,MapD,MapW,MapW_opt,tech_thermal,tech_thermal_opt,tech_wind,tech_wind_opt,capacity_per_unit,var_om,invcost,maxBuilds,ownership,capacity_existingunits,fixedcost,EmissionsRate,HeatRate,fuelprice,life,RamUP,Technology,WACC,varcost_thermal,varcost_thermal_opt,varcost_wind,varcost_wind_opt,CRF_thermal_opt,CRF_wind_opt)
end
