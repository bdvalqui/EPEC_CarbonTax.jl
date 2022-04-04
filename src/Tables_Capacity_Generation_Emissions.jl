function Tables_Capacity_Generation_Emissions(Total_Investments_Technology_CP,Total_Investments_Technology_EPEC,Total_Investments_Technology_Firm1_EPEC,Total_Investments_Technology_Firm2_EPEC,Total_Generation_Technology_CP,Total_Generation_Technology_Existing_CP,Total_Generation_Technology_Candidate_CP,Total_Generation_Technology_EPEC,Total_Generation_Technology_Existing_EPEC,Total_Generation_Technology_Candidate_EPEC,Total_Emissions_Technology_CP,Total_Emissions_Technology_Candidate_CP,Total_Emissions_Technology_Existing_CP,Total_Emissions_Technology_Existing_EPEC,Total_Emissions_Technology_Candidate_EPEC,data_prices_CP,data_prices_EPEC,Total_Revenue_Cost_demandblock_CP,Total_Revenue_Cost_demandblock_EPEC,set_times,Τ,start_point,Cost_Detail,scenario)

Ns_H= CSV.File("data/weights.csv") |> Tables.matrix

name_rows_investments = ["Solar","Wind","Gas-CC-CCS","Gas-CC","Gas-CT"]
name_columns_investments= ["Candidate Technology","Total Investments-CP (MW)","Total Investments-EPEC (MW)"]
#====================================================================================#
y3_CP = Total_Investments_Technology_CP[3] #Gas-CT
y4_CP = Total_Investments_Technology_CP[4] #Gas-CC
y5_CP =  Total_Investments_Technology_CP[5] #Gas-CC-CCS
y6_CP =  Total_Investments_Technology_CP[6] #Wind
y7_CP =  Total_Investments_Technology_CP[7] #Solar


y3_EPEC = Total_Investments_Technology_EPEC[3] #Gas-CT
y4_EPEC = Total_Investments_Technology_EPEC[4] #Gas-CC
y5_EPEC =  Total_Investments_Technology_EPEC[5] #Gas-CC-CCS
y6_EPEC =  Total_Investments_Technology_EPEC[6] #Wind
y7_EPEC =  Total_Investments_Technology_EPEC[7] #Solar

Investments_CP_EPEC=[y7_CP y7_EPEC;y6_CP y6_EPEC;y5_CP y5_EPEC;y4_CP y4_EPEC;y3_CP y3_EPEC]

rows_elements_investments=hcat(name_rows_investments,Investments_CP_EPEC)

df_table_investments=DataFrame(rows_elements_investments, name_columns_investments)


CSV.write("results_startingpoints/$scenario/$start_point/Table_EPEC_CP_totalinvestments$Τ.csv", df_table_investments)

#======================================Group of Technologies============================================================================#
ZC_CP= y6_CP+y7_CP
LC_CP=y5_CP
HC_CP=y3_CP+y4_CP

ZC_EPEC= y6_EPEC+y7_EPEC
LC_EPEC=y5_EPEC
HC_EPEC=y3_EPEC+y4_EPEC

name_rows_investments_group1 = ["ZC-C","ZC-C","LC-C","LC-C","HC-C","HC-C"]
name_rows_investments_group2 = ["CP","EPEC","CP","EPEC","CP","EPEC"]
name_columns_investments_group= ["Group of Technologies","Approach","Total Investments (MW)"]

Investments_CP_EPEC_group=[ZC_CP,ZC_EPEC,LC_CP,LC_EPEC,HC_CP,HC_EPEC]

name_rows_investments_group=hcat(name_rows_investments_group1,name_rows_investments_group2)

rows_elements_investments_group=hcat(name_rows_investments_group,Investments_CP_EPEC_group)

df_table_investments_group=DataFrame(rows_elements_investments_group, name_columns_investments_group)

CSV.write("results_startingpoints/$scenario/$start_point/Table_EPEC_CP_totalinvestments_Group$Τ.csv", df_table_investments_group)

#========================================Generation===============================================================================#
name_rows_generation_1_CP = ["Solar","Solar","Wind","Wind","Nuclear","Nuclear","Gas-CC-CCS","Gas-CC-CCS","Gas-CC","Gas-CC","Gas-CT","Gas-CT","Coal","Coal"]
name_rows_generation_2_CP = ["Existing","New","Existing","New","Existing","New","Existing","New","Existing","New","Existing","New","Existing","New"]
#name_rows_investments = ["Solar","Wind","Nuclear","Gas-CC-CCS","Gas-CC","Gas-CT","Coal"]
name_columns_generation_CP= ["Technologies","Type","1","2","3","4","5","6","7","8"]

#Total_Generation_Technology_CP,Total_Generation_Technology_Existing_CP,Total_Generation_Technology_Candidate_CP
y3_CP = Total_Generation_Technology_CP[3,:] #Gas-CT
y4_CP = Total_Generation_Technology_CP[4,:] #Gas-CC
y5_CP =  Total_Generation_Technology_CP[5,:] #Gas-CC-CCS
y6_CP =  Total_Generation_Technology_CP[6,:] #Nuclear
y7_CP =  Total_Generation_Technology_CP[7,:] #Coal
y8_CP =  Total_Generation_Technology_CP[8,:] #Wind
y9_CP =  Total_Generation_Technology_CP[9,:] #Solar

y3_E_CP = Total_Generation_Technology_Existing_CP[3,:] #Gas-CT
y4_E_CP = Total_Generation_Technology_Existing_CP[4,:] #Gas-CC
y5_E_CP =  Total_Generation_Technology_Existing_CP[5,:] #Gas-CC-CCS
y6_E_CP =  Total_Generation_Technology_Existing_CP[6,:] #Nuclear
y7_E_CP =  Total_Generation_Technology_Existing_CP[7,:] #Coal
y8_E_CP =  Total_Generation_Technology_Existing_CP[8,:] #Wind
y9_E_CP =  Total_Generation_Technology_Existing_CP[9,:] #Solar

#Total_Generation_Technology_Existing_CP_dummy=Total_Generation_Technology_Existing_CP

y3_C_CP = Total_Generation_Technology_Candidate_CP[3,:] #Gas-CT
y4_C_CP = Total_Generation_Technology_Candidate_CP[4,:] #Gas-CC
y5_C_CP =  Total_Generation_Technology_Candidate_CP[5,:] #Gas-CC-CCS
y6_C_CP =  Total_Generation_Technology_Candidate_CP[6,:] #Nuclear
y7_C_CP =  Total_Generation_Technology_Candidate_CP[7,:] #Coal
y8_C_CP =  Total_Generation_Technology_Candidate_CP[8,:] #Wind
y9_C_CP =  Total_Generation_Technology_Candidate_CP[9,:] #Solar

set_dummy1=1:8

Generation_CP=zeros(14,8)

for i in set_dummy1
       Generation_CP[1,i]=y9_E_CP[i]
       Generation_CP[2,i]=y9_C_CP[i]
       Generation_CP[3,i]=y8_E_CP[i]
       Generation_CP[4,i]=y8_C_CP[i]
       Generation_CP[5,i]=y6_E_CP[i]
       Generation_CP[6,i]=y6_C_CP[i]
       Generation_CP[7,i]=y5_E_CP[i]
       Generation_CP[8,i]=y5_C_CP[i]
       Generation_CP[9,i]=y4_E_CP[i]
       Generation_CP[10,i]=y4_C_CP[i]
       Generation_CP[11,i]=y3_E_CP[i]
       Generation_CP[12,i]=y3_C_CP[i]
       Generation_CP[13,i]=y7_E_CP[i]
       Generation_CP[14,i]=y7_C_CP[i]
end

name_rows_generation_CP=hcat(name_rows_generation_1_CP,name_rows_generation_2_CP)

rows_elements_generation_CP=hcat(name_rows_generation_CP,Generation_CP)

df_table_generation_CP=DataFrame(rows_elements_generation_CP,name_columns_generation_CP)

CSV.write("results_startingpoints/$scenario/$start_point/Table_CP_generation$Τ.csv", df_table_generation_CP)

#===============================================EPEC-Existing and Candidates=============================================================#
name_rows_generation_1_EPEC = ["Solar","Solar","Wind","Wind","Nuclear","Nuclear","Gas-CC-CCS","Gas-CC-CCS","Gas-CC","Gas-CC","Gas-CT","Gas-CT","Coal","Coal"]
name_rows_generation_2_EPEC = ["Existing","New","Existing","New","Existing","New","Existing","New","Existing","New","Existing","New","Existing","New"]
#name_rows_investments = ["Solar","Wind","Nuclear","Gas-CC-CCS","Gas-CC","Gas-CT","Coal"]
name_columns_generation_EPEC= ["Technologies","Type","1","2","3","4","5","6","7","8"]


y3_E_EPEC = Total_Generation_Technology_Existing_EPEC[3,:]
y4_E_EPEC = Total_Generation_Technology_Existing_EPEC[4,:]
y5_E_EPEC =  Total_Generation_Technology_Existing_EPEC[5,:]
y6_E_EPEC =  Total_Generation_Technology_Existing_EPEC[6,:]
y7_E_EPEC =  Total_Generation_Technology_Existing_EPEC[7,:]
y8_E_EPEC =  Total_Generation_Technology_Existing_EPEC[8,:]
y9_E_EPEC =  Total_Generation_Technology_Existing_EPEC[9,:]

y3_C_EPEC = Total_Generation_Technology_Candidate_EPEC[3,:]
y4_C_EPEC = Total_Generation_Technology_Candidate_EPEC[4,:]
y5_C_EPEC =  Total_Generation_Technology_Candidate_EPEC[5,:]
y6_C_EPEC =  Total_Generation_Technology_Candidate_EPEC[6,:]
y7_C_EPEC =  Total_Generation_Technology_Candidate_EPEC[7,:]
y8_C_EPEC =  Total_Generation_Technology_Candidate_EPEC[8,:]
y9_C_EPEC =  Total_Generation_Technology_Candidate_EPEC[9,:]

set_dummy1=1:8

Generation_EPEC=zeros(14,8)

for i in set_dummy1
       Generation_EPEC[1,i]=y9_E_EPEC[i]
       Generation_EPEC[2,i]=y9_C_EPEC[i]
       Generation_EPEC[3,i]=y8_E_EPEC[i]
       Generation_EPEC[4,i]=y8_C_EPEC[i]
       Generation_EPEC[5,i]=y6_E_EPEC[i]
       Generation_EPEC[6,i]=y6_C_EPEC[i]
       Generation_EPEC[7,i]=y5_E_EPEC[i]
       Generation_EPEC[8,i]=y5_C_EPEC[i]
       Generation_EPEC[9,i]=y4_E_EPEC[i]
       Generation_EPEC[10,i]=y4_C_EPEC[i]
       Generation_EPEC[11,i]=y3_E_EPEC[i]
       Generation_EPEC[12,i]=y3_C_EPEC[i]
       Generation_EPEC[13,i]=y7_E_EPEC[i]
       Generation_EPEC[14,i]=y7_C_EPEC[i]
end

name_rows_generation_EPEC=hcat(name_rows_generation_1_EPEC,name_rows_generation_2_EPEC)

rows_elements_generation_EPEC=hcat(name_rows_generation_EPEC,Generation_EPEC)

df_table_generation_EPEC=DataFrame(rows_elements_generation_EPEC,name_columns_generation_EPEC)

CSV.write("results_startingpoints/$scenario/$start_point/Table_EPEC_generation$Τ.csv", df_table_generation_EPEC)

#========================================Emissions===============================================================================#

name_rows_emissions_1_CP = ["Solar","Solar","Wind","Wind","Nuclear","Nuclear","Gas-CC-CCS","Gas-CC-CCS","Gas-CC","Gas-CC","Gas-CT","Gas-CT","Coal","Coal"]
name_rows_emissions_2_CP = ["Existing","New","Existing","New","Existing","New","Existing","New","Existing","New","Existing","New","Existing","New"]
#name_rows_investments = ["Solar","Wind","Nuclear","Gas-CC-CCS","Gas-CC","Gas-CT","Coal"]
name_columns_emissions_CP= ["Technologies","Type","1","2","3","4","5","6","7","8"]

y3_CP = Total_Emissions_Technology_CP[3,:] #Gas-CT
y4_CP = Total_Emissions_Technology_CP[4,:] #Gas-CC
y5_CP =  Total_Emissions_Technology_CP[5,:] #Gas-CC-CCS
y6_CP =  Total_Emissions_Technology_CP[6,:] #Nuclear
y7_CP =  Total_Emissions_Technology_CP[7,:] #Coal
y8_CP =  Total_Emissions_Technology_CP[8,:] #Wind
y9_CP =  Total_Emissions_Technology_CP[9,:] #Solar

y3_E_CP = Total_Emissions_Technology_Existing_CP[3,:] #Gas-CT
y4_E_CP = Total_Emissions_Technology_Existing_CP[4,:] #Gas-CC
y5_E_CP =  Total_Emissions_Technology_Existing_CP[5,:] #Gas-CC-CCS
y6_E_CP =  Total_Emissions_Technology_Existing_CP[6,:] #Nuclear
y7_E_CP =  Total_Emissions_Technology_Existing_CP[7,:] #Coal
y8_E_CP =  Total_Emissions_Technology_Existing_CP[8,:] #Wind
y9_E_CP =  Total_Emissions_Technology_Existing_CP[9,:] #Solar

#Total_Emissions_Technology_Existing_CP_dummy=Total_Emissions_Technology_Existing_CP

y3_C_CP = Total_Emissions_Technology_Candidate_CP[3,:] #Gas-CT
y4_C_CP = Total_Emissions_Technology_Candidate_CP[4,:] #Gas-CC
y5_C_CP =  Total_Emissions_Technology_Candidate_CP[5,:] #Gas-CC-CCS
y6_C_CP =  Total_Emissions_Technology_Candidate_CP[6,:] #Nuclear
y7_C_CP =  Total_Emissions_Technology_Candidate_CP[7,:] #Coal
y8_C_CP =  Total_Emissions_Technology_Candidate_CP[8,:] #Wind
y9_C_CP =  Total_Emissions_Technology_Candidate_CP[9,:] #Solar

set_dummy1=1:8

Emissions_CP=zeros(14,8)

for i in set_dummy1
       Emissions_CP[1,i]=y9_E_CP[i]
       Emissions_CP[2,i]=y9_C_CP[i]
       Emissions_CP[3,i]=y8_E_CP[i]
       Emissions_CP[4,i]=y8_C_CP[i]
       Emissions_CP[5,i]=y6_E_CP[i]
       Emissions_CP[6,i]=y6_C_CP[i]
       Emissions_CP[7,i]=y5_E_CP[i]
       Emissions_CP[8,i]=y5_C_CP[i]
       Emissions_CP[9,i]=y4_E_CP[i]
       Emissions_CP[10,i]=y4_C_CP[i]
       Emissions_CP[11,i]=y3_E_CP[i]
       Emissions_CP[12,i]=y3_C_CP[i]
       Emissions_CP[13,i]=y7_E_CP[i]
       Emissions_CP[14,i]=y7_C_CP[i]
end

name_rows_emissions_CP=hcat(name_rows_emissions_1_CP,name_rows_emissions_2_CP)

rows_elements_emissions_CP=hcat(name_rows_emissions_CP,Emissions_CP)

df_table_emissions_CP=DataFrame(rows_elements_emissions_CP,name_columns_emissions_CP)


CSV.write("results_startingpoints/$scenario/$start_point/Table_CP_emissions$Τ.csv", df_table_emissions_CP)

#===============================================EPEC-Existing and Candidates=============================================================#
name_rows_emissions_1_EPEC = ["Solar","Solar","Wind","Wind","Nuclear","Nuclear","Gas-CC-CCS","Gas-CC-CCS","Gas-CC","Gas-CC","Gas-CT","Gas-CT","Coal","Coal"]
name_rows_emissions_2_EPEC = ["Existing","New","Existing","New","Existing","New","Existing","New","Existing","New","Existing","New","Existing","New"]
#name_rows_investments = ["Solar","Wind","Nuclear","Gas-CC-CCS","Gas-CC","Gas-CT","Coal"]
name_columns_emissions_EPEC= ["Technologies","Type","1","2","3","4","5","6","7","8"]

y3_E_EPEC = Total_Emissions_Technology_Existing_EPEC[3,:] #Gas-CT
y4_E_EPEC = Total_Emissions_Technology_Existing_EPEC[4,:] #Gas-CC
y5_E_EPEC =  Total_Emissions_Technology_Existing_EPEC[5,:] #Gas-CC-CCS
y6_E_EPEC =  Total_Emissions_Technology_Existing_EPEC[6,:] #Nuclear
y7_E_EPEC =  Total_Emissions_Technology_Existing_EPEC[7,:] #Coal
y8_E_EPEC =  Total_Emissions_Technology_Existing_EPEC[8,:] #Wind
y9_E_EPEC =  Total_Emissions_Technology_Existing_EPEC[9,:] #Solar

y3_C_EPEC = Total_Emissions_Technology_Candidate_EPEC[3,:] #Gas-CT
y4_C_EPEC = Total_Emissions_Technology_Candidate_EPEC[4,:] #Gas-CC
y5_C_EPEC =  Total_Emissions_Technology_Candidate_EPEC[5,:] #Gas-CC-CCS
y6_C_EPEC =  Total_Emissions_Technology_Candidate_EPEC[6,:] #Nuclear
y7_C_EPEC =  Total_Emissions_Technology_Candidate_EPEC[7,:] #Coal
y8_C_EPEC =  Total_Emissions_Technology_Candidate_EPEC[8,:] #Wind
y9_C_EPEC =  Total_Emissions_Technology_Candidate_EPEC[9,:] #Solar

set_dummy1=1:8

Emissions_EPEC=zeros(14,8)

for i in set_dummy1
       Emissions_EPEC[1,i]=y9_E_EPEC[i]
       Emissions_EPEC[2,i]=y9_C_EPEC[i]
       Emissions_EPEC[3,i]=y8_E_EPEC[i]
       Emissions_EPEC[4,i]=y8_C_EPEC[i]
       Emissions_EPEC[5,i]=y6_E_EPEC[i]
       Emissions_EPEC[6,i]=y6_C_EPEC[i]
       Emissions_EPEC[7,i]=y5_E_EPEC[i]
       Emissions_EPEC[8,i]=y5_C_EPEC[i]
       Emissions_EPEC[9,i]=y4_E_EPEC[i]
       Emissions_EPEC[10,i]=y4_C_EPEC[i]
       Emissions_EPEC[11,i]=y3_E_EPEC[i]
       Emissions_EPEC[12,i]=y3_C_EPEC[i]
       Emissions_EPEC[13,i]=y7_E_EPEC[i]
       Emissions_EPEC[14,i]=y7_C_EPEC[i]
end

name_rows_emissions_EPEC=hcat(name_rows_emissions_1_EPEC,name_rows_emissions_2_EPEC)

rows_elements_emissions_EPEC=hcat(name_rows_emissions_EPEC,Emissions_EPEC)

df_table_emissions_EPEC=DataFrame(rows_elements_emissions_EPEC,name_columns_emissions_EPEC)

CSV.write("results_startingpoints/$scenario/$start_point/Table_EPEC_emissions$Τ.csv", df_table_emissions_EPEC)
#========================================Metrics===============================================================================#
#Total Emissions
#=
#Node1
data_prices_CP[1,:]
data_prices_EPEC[1,:]
#Revenue
Total_Revenue_Cost_demandblock_EPEC_Plot[:,1]
#Cost
Total_Revenue_Cost_demandblock_EPEC_Plot[:,2]
#Revenue
Total_Revenue_Cost_demandblock_CP_Plot[:,1]
#Cost
Total_Revenue_Cost_demandblock_CP_Plot[:,2]
=#

global Total_Revenue_Cost_demandblock_CP_Plot=Total_Revenue_Cost_demandblock_CP./(10^6)
global Total_Revenue_Cost_demandblock_EPEC_Plot=zeros(length(set_times),2)


for t in set_times
global Total_Revenue_Cost_demandblock_EPEC_Plot[t,1]=(Total_Revenue_Cost_demandblock_EPEC[t,1]+Total_Revenue_Cost_demandblock_EPEC[t,3]+Total_Revenue_Cost_demandblock_EPEC[t,5])./(10^6)
global Total_Revenue_Cost_demandblock_EPEC_Plot[t,2]=(Total_Revenue_Cost_demandblock_EPEC[t,2]+Total_Revenue_Cost_demandblock_EPEC[t,4]+Total_Revenue_Cost_demandblock_EPEC[t,6])./(10^6)
end

Metrics_CP_EPEC=zeros(10,8)

for t in set_dummy1
Metrics_CP_EPEC[1,t]=data_prices_CP[1,t]
Metrics_CP_EPEC[2,t]=data_prices_EPEC[1,t]
Metrics_CP_EPEC[3,t]=data_prices_CP[2,t]
Metrics_CP_EPEC[4,t]=data_prices_EPEC[2,t]
Metrics_CP_EPEC[5,t]=data_prices_CP[3,t]
Metrics_CP_EPEC[6,t]=data_prices_EPEC[3,t]
Metrics_CP_EPEC[7,t]=Total_Revenue_Cost_demandblock_CP_Plot[t,1]
Metrics_CP_EPEC[8,t]=Total_Revenue_Cost_demandblock_EPEC_Plot[t,1]
Metrics_CP_EPEC[9,t]=Total_Revenue_Cost_demandblock_CP_Plot[t,2]
Metrics_CP_EPEC[10,t]=Total_Revenue_Cost_demandblock_EPEC_Plot[t,2]
end


name_rows_metrics_1_CP_EPEC = ["LMP node 1 (USD/MWh)","LMP node 1 (USD/MWh)","LMP node 2 (USD/MWh)","LMP node 2 (USD/MWh)","LMP node 3 (USD/MWh)","LMP node 3 (USD/MWh)","Revenue (Million USD)","Revenue (Million USD)","Operating Cost (Million USD)","Operating Cost (Million USD)"]

name_rows_metrics_2_CP_EPEC = ["CP","EPEC","CP","EPEC","CP","EPEC","CP","EPEC","CP","EPEC"]
#name_rows_investments = ["Solar","Wind","Nuclear","Gas-CC-CCS","Gas-CC","Gas-CT","Coal"]
name_columns_metrics_CP_EPEC= ["Metric","Approach","1","2","3","4","5","6","7","8"]

name_rows_metrics_CP_EPEC=hcat(name_rows_metrics_1_CP_EPEC,name_rows_metrics_2_CP_EPEC)

rows_elements_metrics_CP_EPEC=hcat(name_rows_metrics_CP_EPEC,Metrics_CP_EPEC)

df_table_metrics_CP_EPEC=DataFrame(rows_elements_metrics_CP_EPEC,name_columns_metrics_CP_EPEC)

CSV.write("results_startingpoints/$scenario/$start_point/Table_EPEC_metrics$Τ.csv", df_table_metrics_CP_EPEC)


#=
global Cost_Detail[1,1]=TotalCapCost
global Cost_Detail[2,1]=TotalFixedCost
global Cost_Detail[3,1]=TotalEmissionsCost
global Cost_Detail[4,1]=TotalOpecost
global Cost_Detail[5,1]=TotalCurtailmentcost

global Cost_Detail[1,2]=TotalCapCost_EPEC
global Cost_Detail[2,2]=TotalFixedCost_EPEC
global Cost_Detail[3,2]=TotalEmissionsCost_EPEC
global Cost_Detail[4,2]=TotalOperatingCost_EPEC
global Cost_Detail[5,2]=TotalCurtailmentcost_EPEC
=#

name_rows_metrics_cost_1_CP_EPEC = ["Total Capital Cost (Million USD)","Total Capital Cost (Million USD)","Total Fixed Cost (Million USD)","Total Fixed Cost (Million USD)","Total Emissions Cost (Million USD)","Total Emissions Cost (Million USD)","Total Variable Cost (Million USD)","Total Variable Cost (Million USD)","Total Curtailment Cost (Million USD)","Total Curtailment Cost (Million USD)"]

name_rows_metrics_cost_2_CP_EPEC = ["CP","EPEC","CP","EPEC","CP","EPEC","CP","EPEC","CP","EPEC"]

name_columns_metrics_cost_CP_EPEC= ["Metric","Approach","Value"]

#Metrics_cost_CP_EPEC_dummy=zeros(10,8)

Metrics_cost_CP_EPEC_dummy=[Cost_Detail[1,1],Cost_Detail[1,2],Cost_Detail[2,1],Cost_Detail[2,2],Cost_Detail[3,1],Cost_Detail[3,2],Cost_Detail[4,1],Cost_Detail[4,2],Cost_Detail[5,1],Cost_Detail[5,2]]

Metrics_cost_CP_EPEC=Metrics_cost_CP_EPEC_dummy./(10^6)

name_rows_metrics_cost_CP_EPEC=hcat(name_rows_metrics_cost_1_CP_EPEC,name_rows_metrics_cost_2_CP_EPEC)

rows_elements_metrics_cost_CP_EPEC=hcat(name_rows_metrics_cost_CP_EPEC,Metrics_cost_CP_EPEC)

df_table_metrics_cost_CP_EPEC=DataFrame(rows_elements_metrics_cost_CP_EPEC,name_columns_metrics_cost_CP_EPEC)

CSV.write("results_startingpoints/$scenario/$start_point/Table_EPEC_metrics_Cost$Τ.csv", df_table_metrics_cost_CP_EPEC)


return (Total_Investments_Technology_CP,Total_Investments_Technology_EPEC,Total_Revenue_Cost_demandblock_EPEC)
end
