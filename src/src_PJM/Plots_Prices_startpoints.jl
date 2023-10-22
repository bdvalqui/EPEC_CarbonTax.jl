function Plots_Prices_startpoints(data_prices_CP,data_prices_EPEC,set_times,Τ,start_point,scenario)

global Demand_Block=zeros(8)
for i in 1:8
global Demand_Block[i]=i
end
sce=5
LimitPrices=[50,70,90,100,120]
#using PyPlot
#using PyCall
plt=pyimport("matplotlib")
np=pyimport("numpy")
sns=pyimport("seaborn")
#==============================================================================#
#node1
fig = figure(figsize=(6,3),dpi=300)
xlabel("Demand Block")
ylabel("Electricity Price (\$/MWh)")
plot(Demand_Block, data_prices_CP[1,:], "r", color="blue", label="Central Planner")
plot(Demand_Block, data_prices_EPEC[1,:], "r--", color="red", label="EPEC")
legend()
rc("axes", labelsize=8)
rc("xtick", labelsize=8)    # fontsize of the tick labels
rc("ytick", labelsize=8)    # fontsize of the tick labels
rc("legend", fontsize=8)    # legend fontsize
#rc('figure', titlesize=8)  # fontsize of the figure title
sns.despine()
sns.despine(top=true, right=true, left=false, bottom=false)
xlim(1, length(set_times))
ylim(0, LimitPrices[sce])
xticks(Demand_Block)
savefig("results_startingpoints/$scenario/$start_point/Results_ElectricityPrice_node1$Τ",dpi=300, bbox_inches="tight")
close()
#==============================================================================#
#node2
fig = figure(figsize=(6,3),dpi=300)
xlabel("Demand Block")
ylabel("Electricity Price (\$/MWh)")
plot(Demand_Block, data_prices_CP[2,:], "r", color="blue", label="Central Planner")
plot(Demand_Block, data_prices_EPEC[2,:], "r--", color="red", label="EPEC")
legend()
rc("axes", labelsize=8)
rc("xtick", labelsize=8)    # fontsize of the tick labels
rc("ytick", labelsize=8)    # fontsize of the tick labels
rc("legend", fontsize=8)    # legend fontsize
#rc('figure', titlesize=8)  # fontsize of the figure title
sns.despine()
sns.despine(top=true, right=true, left=false, bottom=false)
xlim(1, length(set_times))
ylim(0, LimitPrices[sce])
xticks(Demand_Block)
savefig("results_startingpoints/$scenario/$start_point/Results_ElectricityPrice_node2$Τ",dpi=300, bbox_inches="tight")
close()
#==============================================================================#
#node3
fig = figure(figsize=(6,3),dpi=300)
xlabel("Demand Block")
ylabel("Electricity Price (\$/MWh)")
plot(Demand_Block, data_prices_CP[3,:], "r", color="blue", label="Central Planner")
plot(Demand_Block, data_prices_EPEC[3,:], "r--", color="red", label="EPEC")
legend()
rc("axes", labelsize=8)
rc("xtick", labelsize=8)    # fontsize of the tick labels
rc("ytick", labelsize=8)    # fontsize of the tick labels
rc("legend", fontsize=8)    # legend fontsize
#rc('figure', titlesize=8)  # fontsize of the figure title
sns.despine()
sns.despine(top=true, right=true, left=false, bottom=false)
xlim(1, length(set_times))
ylim(0, LimitPrices[sce])
xticks(Demand_Block)
savefig("results_startingpoints/$scenario/$start_point/Results_ElectricityPrice_node3$Τ",dpi=300, bbox_inches="tight")
close()

return (data_prices_CP,data_prices_EPEC)
end
