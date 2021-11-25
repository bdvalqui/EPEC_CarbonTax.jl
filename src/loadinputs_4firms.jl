function loadinputs_4firms(x_w_value,x_e_value,folder::String)

    #Congestion
    Trans_Cap=CSV.File(folder *"/congestion_parameter.csv") |> Tables.matrix
#sce=CSV.File(folder *"/scenario.csv") |> Tables.matrix
#Trans_Cap=100000
    sce=5
    #Sets
    set_thermalgenerators_options_numbertechnologies=33:47
    set_wind_options_numbertechnologies=17:22
    set_thermalgenerators_options=33:62
    set_wind_options=17:28
    set_thermalgenerators_existingunits=1:32
    set_winds_existingunits=1:16
    #Investemnt Options
    #Existing Units
    set_thermalgenerators = 1:62
    set_winds = 1:28

    set_demands = 1
    set_nodes = 1:3
    set_nodes_ref=1
    set_nodes_noref=2:3
    #Operating conditions-scenarios-clsuters
    #set_scenarios= 1:3
    set_scenarios= 1
    #set_times= 1:3
    set_times= 1:8
    #Number of Firms (investors). There is also 1 competitive fringe
    numberfirms=3
    nodes_th=2
    nodes_rn=2
    #Penalty
    P=100000
    V=1000000

    thermal_ownership_options=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 2 2 2 2 2 3 3 3 3 3 1 1 1 1 1 2 2 2 2 2 3 3 3 3 3]

    wind_ownership_options=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 2 2 3 3 1 1 2 2 3 3]

    max_demand=1
    R=0.15

    global j=1
    x_w_p=zeros(length(set_winds))

    #We start the diagonalization algorithm with firm 1. So we need to solve the CP and then fixed the values for the units not own by firm 1
    global Leader=1

    for w in set_wind_options if wind_ownership_options[w]!=Leader
    x_w_p[w]=x_w_value[j]*(1/(numberfirms))
    global j=j+1

    if j==5
    global j=1
    end

    end
    end

    global j=1
    x_e_p=zeros(length(set_thermalgenerators))
    for e in set_thermalgenerators_options if thermal_ownership_options[e]!=Leader
    x_e_p[e]=x_e_value[j]*(1/numberfirms)
    global j=j+1

    if j==11
    global j=1
    end

    end
    end



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

    wind_rowdata= CSV.File(folder *"/wind_4firms.csv") |> Tables.matrix
    wind=wind_rowdata'

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


    MapG=[(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(17,2),(18,2),(19,2),(20,2),(21,2),(22,2),(23,2),(24,2),(25,2),(26,2),(27,2),(28,2),(29,2),(30,2),(31,2),(32,2),(33,1),(34,1),(35,1),(36,1),(37,1),(38,1),(39,1),(40,1),(41,1),(42,1),(43,1),(44,1),(45,1),(46,1),(47,1),(48,2),(49,2),(50,2),(51,2),(52,2),(53,2),(54,2),(55,2),(56,2),(57,2),(58,2),(59,2),(60,2),(61,2),(62,2)]

    #Define this according to zones
    MapD=[(1,2)]
    #MapW=[(1,2),(2,2),(3,2),(4,2),(5,3),(6,3),(7,3),(8,3),(9,2),(10,2),(11,2),(12,2),(13,3),(14,3),(15,3),(16,3)]
    MapW=[(1,2),(2,2),(3,2),(4,2),(5,2),(6,2),(7,2),(8,2),(9,3),(10,3),(11,3),(12,3),(13,3),(14,3),(15,3),(16,3),(17,2),(18,2),(19,2),(20,2),(21,2),(22,2),(23,3),(24,3),(25,3),(26,3),(27,3),(28,3)]


    #NREL 2020 Data
    C_GasCT=16000
    C_GasCC=9000
    C_Nuclear=2500
    C_Coal=8500
    C_Wind=12500
    C_Solar=1500
    firm1_share=0.15
    firm2_share=0.15
    firm3_share=0.15
    firm4_share=0.55



    tech_thermal=[65      4.5        982962         10000000            1         C_GasCT*firm1_share/(nodes_th)          11395        0.0531            9.5145        2.81        55   600      3
              440         2.2        1088328        10000000            1         C_GasCC*firm1_share/(nodes_th)          12863        0.0531            6.4005        2.81        55   425      4
              1500        2.3        7185655        10000000            1         C_Nuclear*firm1_share/(nodes_th)        118988       0                 10.461        0.66        60    0       6
              650         4.4        4149988        10000000            1         C_Coal*firm1_share/(nodes_th)           39695        0.0955             8.638        2.01        75    90      7
              65          4.5        982962         10000000            2         C_GasCT*firm2_share/(nodes_th)          11395        0.0531            9.5145        2.81        55   600      3
              440         2.2        1088328        10000000            2         C_GasCC*firm2_share/(nodes_th)          12863        0.0531            6.4005        2.81        55   425      4
              1500        2.3        7185655        10000000            2         C_Nuclear*firm2_share/(nodes_th)        118988       0                 10.461        0.66        60    0       6
              650         4.4        4149988        10000000            2         C_Coal*firm2_share/(nodes_th)           39695        0.0955             8.638        2.01        75    90      7
              65          4.5        982962         10000000            3         C_GasCT*firm3_share/(nodes_th)          11395        0.0531            9.5145        2.81        55   600      3
              440         2.2        1088328        10000000            3         C_GasCC*firm3_share/(nodes_th)          12863        0.0531            6.4005        2.81        55   425      4
              1500        2.3        7185655        10000000            3         C_Nuclear*firm3_share/(nodes_th)        118988       0                 10.461        0.66        60    0       6
              650         4.4        4149988        10000000            3         C_Coal*firm3_share/(nodes_th)           39695        0.0955             8.638        2.01        75    90      7
              65          4.5        982962         10000000            4         C_GasCT*firm4_share/(nodes_th)          11395        0.0531            9.5145        2.81        55   600      3
              440         2.2        1088328        10000000            4         C_GasCC*firm4_share/(nodes_th)          12863        0.0531            6.4005        2.81        55   425      4
              1500        2.3        7185655        10000000            4         C_Nuclear*firm4_share/(nodes_th)        118988       0                 10.461        0.66        60    0       6
              650         4.4        4149988        10000000            4         C_Coal*firm4_share/(nodes_th)           39695        0.0955             8.638        2.01        75    90      7
              65          4.5        982962         10000000            1         C_GasCT*firm1_share/(nodes_th)          11395        0.0531            9.5145        2.81        55   600      3
              440         2.2        1088328        10000000            1         C_GasCC*firm1_share/(nodes_th)          12863        0.0531            6.4005        2.81        55   425      4
              1500        2.3        7185655        10000000            1         C_Nuclear*firm1_share/(nodes_th)        118988       0                 10.461        0.66        60    0       6
              650         4.4        4149988        10000000            1         C_Coal*firm1_share/(nodes_th)           39695        0.0955             8.638        2.01        75    90      7
              65          4.5        982962         10000000            2         C_GasCT*firm2_share/(nodes_th)          11395        0.0531            9.5145        2.81        55   600      3
              440         2.2        1088328        10000000            2         C_GasCC*firm2_share/(nodes_th)          12863        0.0531            6.4005        2.81        55   425      4
              1500        2.3        7185655        10000000            2         C_Nuclear*firm2_share/(nodes_th)        118988       0                 10.461        0.66        60    0       6
              650         4.4        4149988        10000000            2         C_Coal*firm2_share/(nodes_th)           39695        0.0955             8.638        2.01        75    90      7
              65          4.5        982962         10000000            3         C_GasCT*firm3_share/(nodes_th)          11395        0.0531            9.5145        2.81        55   600      3
              440         2.2        1088328        10000000            3         C_GasCC*firm3_share/(nodes_th)          12863        0.0531            6.4005        2.81        55   425      4
              1500        2.3        7185655        10000000            3         C_Nuclear*firm3_share/(nodes_th)        118988       0                 10.461        0.66        60    0       6
              650         4.4        4149988        10000000            3         C_Coal*firm3_share/(nodes_th)           39695        0.0955             8.638        2.01        75    90      7
              65          4.5        982962         10000000            4         C_GasCT*firm4_share/(nodes_th)          11395        0.0531            9.5145        2.81        55   600      3
              440         2.2        1088328        10000000            4         C_GasCC*firm4_share/(nodes_th)          12863        0.0531            6.4005        2.81        55   425      4
              1500        2.3        7185655        10000000            4         C_Nuclear*firm4_share/(nodes_th)        118988       0                 10.461        0.66        60    0       6
              650         4.4        4149988        10000000            4         C_Coal*firm4_share/(nodes_th)           39695        0.0955             8.638        2.01        75    90      7
              650         6.9        5299096        10000000            1              0                                  53114        0.0096            9.751         2.01        75    90      1
              650         10.7       6830748        10000000            1              0                                  58242        0.0096            12.507        2.01        75    90      2
              65          4.5        982962         10000000            1              0                                  11395        0.0531            9.5145        2.81        55   600      3
              440         2.2        1088328        10000000            1              0                                  12863        0.0531            6.4005        2.81        55   425      4
              440         5.7        2778138        10000000            1              0                                  26994        0.0053             7.525        2.81        55   425      5
              650         6.9        5299096        10000000            2              0                                  53114        0.0096            9.751         2.01        75    90      1
              650         10.7       6830748        10000000            2              0                                  58242        0.0096            12.507        2.01        75    90      2
              65          4.5        982962         10000000            2              0                                  11395        0.0531            9.5145        2.81        55   600      3
              440         2.2        1088328        10000000            2              0                                  12863        0.0531            6.4005        2.81        55   425      4
              440         5.7        2778138        10000000            2              0                                  26994        0.0053             7.525        2.81        55   425      5
              650         6.9        5299096        10000000            3              0                                  53114        0.0096            9.751         2.01        75    90      1
              650         10.7       6830748        10000000            3              0                                  58242        0.0096            12.507        2.01        75    90      2
              65          4.5        982962         10000000            3              0                                  11395        0.0531            9.5145        2.81        55   600      3
              440         2.2        1088328        10000000            3              0                                  12863        0.0531            6.4005        2.81        55   425      4
              440         5.7        2778138        10000000            3              0                                  26994        0.0053             7.525        2.81        55   425      5
              650         6.9        5299096        10000000            1              0                                  53114        0.0096            9.751         2.01        75    90      1
              650         10.7       6830748        10000000            1              0                                  58242        0.0096            12.507        2.01        75    90      2
              65          4.5        982962         10000000            1              0                                  11395        0.0531            9.5145        2.81        55   600      3
              440         2.2        1088328        10000000            1              0                                  12863        0.0531            6.4005        2.81        55   425      4
              440         5.7        2778138        10000000            1              0                                  26994        0.0053             7.525        2.81        55   425      5
              650         6.9        5299096        10000000            2              0                                  53114        0.0096            9.751         2.01        75    90      1
              650         10.7       6830748        10000000            2              0                                  58242        0.0096            12.507        2.01        75    90      2
              65          4.5        982962         10000000            2              0                                  11395        0.0531            9.5145        2.81        55   600      3
              440         2.2        1088328        10000000            2              0                                  12863        0.0531            6.4005        2.81        55   425      4
              440         5.7        2778138        10000000            2              0                                  26994        0.0053             7.525        2.81        55   425      5
              650         6.9        5299096        10000000            3              0                                  53114        0.0096            9.751         2.01        75    90      1
              650         10.7       6830748        10000000            3              0                                  58242        0.0096            12.507        2.01        75    90      2
              65          4.5        982962         10000000            3              0                                  11395        0.0531            9.5145        2.81        55   600      3
              440         2.2        1088328        10000000            3              0                                  12863        0.0531            6.4005        2.81        55   425      4
              440         5.7        2778138        10000000            3              0                                  26994        0.0053             7.525        2.81        55   425      5]

tech_wind=[    300         0.0              1604886        10000000             1       C_Wind*firm1_share/(nodes_th)         43205        0                    0          0.00        30    0   1
               300         0.0              1599902        10000000             1       C_Solar*firm1_share/(nodes_th)        18760        0                    0          0.00        30    0   2
               300         0.0              1604886        10000000             2       C_Wind*firm2_share/(nodes_th)         43205        0                    0          0.00        30    0   1
               300         0.0              1599902        10000000             2       C_Solar*firm2_share/(nodes_th)        18760        0                    0          0.00        30    0   2
               300         0.0              1604886        10000000             3       C_Wind*firm3_share/(nodes_th)         43205        0                    0          0.00        30    0   1
               300         0.0              1599902        10000000             3       C_Solar*firm3_share/(nodes_th)        18760        0                    0          0.00        30    0   2
               300         0.0              1604886        10000000             4       C_Wind*firm4_share/(nodes_th)         43205        0                    0          0.00        30    0   1
               300         0.0              1599902        10000000             4       C_Solar*firm4_share/(nodes_th)        18760        0                    0          0.00        30    0   2
               300         0.0              1604886        10000000             1       C_Wind*firm1_share/(nodes_th)         43205        0                    0          0.00        30    0   1
               300         0.0              1599902        10000000             1       C_Solar*firm1_share/(nodes_th)        18760        0                    0          0.00        30    0   2
               300         0.0              1604886        10000000             2       C_Wind*firm2_share/(nodes_th)         43205        0                    0          0.00        30    0   1
               300         0.0              1599902        10000000             2       C_Solar*firm2_share/(nodes_th)        18760        0                    0          0.00        30    0   2
               300         0.0              1604886        10000000             3       C_Wind*firm3_share/(nodes_th)         43205        0                    0          0.00        30    0   1
               300         0.0              1599902        10000000             3       C_Solar*firm3_share/(nodes_th)        18760        0                    0          0.00        30    0   2
               300         0.0              1604886        10000000             4       C_Wind*firm4_share/(nodes_th)         43205        0                    0          0.00        30    0   1
               300         0.0              1599902        10000000             4       C_Solar*firm4_share/(nodes_th)        18760        0                    0          0.00        30    0   2
               300         0.0              1604886        10000000             1             0                               43205        0                    0          0.00        30    0   1
               300         0.0              1599902        10000000             1             0                               18760        0                    0          0.00        30    0   2
               300         0.0              1604886        10000000             2             0                               43205        0                    0          0.00        30    0   1
               300         0.0              1599902        10000000             2             0                               18760        0                    0          0.00        30    0   2
               300         0.0              1604886        10000000             3             0                               43205        0                    0          0.00        30    0   1
               300         0.0              1599902        10000000             3             0                               18760        0                    0          0.00        30    0   2
               300         0.0              1604886        10000000             1             0                               43205        0                    0          0.00        30    0   1
               300         0.0              1599902        10000000             1             0                               18760        0                    0          0.00        30    0   2
               300         0.0              1604886        10000000             2             0                               43205        0                    0          0.00        30    0   1
               300         0.0              1599902        10000000             2             0                               18760        0                    0          0.00        30    0   2
               300         0.0              1604886        10000000             3             0                               43205        0                    0          0.00        30    0   1
               300         0.0              1599902        10000000             3             0                               18760        0                    0          0.00        30    0   2]

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

varcost_thermal=zeros(length(set_thermalgenerators))
for i in 1:length(set_thermalgenerators)
varcost_thermal[i]=tech_thermal[i,var_om]+tech_thermal[i,HeatRate]*tech_thermal[i,fuelprice]
end

varcost_wind=zeros(length(set_winds))
for i in 1:length(set_winds)
varcost_wind[i]=tech_wind[i,var_om]+tech_wind[i,HeatRate]*tech_wind[i,fuelprice]
end

CRF_thermal=zeros(length(set_thermalgenerators))

for i in 1:length(set_thermalgenerators)
CRF_thermal[i]=WACC/(1 - (1 / ( (1 + WACC)^tech_thermal[i,life])))
end

CRF_wind=zeros(length(set_winds))

for i in 1:length(set_winds)
CRF_wind[i]=WACC/(1 - (1 / ( (1 + WACC)^tech_wind[i,life])))
end



return (set_thermalgenerators_options_numbertechnologies,set_wind_options_numbertechnologies,set_thermalgenerators_options,set_wind_options,set_thermalgenerators_existingunits,set_winds_existingunits,set_thermalgenerators,set_winds,set_demands,set_nodes,set_nodes_ref,set_nodes_noref,set_scenarios,set_times,P,V,thermal_ownership_options,wind_ownership_options,x_w_p,x_e_p,Leader, p_D,D,max_demand,Υ_SR,γ,Τ,p_lambda_upper,wind,Ns_H,n_link,links,links_rev,F_max_dict,B_dict,MapG,MapD,MapW,tech_thermal,tech_wind,capacity_per_unit,var_om,invcost,maxBuilds,ownership,capacity_existingunits,fixedcost,EmissionsRate,HeatRate,fuelprice,life,RamUP,Technology,WACC,varcost_thermal,varcost_wind,CRF_thermal,CRF_wind)
end
