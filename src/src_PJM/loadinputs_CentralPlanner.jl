function loadinputs_CentralPlanner(folder::String)

    #Congestion
    Trans_Cap=CSV.File(folder *"/congestion_parameter.csv") |> Tables.matrix
#sce=CSV.File(folder *"/scenario.csv") |> Tables.matrix
    sce=5
    #Sets
    #Investemnt Options
    set_opt_thermalgenerators_numbertechnologies=1:5
    set_opt_winds_numbertechnologies=1:2
    set_opt_thermalgenerators = 1:10
    set_opt_winds = 1:4



    #Existing Units
    set_thermalgenerators = 1:8
    set_winds = 1:4
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


    p_D_rowdata=CSV.File(folder *"/demand.csv") |> Tables.matrix
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

    p_lambda_upper_par=CSV.File(folder *"/upper_bound_price.csv") |> Tables.matrix


    p_Carbprice_par=CSV.File(folder *"/carbontax_scenarios.csv") |> Tables.matrix

    Τ=[p_Carbprice_par[sce]]
    p_lambda_upper=[p_lambda_upper_par[sce]]

    wind_rowdata= CSV.File(folder *"/wind_existing.csv") |> Tables.matrix
    wind=wind_rowdata'

    wind_opt_rowdata= CSV.File(folder *"/wind_options.csv") |> Tables.matrix

    wind_opt=wind_opt_rowdata'

    Ns_H= CSV.File(folder *"/weights.csv") |> Tables.matrix


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

    MapG=[(1,1),(2,1),(3,1),(4,1),(5,2),(6,2),(7,2),(8,2)]
    MapG_opt=[(1,1),(2,1),(3,1),(4,1),(5,1),(6,2),(7,2),(8,2),(9,2),(10,2)]
    #Define this according to zones
    MapD=[(1,2)]
    MapW=[(1,2),(2,2),(3,3),(4,3)]
    MapW_opt=[(1,2),(2,2),(3,3),(4,3)]

    #NREL 2020 Data
    nodes_th=2
    nodes_rn=2
    C_GasCT=16000
    C_GasCC=9000
    C_Nuclear=2500
    C_Coal=8500
    C_Wind=12500
    C_Solar=1500

    #Nuclear and Coal in this case
    tech_thermal=[65          4.5        982962         10000000            1             C_GasCT/nodes_th             11395        0.0531            9.5145        2.81        55   600   3
                  440         2.2        1088328        10000000            1             C_GasCC/nodes_th             12863        0.0531            6.4005        2.81        55   425   4
                  1500        2.3        7185655        10000000            1             C_Nuclear/nodes_th           118988       0                 10.461        0.66        60   0     6
                  650         4.4        4149988        10000000            1             C_Coal/nodes_th              39695        0.0955             8.638        2.01        75   90    7
                  65          4.5        982962         10000000            1             C_GasCT/nodes_th             11395        0.0531            9.5145        2.81        55   600   3
                  440         2.2        1088328        10000000            1             C_GasCC/nodes_th             12863        0.0531            6.4005        2.81        55   425   4
                  1500        2.3        7185655        10000000            1             C_Nuclear/nodes_th           118988       0                 10.461        0.66        60   0     6
                  650         4.4        4149988        10000000            1             C_Coal/nodes_th              39695        0.0955             8.638        2.01        75   90    7]

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

    tech_wind=[    300         0.0              1604886        10000000            1        C_Wind/nodes_rn       43205        0                    0          0.00        30   0    1
                   300         0.0              1599902        10000000            1        C_Solar/nodes_rn      18760        0                    0          0.00        30   0    2
                   300         0.0              1604886        10000000            1        C_Wind/nodes_rn       43205        0                    0          0.00        30   0    1
                   300         0.0              1599902        10000000            1        C_Solar/nodes_rn      18760        0                    0          0.00        30   0    2]

    tech_wind_opt=[300         0.0              1604886        10000000             1             0                43205        0                    0          0.00        30    0  1
                   300         0.0              1599902        10000000             1             0                18760        0                    0          0.00        30    0  2
                   300         0.0              1604886        10000000             1             0                43205        0                    0          0.00        30    0  1
                   300         0.0              1599902        10000000             1             0                18760        0                    0          0.00        30    0  2]

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

    varcost_thermal=zeros(8)
    for i in 1:8
    varcost_thermal[i]=tech_thermal[i,var_om]+tech_thermal[i,HeatRate]*tech_thermal[i,fuelprice]
    end

    varcost_thermal_opt=zeros(10)
    for i in 1:10
    varcost_thermal_opt[i]=tech_thermal_opt[i,var_om]+tech_thermal_opt[i,HeatRate]*tech_thermal_opt[i,fuelprice]
    end

    varcost_wind=zeros(4)
    for i in 1:4
    varcost_wind[i]=tech_wind[i,var_om]+tech_wind[i,HeatRate]*tech_wind[i,fuelprice]
    end

    varcost_wind_opt=zeros(4)
    for i in 1:4
    varcost_wind_opt[i]=tech_wind_opt[i,var_om]+tech_wind_opt[i,HeatRate]*tech_wind_opt[i,fuelprice]
    end

    CRF_thermal_opt=zeros(10)

    for i in 1:10
    CRF_thermal_opt[i]=WACC/(1 - (1 / ( (1 + WACC)^tech_thermal_opt[i,life])))
    end

    CRF_wind_opt=zeros(4)

    for i in 1:4
    CRF_wind_opt[i]=WACC/(1 - (1 / ( (1 + WACC)^tech_wind_opt[i,life])))
    end


return (set_opt_thermalgenerators_numbertechnologies,set_opt_winds_numbertechnologies,set_opt_thermalgenerators,set_opt_winds,set_thermalgenerators,set_winds,set_demands,set_nodes,set_nodes_ref,set_nodes_noref,set_scenarios,set_times,P,V,p_D,D,max_demand,Υ_SR,γ,Τ,p_lambda_upper,wind,wind_opt,Ns_H,n_link,links,links_rev,F_max_dict,B_dict,MapG,MapG_opt,MapD,MapW,MapW_opt,tech_thermal,tech_thermal_opt,tech_wind,tech_wind_opt,capacity_per_unit,var_om,invcost,maxBuilds,ownership,capacity_existingunits,fixedcost,EmissionsRate,HeatRate,fuelprice,life,RamUP,Technology,WACC,varcost_thermal,varcost_thermal_opt,varcost_wind,varcost_wind_opt,CRF_thermal_opt,CRF_wind_opt)
end
