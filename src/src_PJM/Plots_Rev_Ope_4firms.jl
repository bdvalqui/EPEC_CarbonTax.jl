function Plots_Rev_Ope_4firms(Total_Revenue_Cost_demandblock_CP,Total_Revenue_Cost_demandblock_EPEC,set_times,Τ)

global Demand_Block=zeros(8)
for i in 1:8
global Demand_Block[i]=i
end

plt=pyimport("matplotlib")
np=pyimport("numpy")
sns=pyimport("seaborn")

global Total_Revenue_Cost_demandblock_CP_Plot=Total_Revenue_Cost_demandblock_CP./(10^6)
global Total_Revenue_Cost_demandblock_EPEC_Plot=zeros(length(set_times),2)

for t in set_times
global Total_Revenue_Cost_demandblock_EPEC_Plot[t,1]=(Total_Revenue_Cost_demandblock_EPEC[t,1]+Total_Revenue_Cost_demandblock_EPEC[t,3]+Total_Revenue_Cost_demandblock_EPEC[t,5]+Total_Revenue_Cost_demandblock_EPEC[t,7])./(10^6)
global Total_Revenue_Cost_demandblock_EPEC_Plot[t,2]=(Total_Revenue_Cost_demandblock_EPEC[t,2]+Total_Revenue_Cost_demandblock_EPEC[t,4]+Total_Revenue_Cost_demandblock_EPEC[t,6]+Total_Revenue_Cost_demandblock_EPEC[t,8])./(10^6)
end

#==============================================================================#
#Revenue
fig = figure(figsize=(6,3),dpi=300)
xlabel("Demand Block")
ylabel("Revenue/Total Operating Cost (Million USD)")
plot(Demand_Block,Total_Revenue_Cost_demandblock_EPEC_Plot[:,1], "r--", color="red", label="Revenue (EPEC)")
plot(Demand_Block,Total_Revenue_Cost_demandblock_EPEC_Plot[:,2], "r--", color="green", label="Cost (EPEC)")
plot(Demand_Block,Total_Revenue_Cost_demandblock_CP_Plot[:,1], "r", color="blue", label="Revenue (CP)")
plot(Demand_Block,Total_Revenue_Cost_demandblock_CP_Plot[:,2], "r", color="orange", label="Cost (CP)")
legend()
rc("axes", labelsize=8)
rc("xtick", labelsize=8)    # fontsize of the tick labels
rc("ytick", labelsize=8)    # fontsize of the tick labels
rc("legend", fontsize=6, loc="upper left")    # legend fontsize

sns.despine()
sns.despine(top=true, right=true, left=false, bottom=false)
xlim(1, length(set_times))
ylim(0, 10000)
xticks(Demand_Block)
savefig("results/Results_Revenue_Cost_DemandBlock$Τ",dpi=300, bbox_inches="tight")
close()

return (Total_Revenue_Cost_demandblock_CP)
end
