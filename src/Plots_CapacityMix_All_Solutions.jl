function Plots_CapacityMix_All_Solutions(equilibrium_investments,Number_Runs,folder::String="")
plt=pyimport("matplotlib")
np=pyimport("numpy")
sns=pyimport("seaborn")


df_EPEC_thermalinvestments = DataFrame(equilibrium_investments,:auto)

CSV.write(folder *"/Results_EPEC_totalinvestments_Firms_All_Solutions.csv", df_EPEC_thermalinvestments)


#==============================================================================================#
#=================================Capacity Mix=================================================#
###Bar plots########################

#====================================================================================#

figure(figsize=(8,4),dpi=300)

# y-axis in bold
rc("font")

# read data

bars1=zeros(Number_Runs)
bars2=zeros(Number_Runs)
bars3=zeros(Number_Runs)
bars4=zeros(Number_Runs)
bars5=zeros(Number_Runs)


for i in 1:Number_Runs

    bars1[i]=equilibrium_investments[7,i]

    bars2[i]=equilibrium_investments[6,i]

    bars3[i]=equilibrium_investments[5,i]

    bars4[i]=equilibrium_investments[4,i]

    bars5[i]=equilibrium_investments[3,i]

end


# Heights of bars1 + bars2
#bars_2 = np.add(bars1, bars2).tolist()
bars_2=bars1+bars2

#bars_3 = np.add(bars_2,bars3).tolist()
bars_3=bars_2+bars3

#bars_4 = np.add(bars_3,bars4).tolist()
bars_4=bars_3+bars4

#bars_5 = np.add(bars_4,bars5).tolist()
bars_5=bars_4+bars5

# The position of the bars on the x-axis

r = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]

#r1 = [0.5,3.5,6.5,9.5,12.5,15.5,18.5,21.5]

# Names of group and bar width
names = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"]

barWidth = 0.3

#patterns = ("OO", "", "OO", "","OO", "", "OO", "", "OO", "", "OO", "","OO", "", "OO", "")

patterns=( "" , "", "", "", "","" , "", "", "", "" ,"" , "", "", "", "" ,"" , "", "", "", ""  )

# Create bar 1
bars_hacth1=bar(r, bars1, color="gold", width=barWidth)

for (bar, pattern) in zip(bars_hacth1, patterns)
    bar.set_hatch(pattern)
end

# Create bar 2
bars_hacth2=bar(r, bars2, bottom=bars1, color="darkgreen", width=barWidth)
for (bar, pattern) in zip(bars_hacth2, patterns)
    bar.set_hatch(pattern)
end

# Create bar 3
bars_hacth3=bar(r, bars3, bottom=bars_2, color="deepskyblue", width=barWidth)
for (bar, pattern) in zip(bars_hacth3, patterns)
    bar.set_hatch(pattern)
end

# Create bar 4
bars_hacth4=bar(r, bars4, bottom=bars_3, color="navy", width=barWidth)
for (bar, pattern) in zip(bars_hacth4, patterns)
    bar.set_hatch(pattern)
end

# Create bar 5
bars_hacth5=bar(r, bars5, bottom=bars_4, color="red", width=barWidth)
for (bar, pattern) in zip(bars_hacth5, patterns)
    bar.set_hatch(pattern)
end

#
sns.despine()
sns.despine(top=true, right=true, left=false, bottom=false)

# Remove borders
#Title
title("All Nash Equilibrium Solutions EPEC", loc ="center", fontsize=11)
legend(["Solar","Wind","Gas-CC-CCS","Gas-CC","Gas-CT"], loc="upper left", ncol = 1,frameon=true, fontsize=6)

#nclo is the number of columns in the legend.
#########
rc("axes", labelsize=8)
rc("xtick", labelsize=8)    # fontsize of the tick labels
rc("ytick", labelsize=8)    # fontsize of the tick labels
#rc("legend", fontsize=3)    # legend fontsize
rc("figure", titlesize=8)  # fontsize of the figure title

# Custom X axis
xticks(r, names)
#plt.xticks(r, names)
xlabel("Nash Equilibrium Solution", fontsize=9)
ylabel("MW", fontsize=10)
ylim(0, 80000)
# Show graphic
#plt.show()
savefig("results_startingpoints/Results_TotalInvestments_AllSolutions_Bars.png",dpi=300, bbox_inches="tight")


return (equilibrium_investments)
end
