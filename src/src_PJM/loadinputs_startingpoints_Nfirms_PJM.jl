function loadinputs_startingpoints_Nfirms_PJM(Number_Total_Firms,x_w_value,x_e_value,start_point,scenario_tax,scenario_ownership,Trans_Cap,folder::String)
 
Number_Total_Firms == 11

    #Congestion
    #Trans_Cap=CSV.File(folder *"/congestion_parameter.csv") |> Tables.matrix
    #sce=CSV.File(folder *"/scenario.csv") |> Tables.matrix
    #Trans_Cap=100000
    #sce=5
    #Sets
 
    set_thermalgenerators_options=67:116
    set_wind_options=34:53
    set_thermalgenerators_existingunits=1:66
    set_winds_existingunits=1:33
    #Investemnt Options
    #Existing Units
    set_thermalgenerators = 1:116
    set_winds = 1:53   

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

    nodes_th=1
    nodes_rn=1
    #Penalty
    P=100000
    V=1000000

    thermal_ownership_options=[0  0	 0	 0	 0	 0	 0 	0	 0 	0 	0 	0 	0 	0 	0 	0 	0 	0 	0 	0 	0 	0 	0 	0 	0 	0 	0 	0 	0 	0 	0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 0 	 1 	 1 	 1 	 1 	 1 	 2 	 2 	 2 	 2 	 2 	 3 	 3 	 3 	 3 	 3 	 4 	 4 	4 	 4 	 4	 5 	 5 	 5 	 5 	 5 	 6 	 6 	 6 	 6 	 6 	 7 	 7 	 7 	 7 	 7 	 8 	 8 	 8 	 8 	 8 	 9 	 9 	 9 	 9 	 9 	 10 	10	 10	 10	 10]

    wind_ownership_options=[0	  0	  0	  0	  0	  0	  0	  0	  0  	0	  0	  0 	 0	 0	 0  	0	  0	 0 	 0	 0	 0 	 0	 0	 0 	0	  0	  0 	 0	  0	  0  	0	   0  	0  	1	  1	 2	 2 	3	  3	 4 	4	  5	 5 	6	  6 	7  	7	  8  	8  	9	  9 	10 	 10]

    max_demand=1
    R=0.15

    x_w_p=zeros(length(set_winds))
    
        #We start the diagonalization algorithm with firm 1. So we need to solve the CP and then fixed the values for the units not own by firm 1														
    global Leader=1														
														
	#Starting points for 10 firms. I need the starting points for 9 firms. 10 strategic firms and 1 competitive fringe. So in total, 11 firms.													
    share_starting_points= CSV.File(folder *"/starting_points_10firms.csv") |> Tables.matrix														
														
    global j=1														
    global k=1														
    global l=1														
    global m=1														
    global n=1														
    global o=1														
    global p=1														
    global q=1														
    global r=1														
														
    for w in set_wind_options														
														
    if wind_ownership_options[w]==2														
    x_w_p[w]=x_w_value[j]*(share_starting_points[start_point,1])														
    global j=j+1														
    end														
														
    if wind_ownership_options[w]==3														
    x_w_p[w]=x_w_value[k]*(share_starting_points[start_point,3])														
    global k=k+1														
    end														
														
    if wind_ownership_options[w]==4														
    x_w_p[w]=x_w_value[l]*(share_starting_points[start_point,5])														
    global l=l+1														
    end														
														
    if wind_ownership_options[w]==5														
    x_w_p[w]=x_w_value[m]*(share_starting_points[start_point,7])														
    global m=m+1														
    end														
														
    if wind_ownership_options[w]==6														
    x_w_p[w]=x_w_value[n]*(share_starting_points[start_point,9])														
    global n=n+1														
    end														
														
    if wind_ownership_options[w]==7														
    x_w_p[w]=x_w_value[o]*(share_starting_points[start_point,11])														
    global o=o+1														
    end														
														
    if wind_ownership_options[w]==8														
    x_w_p[w]=x_w_value[p]*(share_starting_points[start_point,13])														
    global p=p+1														
    end														
														
    if wind_ownership_options[w]==9														
    x_w_p[w]=x_w_value[q]*(share_starting_points[start_point,15])														
    global q=q+1														
    end														
														
    if wind_ownership_options[w]==10														
    x_w_p[w]=x_w_value[r]*(share_starting_points[start_point,17])														
    global r=r+1														
    end														
														
    end														
														
														
    global j=1														
    global k=1														
    global l=1														
    global m=1														
    global n=1														
    global o=1														
    global p=1														
    global q=1														
    global r=1														
														
														
    x_e_p=zeros(length(set_thermalgenerators))														
														
    for e in set_thermalgenerators_options														
														
    if thermal_ownership_options[e]==2														
    x_e_p[e]=x_e_value[j]*(share_starting_points[start_point,2])														
    global j=j+1														
    end														
														
    if thermal_ownership_options[e]==3														
    x_e_p[e]=x_e_value[k]*(share_starting_points[start_point,4])														
    global k=k+1														
    end														
														
    if thermal_ownership_options[e]==4														
    x_e_p[e]=x_e_value[l]*(share_starting_points[start_point,6])														
    global l=l+1														
    end														
														
    if thermal_ownership_options[e]==5														
    x_e_p[e]=x_e_value[m]*(share_starting_points[start_point,8])														
    global m=m+1														
    end														
														
    if thermal_ownership_options[e]==6														
    x_e_p[e]=x_e_value[n]*(share_starting_points[start_point,10])														
    global n=n+1														
    end														
														
    if thermal_ownership_options[e]==7														
    x_e_p[e]=x_e_value[o]*(share_starting_points[start_point,12])														
    global o=o+1														
    end														
														
    if thermal_ownership_options[e]==8														
    x_e_p[e]=x_e_value[p]*(share_starting_points[start_point,14])														
    global p=p+1														
    end														
														
    if thermal_ownership_options[e]==9														
    x_e_p[e]=x_e_value[q]*(share_starting_points[start_point,16])														
    global q=q+1														
    end														
														
    if thermal_ownership_options[e]==10														
    x_e_p[e]=x_e_value[r]*(share_starting_points[start_point,18])														
    global r=r+1														
    end														
														
    end														

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
    
        p_lambda_upper_par=CSV.File(folder *"/upper_bound_price.csv") |> Tables.matrix
    
    
        p_Carbprice_par=CSV.File(folder *"/carbontax_scenarios.csv") |> Tables.matrix
    
        Τ=[p_Carbprice_par[scenario_tax]]
        p_lambda_upper=[p_lambda_upper_par[scenario_tax]]
    
        wind_rowdata= CSV.File(folder *"/wind_10firms_PJM.csv") |> Tables.matrix
        wind=wind_rowdata'

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
    
        MapG=[(1,1),	(2,1),	(3,1),	(4,1),	(5,1),	(6,1),	(7,1),	(8,1),	(9,1),	(10,1),	(11,1),	(12,1),	(13,1),	(14,1),	(15,1),	(16,1),	(17,1),	(18,1),	(19,1),	(20,1),	(21,1),	(22,1),	(23,1),	(24,1),	(25,1),	(26,1),	(27,1),	(28,1),	(29,1),	(30,1),	(31,1),	(32,1),	(33,1),	(34,1),	(35,1),	(36,1),	(37,1),	(38,1),	(39,1),	(40,1),	(41,1),	(42,1),	(43,1),	(44,1),	(45,1),	(46,1),	(47,1),	(48,1),	(49,1),	(50,1),	(51,1),	(52,1),	(53,1),	(54,1),	(55,1),	(56,1),	(57,1),	(58,1),	(59,1),	(60,1),	(61,1),	(62,1),	(63,1),	(64,1),	(65,1),	(66,1),	(67,1),	(68,1),	(69,1),	(70,1),	(71,1),	(72,1),	(73,1),	(74,1),	(75,1),	(76,1),	(77,1),	(78,1),	(79,1),	(80,1),	(81,1),	(82,1),	(83,1),	(84,1),	(85,1),	(86,1),	(87,1),	(88,1),	(89,1),	(90,1),	(91,1),	(92,1),	(93,1),	(94,1),	(95,1),	(96,1),	(97,1),	(98,1),	(99,1),	(100,1),	(101,1),	(102,1),	(103,1),	(104,1),	(105,1),	(106,1),	(107,1),	(108,1),	(109,1),	(110,1),	(111,1),	(112,1),	(113,1),	(114,1),	(115,1),	(116,1)]

        #Define this according to zones
        MapD=[(1,1)]

        MapW=[(1,1),	(2,1),	(3,1),	(4,1),	(5,1),	(6,1),	(7,1),	(8,1),	(9,1),	(10,1),	(11,1),	(12,1),	(13,1),	(14,1),	(15,1),	(16,1),	(17,1),	(18,1),	(19,1),	(20,1),	(21,1),	(22,1),	(23,1),	(24,1),	(25,1),	(26,1),	(27,1),	(28,1),	(29,1),	(30,1),	(31,1),	(32,1),	(33,1),	(34,1),	(35,1),	(36,1),	(37,1),	(38,1),	(39,1),	(40,1),	(41,1),	(42,1),	(43,1),	(44,1),	(45,1),	(46,1),	(47,1),	(48,1),	(49,1),	(50,1),	(51,1),	(52,1),	(53,1)]

#=       
tech_thermal=[600		4.4		0	      	10000000		1		  4497		39695		0.0955		10.78		2.1		  75		90		6
              500		2.2		0	      	10000000		1	  	6798		12863		0.0531		7.93		3.3		  55		425		4
              100		4.5		0	      	10000000		1	  	1270		11395		0.0531		13.92		3.6		  55		600		3
              350		2.5		0	      	10000000		1	  	4319		20767		0.0531		12.01		2.64		55		425		7
              1500  2.3		0	      	10000000		1	  	11277		118988		0		    10.46		0.66		60		0		  8
              350		4.5		0	      	10000000		1	  	270		  11659		0.0741		17.05		3.18		55		600		9
              600		4.4		0	      	10000000		2	  	2888		39695		0.0955		10.78		2.1		  75		90		6
              500		2.2		0	      	10000000		2  		8430		12863		0.0531		7.93		3.3		  55		425		4
              100		4.5		0	      	10000000		2	  	1575		11395		0.0531		13.92		3.6		  55		600		3
              350		2.5		0	      	10000000		2  		5356		20767		0.0531		12.01		2.64		55		425		7
              1500	2.3		0	      	10000000		2  		3655		118988		0		    10.46		0.66		60		0		  8
              350		4.5		0	      	10000000		2  		1316		11659		0.0741		17.05		3.18		55		600		9
              600		4.4		0	      	10000000		3	  	3779		39695		0.0955		10.78		2.1		  75		90		6
              500		2.2		0	      	10000000		3	  	3680		12863		0.0531		7.93		3.3		  55		425		4
              100		4.5		0	      	10000000		3	  	687		  11395		0.0531		13.92		3.6		  55		600		3
              350		2.5		0	      	10000000		3	  	2338		20767		0.0531		12.01		2.64		55		425		7
              1500	2.3		0	      	10000000		3	  	2532		118988		0		    10.46		0.66		60		0		  8
              350		4.5		0	      	10000000		3	  	2153		11659		0.0741		17.05		3.18		55		600		9
              600		4.4		0	      	10000000		4	  	0		    39695		0.0955		10.78		2.1		  75		90		6
              500		2.2		0	      	10000000		4	  	4048		12863		0.0531		7.93		3.3		  55		425		4
              100		4.5		0	      	10000000		4	  	756		  11395		0.0531		13.92		3.6		  55		600		3
              350		2.5		0	      	10000000		4	  	2572		20767		0.0531		12.01		2.64		55		425		7
              1500	2.3		0	      	10000000		4	  	5153		118988		0		    10.46		0.66		60		0		  8
              350		4.5		0	      	10000000		4	  	1059		11659		0.0741		17.05		3.18		55		600		9
              600		4.4		0	      	10000000		5	  	21		  39695		0.0955		10.78		2.1		  75		90		6
              500		2.2		0	      	10000000		5	  	692		  12863		0.0531		7.93		3.3		  55		425		4
              100		4.5		0	      	10000000		5	  	129		  11395		0.0531		13.92		3.6		  55		600		3
              350		2.5		0	      	10000000		5	  	440		  20767		0.0531		12.01		2.64		55		425		7
              1500	2.3		0	      	10000000		5	  	0		    118988		0		    10.46		0.66		60		0		  8
              350		4.5		0	      	10000000		5	  	27		  11659		0.0741		17.05		3.18		55		600		9
              600		4.4		0	      	10000000		6	  	0		    39695		0.0955		10.78		2.1		  75		90		6
              500		2.2		0	      	10000000		6	  	3426		12863		0.0531		7.93		3.3		  55		425		4
              100		4.5		0	      	10000000		6	  	640		  11395		0.0531		13.92		3.6		  55		600		3
              350		2.5		0	      	10000000		6	  	2176		20767		0.0531		12.01		2.64		55		425		7
              1500	2.3		0	      	10000000		6	  	3673		118988		0		    10.46		0.66		60		0		  8
              350		4.5		0	      	10000000		6	  	22	  	11659		0.0741		17.05		3.18		55		600		9
              600		4.4		0	      	10000000		7	  	5432		39695		0.0955		10.78		2.1		  75		90		6
              500		2.2		0	      	10000000		7	  	2218		12863		0.0531		7.93		3.3		  55		425		4
              100		4.5		0	      	10000000		7	  	414	  	11395		0.0531		13.92		3.6		  55		600		3
              350		2.5		0	      	10000000		7	  	1409		20767		0.0531		12.01		2.64		55		425		7
              1500	2.3		0	      	10000000		7	  	0    		118988		0		    10.46		0.66		60		0		  8
              350		4.5		0	      	10000000		7	  	0    		11659		0.0741		17.05		3.18		55		600		9
              600		4.4		0	      	10000000		8	  	4702		39695		0.0955		10.78		2.1		  75		90		6
              500		2.2		0	      	10000000		8	  	1837		12863		0.0531		7.93		3.3		  55		425		4
              100		4.5		0	      	10000000		8	  	343		  11395		0.0531		13.92		3.6		  55		600		3
              350		2.5		0	      	10000000		8	  	1167		20767		0.0531		12.01		2.64		55		425		7
              1500	2.3		0	      	10000000		8	  	0    		118988		0		    10.46		0.66		60		0		  8
              350		4.5		0	      	10000000		8	  	0    		11659		0.0741		17.05		3.18		55		600		9
              600		4.4		0	      	10000000		9	  	2600		39695		0.0955		10.78		2.1		  75		90		6
              500		2.2		0	      	10000000		9	  	1267		12863		0.0531		7.93		3.3		  55		425		4
              100		4.5		0	      	10000000		9	  	237		   11395	0.0531		13.92		3.6		  55		600		3
              350		2.5		0	      	10000000		9		  805    	20767		0.0531		12.01		2.64		55		425		7
              1500	2.3		0	      	10000000		9		  2285		118988		0		    10.46		0.66		60		0		  8
              350		4.5		0	      	10000000		9		  0	    	11659		0.0741		17.05		3.18		55		600		9
              600		4.4		0	      	10000000		10		4901    39695		0.0955		10.78		2.1		  75		90		6
              500		2.2		0	      	10000000		10		1346    12863		0.0531		7.93		3.3		  55		425		4
              100		4.5		0	      	10000000		10		251    	11395		0.0531		13.92		3.6		  55		600		3
              350		2.5		0	      	10000000		10		855	    20767		0.0531		12.01		2.64		55		425		7
              1500	2.3		0	      	10000000		10		0	    	118988		0		    10.46		0.66		60		0		  8
              350		4.5		0	      	10000000		10		0	    	11659		0.0741		17.05		3.18		55		600		9
              600		4.4		0	      	10000000		11		24464		39695		0.0955		10.78		2.1		  75		90		6
              500		2.2		0	      	10000000		11		20154		12863		0.0531		7.93		3.3		  55		425		4
              100		4.5		0		      10000000		11		3765		11395		0.0531		13.92		3.6		  55		600		3
              350		2.5		0		      10000000		11		12805		20767		0.0531		12.01		2.64		55		425		7
              1500	2.3		0		      10000000		11		5934		118988		0		    10.46		0.66		60		0		  8
              350		4.5		0		      10000000		11		3107		11659		0.0741		17.05		3.18		55		600		9
              600		6.9		5299096		10000000		1	  	0		    53114		0.0096		9.751		2.01		75		90		1
              600		10.7	6830748		10000000		1	  	0		    58242		0.0096		12.507	2.01		75		90		2
              100		4.5		982962		10000000		1	  	0		    11395		0.0531		9.5145	2.81		55		600		3
              500		2.2		1088328		10000000		1	  	0	    	12863		0.0531		6.4005	2.81		55		425		4
              500		5.7		2778138		10000000		1	  	0	    	26994		0.0053		7.525		2.81		55		425		5
              600		6.9		5299096		10000000		2	  	0	    	53114		0.0096		9.751		2.01		75		90		1
              600		10.7	6830748		10000000		2	  	0	    	58242		0.0096		12.507	2.01		75		90		2
              100		4.5		982962		10000000		2	  	0	    	11395		0.0531		9.5145	2.81		55		600		3
              500		2.2		1088328		10000000		2	  	0	    	12863		0.0531		6.4005	2.81		55		425		4
              500		5.7		2778138		10000000		2	  	0	    	26994		0.0053		7.525		2.81		55		425		5
              600		6.9		5299096		10000000		3	  	0	    	53114		0.0096		9.751		2.01		75		90		1
              600		10.7	6830748		10000000		3	  	0	    	58242		0.0096		12.507	2.01		75		90		2
              100		4.5		982962		10000000		3	  	0	    	11395		0.0531		9.5145	2.81		55		600		3
              500		2.2		1088328		10000000		3	  	0	    	12863		0.0531		6.4005	2.81		55		425		4
              500		5.7		2778138		10000000		3	  	0	    	26994		0.0053		7.525		2.81		55		425		5
              600		6.9		5299096		10000000		4	  	0	    	53114		0.0096		9.751		2.01		75		90		1
              600		10.7	6830748		10000000		4	  	0	    	58242		0.0096		12.507	2.01		75		90		2
              100		4.5		982962		10000000		4	  	0	    	11395		0.0531		9.5145	2.81		55		600		3
              500		2.2		1088328		10000000		4	  	0	    	12863		0.0531		6.4005	2.81		55		425		4
              500		5.7		2778138		10000000		4	  	0	    	26994		0.0053		7.525		2.81		55		425		5
              600		6.9		5299096		10000000		5	  	0	    	53114		0.0096		9.751		2.01		75		90		1
              600		10.7	6830748		10000000		5	  	0	    	58242		0.0096		12.507	2.01		75		90		2
              100		4.5		982962		10000000		5	  	0	    	11395		0.0531		9.5145	2.81		55		600		3
              500		2.2		1088328		10000000		5	  	0	    	12863		0.0531		6.4005	2.81		55		425		4
              500		5.7		2778138		10000000		5	  	0	    	26994		0.0053		7.525		2.81		55		425		5
              600		6.9		5299096		10000000		6	  	0	    	53114		0.0096		9.751		2.01		75		90		1
              600		10.7	6830748		10000000		6	  	0	    	58242		0.0096		12.507	2.01		75		90		2
              100		4.5		982962		10000000		6	  	0	    	11395		0.0531		9.5145	2.81		55		600		3
              500		2.2		1088328		10000000		6	  	0	    	12863		0.0531		6.4005	2.81		55		425		4
              500		5.7		2778138		10000000		6	  	0	    	26994		0.0053		7.525		2.81		55		425		5
              600		6.9		5299096		10000000		7	  	0	    	53114		0.0096		9.751		2.01		75		90		1
              600		10.7	6830748		10000000		7	  	0	    	58242		0.0096		12.507	2.01		75		90		2
              100		4.5		982962		10000000		7	  	0	    	11395		0.0531		9.5145	2.81		55		600		3
              500		2.2		1088328		10000000		7	  	0	    	12863		0.0531		6.4005	2.81		55		425		4
              500		5.7		2778138		10000000		7		  0	    	26994		0.0053		7.525		2.81		55		425		5
              600		6.9		5299096		10000000		8		  0	    	53114		0.0096		9.751		2.01		75		90		1
              600		10.7	6830748		10000000		8		  0	    	58242		0.0096		12.507	2.01		75		90		2
              100		4.5		982962		10000000		8		  0	    	11395		0.0531		9.5145	2.81		55		600		3
              500		2.2		1088328		10000000		8		  0	    	12863		0.0531		6.4005	2.81		55		425		4
              500		5.7		2778138		10000000		8		  0	    	26994		0.0053		7.525		2.81		55		425		5
              600		6.9		5299096		10000000		9		  0	    	53114		0.0096		9.751		2.01		75		90		1
              600		10.7	6830748		10000000		9		  0	    	58242		0.0096		12.507	2.01		75		90		2
              100		4.5		982962		10000000		9		  0	    	11395		0.0531		9.5145	2.81		55		600		3
              500		2.2		1088328		10000000		9		  0	    	12863		0.0531		6.4005	2.81		55		425		4
              500		5.7		2778138		10000000		9		  0	    	26994		0.0053		7.525		2.81		55		425		5
              600		6.9		5299096		10000000		10		0	    	53114		0.0096		9.751		2.01		75		90		1
              600		10.7	6830748		10000000		10		0	    	58242		0.0096		12.507	2.01		75		90		2
              100		4.5		982962		10000000		10		0	    	11395		0.0531		9.5145	2.81		55		600		3
              500		2.2		1088328		10000000		10		0	    	12863		0.0531		6.4005	2.81		55		425		4
              500		5.7		2778138		10000000		10		0	    	26994		0.0053		7.525		2.81		55		425		5]
=#

#Retirements Scenario
#Retirement Parameter
    #Retirements scenario PJM Capacity 
    #Order=Coal, CC, CT, ST, Nuclear, Oil
    #Ret Scenario3
    #Retirement Parameter
     #CC
     R_c=0
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

tech_thermal=[600		4.4		0	      	10000000		1		  4497*R_t		39695		0.0955		10.78		2.1		  75		90		6
              500		2.2		0	      	10000000		1	  	6798*R_c		12863		0.0531		7.93		3.3		  55		425		4
              100		4.5		0	      	10000000		1	  	1270		    11395		0.0531		13.92		3.6		  55		600		3
              350		2.5		0	      	10000000		1	  	4319*R_t		20767		0.0531		12.01		2.64		55		425		7
              1500  2.3		0	      	10000000		1	  	11277*R_n		118988		0		    10.46		0.66		60		0		  8
              350		4.5		0	      	10000000		1	  	270*R_t		  11659		0.0741		17.05		3.18		55		600		9
              600		4.4		0	      	10000000		2	  	2888*R_t		39695		0.0955		10.78		2.1		  75		90		6
              500		2.2		0	      	10000000		2  		8430*R_c		12863		0.0531		7.93		3.3		  55		425		4
              100		4.5		0	      	10000000		2	  	1575		    11395		0.0531		13.92		3.6		  55		600		3
              350		2.5		0	      	10000000		2  		5356*R_t		20767		0.0531		12.01		2.64		55		425		7
              1500	2.3		0	      	10000000		2  		3655*R_n		118988		0		    10.46		0.66		60		0		  8
              350		4.5		0	      	10000000		2  		1316*R_t		11659		0.0741		17.05		3.18		55		600		9
              600		4.4		0	      	10000000		3	  	3779*R_t		39695		0.0955		10.78		2.1		  75		90		6
              500		2.2		0	      	10000000		3	  	3680*R_c		12863		0.0531		7.93		3.3		  55		425		4
              100		4.5		0	      	10000000		3	  	687		      11395		0.0531		13.92		3.6		  55		600		3
              350		2.5		0	      	10000000		3	  	2338*R_t		20767		0.0531		12.01		2.64		55		425		7
              1500	2.3		0	      	10000000		3	  	2532*R_n		118988		0		    10.46		0.66		60		0		  8
              350		4.5		0	      	10000000		3	  	2153*R_t		11659		0.0741		17.05		3.18		55		600		9
              600		4.4		0	      	10000000		4	  	0*R_t		    39695		0.0955		10.78		2.1		  75		90		6
              500		2.2		0	      	10000000		4	  	4048*R_c		12863		0.0531		7.93		3.3		  55		425		4
              100		4.5		0	      	10000000		4	  	756		      11395		0.0531		13.92		3.6		  55		600		3
              350		2.5		0	      	10000000		4	  	2572*R_t		20767		0.0531		12.01		2.64		55		425		7
              1500	2.3		0	      	10000000		4	  	5153*R_n		118988		0		    10.46		0.66		60		0		  8
              350		4.5		0	      	10000000		4	  	1059*R_t		11659		0.0741		17.05		3.18		55		600		9
              600		4.4		0	      	10000000		5	  	21*R_t		  39695		0.0955		10.78		2.1		  75		90		6
              500		2.2		0	      	10000000		5	  	692*R_c		  12863		0.0531		7.93		3.3		  55		425		4
              100		4.5		0	      	10000000		5	  	129		      11395		0.0531		13.92		3.6		  55		600		3
              350		2.5		0	      	10000000		5	  	440*R_t		  20767		0.0531		12.01		2.64		55		425		7
              1500	2.3		0	      	10000000		5	  	0*R_n		    118988		0		    10.46		0.66		60		0		  8
              350		4.5		0	      	10000000		5	  	27*R_t		  11659		0.0741		17.05		3.18		55		600		9
              600		4.4		0	      	10000000		6	  	0*R_t		    39695		0.0955		10.78		2.1		  75		90		6
              500		2.2		0	      	10000000		6	  	3426*R_c		12863		0.0531		7.93		3.3		  55		425		4
              100		4.5		0	      	10000000		6	  	640		      11395		0.0531		13.92		3.6		  55		600		3
              350		2.5		0	      	10000000		6	  	2176*R_t		20767		0.0531		12.01		2.64		55		425		7
              1500	2.3		0	      	10000000		6	  	3673*R_n		118988		0		    10.46		0.66		60		0		  8
              350		4.5		0	      	10000000		6	  	22*R_t	  	11659		0.0741		17.05		3.18		55		600		9
              600		4.4		0	      	10000000		7	  	5432*R_t		39695		0.0955		10.78		2.1		  75		90		6
              500		2.2		0	      	10000000		7	  	2218*R_c		12863		0.0531		7.93		3.3		  55		425		4
              100		4.5		0	      	10000000		7	  	414	  	    11395		0.0531		13.92		3.6		  55		600		3
              350		2.5		0	      	10000000		7	  	1409*R_t		20767		0.0531		12.01		2.64		55		425		7
              1500	2.3		0	      	10000000		7	  	0*R_n    		118988		0		    10.46		0.66		60		0		  8
              350		4.5		0	      	10000000		7	  	0*R_t    		11659		0.0741		17.05		3.18		55		600		9
              600		4.4		0	      	10000000		8	  	4702*R_t		39695		0.0955		10.78		2.1		  75		90		6
              500		2.2		0	      	10000000		8	  	1837*R_c		12863		0.0531		7.93		3.3		  55		425		4
              100		4.5		0	      	10000000		8	  	343		      11395		0.0531		13.92		3.6		  55		600		3
              350		2.5		0	      	10000000		8	  	1167*R_t		20767		0.0531		12.01		2.64		55		425		7
              1500	2.3		0	      	10000000		8	  	0*R_n    		118988		0		    10.46		0.66		60		0		  8
              350		4.5		0	      	10000000		8	  	0*R_t    		11659		0.0741		17.05		3.18		55		600		9
              600		4.4		0	      	10000000		9	  	2600*R_t		39695		0.0955		10.78		2.1		  75		90		6
              500		2.2		0	      	10000000		9	  	1267*R_c		12863		0.0531		7.93		3.3		  55		425		4
              100		4.5		0	      	10000000		9	  	237		      11395	  0.0531		13.92		3.6		  55		600		3
              350		2.5		0	      	10000000		9		  805*R_t    	20767		0.0531		12.01		2.64		55		425		7
              1500	2.3		0	      	10000000		9		  2285*R_n		118988		0		    10.46		0.66		60		0		  8
              350		4.5		0	      	10000000		9		  0*R_t	    	11659		0.0741		17.05		3.18		55		600		9
              600		4.4		0	      	10000000		10		4901*R_t    39695		0.0955		10.78		2.1		  75		90		6
              500		2.2		0	      	10000000		10		1346*R_c    12863		0.0531		7.93		3.3		  55		425		4
              100		4.5		0	      	10000000		10		251    	    11395		0.0531		13.92		3.6		  55		600		3
              350		2.5		0	      	10000000		10		855*R_t	    20767		0.0531		12.01		2.64		55		425		7
              1500	2.3		0	      	10000000		10		0*R_n	    	118988		0		    10.46		0.66		60		0		  8
              350		4.5		0	      	10000000		10		0*R_t	    	11659		0.0741		17.05		3.18		55		600		9
              600		4.4		0	      	10000000		11		24464*R_t		39695		0.0955		10.78		2.1		  75		90		6
              500		2.2		0	      	10000000		11		20154*R_c		12863		0.0531		7.93		3.3		  55		425		4
              100		4.5		0		      10000000		11		3765		    11395		0.0531		13.92		3.6		  55		600		3
              350		2.5		0		      10000000		11		12805*R_t		20767		0.0531		12.01		2.64		55		425		7
              1500	2.3		0		      10000000		11		5934*R_n		118988		0		    10.46		0.66		60		0		  8
              350		4.5		0		      10000000		11		3107*R_t		11659		0.0741		17.05		3.18		55		600		9
              600		6.9		5299096		10000000		1	  	0		        53114		0.0096		9.751		2.01		75		90		1
              600		10.7	6830748		10000000		1	  	0		        58242		0.0096		12.507	2.01		75		90		2
              100		4.5		982962		10000000		1	  	0		        11395		0.0531		9.5145	2.81		55		600		3
              500		2.2		1088328		10000000		1	  	0	    	    12863		0.0531		6.4005	2.81		55		425		4
              500		5.7		2778138		10000000		1	  	0	    	    26994		0.0053		7.525		2.81		55		425		5
              600		6.9		5299096		10000000		2	  	0	    	    53114		0.0096		9.751		2.01		75		90		1
              600		10.7	6830748		10000000		2	  	0	    	    58242		0.0096		12.507	2.01		75		90		2
              100		4.5		982962		10000000		2	  	0	    	    11395		0.0531		9.5145	2.81		55		600		3
              500		2.2		1088328		10000000		2	  	0	    	    12863		0.0531		6.4005	2.81		55		425		4
              500		5.7		2778138		10000000		2	  	0	    	    26994		0.0053		7.525		2.81		55		425		5
              600		6.9		5299096		10000000		3	  	0	    	    53114		0.0096		9.751		2.01		75		90		1
              600		10.7	6830748		10000000		3	  	0	    	    58242		0.0096		12.507	2.01		75		90		2
              100		4.5		982962		10000000		3	  	0	    	    11395		0.0531		9.5145	2.81		55		600		3
              500		2.2		1088328		10000000		3	  	0	    	    12863		0.0531		6.4005	2.81		55		425		4
              500		5.7		2778138		10000000		3	  	0	    	    26994		0.0053		7.525		2.81		55		425		5
              600		6.9		5299096		10000000		4	  	0	    	    53114		0.0096		9.751		2.01		75		90		1
              600		10.7	6830748		10000000		4	  	0	    	    58242		0.0096		12.507	2.01		75		90		2
              100		4.5		982962		10000000		4	  	0	    	    11395		0.0531		9.5145	2.81		55		600		3
              500		2.2		1088328		10000000		4	  	0	    	    12863		0.0531		6.4005	2.81		55		425		4
              500		5.7		2778138		10000000		4	  	0	    	    26994		0.0053		7.525		2.81		55		425		5
              600		6.9		5299096		10000000		5	  	0	    	    53114		0.0096		9.751		2.01		75		90		1
              600		10.7	6830748		10000000		5	  	0	    	    58242		0.0096		12.507	2.01		75		90		2
              100		4.5		982962		10000000		5	  	0	    	    11395		0.0531		9.5145	2.81		55		600		3
              500		2.2		1088328		10000000		5	  	0	    	    12863		0.0531		6.4005	2.81		55		425		4
              500		5.7		2778138		10000000		5	  	0	    	    26994		0.0053		7.525		2.81		55		425		5
              600		6.9		5299096		10000000		6	  	0	    	    53114		0.0096		9.751		2.01		75		90		1
              600		10.7	6830748		10000000		6	  	0	    	    58242		0.0096		12.507	2.01		75		90		2
              100		4.5		982962		10000000		6	  	0	    	    11395		0.0531		9.5145	2.81		55		600		3
              500		2.2		1088328		10000000		6	  	0	    	    12863		0.0531		6.4005	2.81		55		425		4
              500		5.7		2778138		10000000		6	  	0	    	    26994		0.0053		7.525		2.81		55		425		5
              600		6.9		5299096		10000000		7	  	0	    	    53114		0.0096		9.751		2.01		75		90		1
              600		10.7	6830748		10000000		7	  	0	    	    58242		0.0096		12.507	2.01		75		90		2
              100		4.5		982962		10000000		7	  	0	    	    11395		0.0531		9.5145	2.81		55		600		3
              500		2.2		1088328		10000000		7	  	0	    	    12863		0.0531		6.4005	2.81		55		425		4
              500		5.7		2778138		10000000		7		  0	    	    26994		0.0053		7.525		2.81		55		425		5
              600		6.9		5299096		10000000		8		  0	    	    53114		0.0096		9.751		2.01		75		90		1
              600		10.7	6830748		10000000		8		  0	    	    58242		0.0096		12.507	2.01		75		90		2
              100		4.5		982962		10000000		8		  0	    	    11395		0.0531		9.5145	2.81		55		600		3
              500		2.2		1088328		10000000		8		  0	    	    12863		0.0531		6.4005	2.81		55		425		4
              500		5.7		2778138		10000000		8		  0	    	    26994		0.0053		7.525		2.81		55		425		5
              600		6.9		5299096		10000000		9		  0	    	    53114		0.0096		9.751		2.01		75		90		1
              600		10.7	6830748		10000000		9		  0	    	    58242		0.0096		12.507	2.01		75		90		2
              100		4.5		982962		10000000		9		  0	    	    11395		0.0531		9.5145	2.81		55		600		3
              500		2.2		1088328		10000000		9		  0	    	    12863		0.0531		6.4005	2.81		55		425		4
              500		5.7		2778138		10000000		9		  0	    	    26994		0.0053		7.525		2.81		55		425		5
              600		6.9		5299096		10000000		10		0	    	    53114		0.0096		9.751		2.01		75		90		1
              600		10.7	6830748		10000000		10		0	    	    58242		0.0096		12.507	2.01		75		90		2
              100		4.5		982962		10000000		10		0	    	    11395		0.0531		9.5145	2.81		55		600		3
              500		2.2		1088328		10000000		10		0	    	    12863		0.0531		6.4005	2.81		55		425		4
              500		5.7		2778138		10000000		10		0	    	    26994		0.0053		7.525		2.81		55		425		5]
                        

              Coal=[1	,7,	13,	19,	25	,31,	37,	43	,49	,55,	61] 
              CC=[2	,8	,14,	20,	26	,32	,38	,44	,50,	56,	62] 
              CT=[3	,9	,15	,21	,27	,33	,39	,45,	51	,57,	63]  
              ST=[4	,10,	16,	22	,28,	34,	40,	46	,52	,58	,64]  
              Oil=[6	,12	,18	,24	,30,	36,	42,	48,	54,	60,	66]
            
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


              

tech_wind=[ 300		0		1604886		10000000		1	  	4741		43205		0		0		0		30		0		1
            300		0		1599902		10000000		1	  	127			18760		0		0		0		30		0		2
            300		0		1599902		10000000		1	  	20			11944		0		0		0		30		0		3
            300		0		1604886		10000000		2	  	379			43205		0		0		0		30		0		1
            300		0		1599902		10000000		2	  	3557		18760		0		0		0		30		0		2
            300		0		1599902		10000000		2	  	3455		11944		0		0		0		30		0		3
            300		0		1604886		10000000		3	  	220			43205		0		0		0		30		0		1
            300		0		1599902		10000000		3	  	43			18760		0		0		0		30		0		2
            300		0		1599902		10000000		3	  	705			11944		0		0		0		30		0		3
            300		0		1604886		10000000		4	  	0				43205		0		0		0		30		0		1
            300		0		1599902		10000000		4	  	24			18760		0		0		0		30		0		2
            300		0		1599902		10000000		4	  	1603		11944		0		0		0		30		0		3
            300		0		1604886		10000000		5	  	5				43205		0		0		0		30		0		1
            300		0		1599902		10000000		5	  	5				18760		0		0		0		30		0		2
            300		0		1599902		10000000		5	  	0				11944		0		0		0		30		0		3
            300		0		1604886		10000000		6	  	2				43205		0		0		0		30		0		1
            300		0		1599902		10000000		6	  	417			18760		0		0		0		30		0		2
            300		0		1599902		10000000		6	  	15			11944		0		0		0		30		0		3
            300		0		1604886		10000000		7	  	50			43205		0		0		0		30		0		1
            300		0		1599902		10000000		7	  	60			18760		0		0		0		30		0		2
            300		0		1599902		10000000		7	  	84			11944		0		0		0		30		0		3
            300		0		1604886		10000000		8	  	1004		43205		0		0		0		30		0		1
            300		0		1599902		10000000		8	  	14			18760		0		0		0		30		0		2
            300		0		1599902		10000000		8	  	540			11944		0		0		0		30		0		3
            300		0		1604886		10000000		9	  	2094		43205		0		0		0		30		0		1
            300		0		1599902		10000000		9	  	235			18760		0		0		0		30		0		2
            300		0		1599902		10000000		9	  	24			11944		0		0		0		30		0		3
            300		0		1604886		10000000		10		0				43205		0		0		0		30		0		1
            300		0		1599902		10000000		10		112			18760		0		0		0		30		0		2
            300		0		1599902		10000000		10		969			11944		0		0		0		30		0		3
            300		0		1604886		10000000		11		2209		43205		0		0		0		30		0		1
            300		0		1599902		10000000		11		1870		18760		0		0		0		30		0		2
            300		0		1599902		10000000		11		966			11944		0		0		0		30		0		3
            300		0		1604886		10000000		1	  	0				43205		0		0		0		30		0		1
            300		0		1599902		10000000		1	  	0				18760		0		0		0		30		0		2
            300		0		1604886		10000000		2	  	0				43205		0		0		0		30		0		1
            300		0		1599902		10000000		2	  	0				18760		0		0		0		30		0		2
            300		0		1604886		10000000		3	  	0				43205		0		0		0		30		0		1
            300		0		1599902		10000000		3	  	0				18760		0		0		0		30		0		2
            300		0		1604886		10000000		4	  	0				43205		0		0		0		30		0		1
            300		0		1599902		10000000		4	  	0				18760		0		0		0		30		0		2
            300		0		1604886		10000000		5	  	0				43205		0		0		0		30		0		1
            300		0		1599902		10000000		5	  	0				18760		0		0		0		30		0		2
            300		0		1604886		10000000		6	  	0				43205		0		0		0		30		0		1
            300		0		1599902		10000000		6	  	0				18760		0		0		0		30		0		2
            300		0		1604886		10000000		7	  	0				43205		0		0		0		30		0		1
            300		0		1599902		10000000		7	  	0				18760		0		0		0		30		0		2
            300		0		1604886		10000000		8	  	0				43205		0		0		0		30		0		1
            300		0		1599902		10000000		8	  	0				18760		0		0		0		30		0		2
            300		0		1604886		10000000		9		  0				43205		0		0		0		30		0		1
            300		0		1599902		10000000		9		  0				18760		0		0		0		30		0		2
            300		0		1604886		10000000		10		0				43205		0		0		0		30		0		1
            300		0		1599902		10000000		10		0				18760		0		0		0		30		0		2]


    
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
    
return (set_thermalgenerators_options,set_wind_options,set_thermalgenerators_existingunits,set_winds_existingunits,set_thermalgenerators,set_winds,set_demands,set_nodes,set_nodes_ref,set_nodes_noref,set_scenarios,set_times,P,V,thermal_ownership_options,wind_ownership_options,x_w_p,x_e_p,Leader, p_D,D,max_demand,Υ_SR,γ,Τ,p_lambda_upper,wind,Ns_H,n_link,links,links_rev,F_max_dict,B_dict,MapG,MapD,MapW,tech_thermal,tech_wind,capacity_per_unit,var_om,invcost,maxBuilds,ownership,capacity_existingunits,fixedcost,EmissionsRate,HeatRate,fuelprice,life,RamUP,Technology,WACC,varcost_thermal,varcost_wind,CRF_thermal,CRF_wind)
end
