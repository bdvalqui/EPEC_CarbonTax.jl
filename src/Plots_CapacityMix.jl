function Plots_CapacityMix(Total_Investments_Technology_CP,Total_Investments_Technology_EPEC,Total_Investments_Technology_Firm1_EPEC,Total_Investments_Technology_Firm2_EPEC,Τ)
plt=pyimport("matplotlib")
np=pyimport("numpy")
sns=pyimport("seaborn")
#Central Planner
#labels = ["Gas-CT";"Gas-CC";"Gas-CC-CCS";"Wind";"Solar"]
#colors = ["red";"navy";"deepskyblue";"darkgreen";"gold"]
labels = ["Gas-CC-CCS";"Wind";"Solar"]
colors = ["deepskyblue";"darkgreen";"gold"]
sizes = NaN*zeros(3)
explode = zeros(length(sizes))
#explode[2] = 0.0 # Move slice 2 out by 0.1
sizes = [Total_Investments_Technology_CP[5],Total_Investments_Technology_CP[6],Total_Investments_Technology_CP[7]]
font = Dict("fontname"=>"Sans","weight"=>"semibold","color"=>"black","size"=>10)

###############
#  Pie Chart  #
###############
fig = figure("pyplot_piechart",figsize=(10,10))
patches, texts = pie(sizes,
		pctdistance=1.1,
		shadow=false,
		startangle=90,
		explode=explode,
		colors=colors,
		autopct="%1.2f%%",
		textprops=font)

legend(patches, labels, loc="upper center",frameon=false,fontsize=25,bbox_to_anchor=(1, 0, 0.5, 1))

axis("equal")

#PyPlot.title("Beer")
savefig("results/Results_PieChart_CP$Τ.png",dpi=300, bbox_inches="tight")
close()


#==============================================================================================#
#=================================Capacity Mix=================================================#
###Bar plots########################

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

figure(figsize=(4,4),dpi=300)

# y-axis in bold
rc("font")

# read data
j=1

bars1=zeros(2)
bars2=zeros(2)
bars3=zeros(2)
bars4=zeros(2)
bars5=zeros(2)

for i in [1]

    bars1[i]=y7_CP[j]

    bars1[i+1]=y7_EPEC[j]

    bars2[i]=y6_CP[j]

    bars2[i+1]=y6_EPEC[j]

    bars3[i]=y5_CP[j]

    bars3[i+1]=y5_EPEC[j]

    bars4[i]=y4_CP[j]

    bars4[i+1]=y4_EPEC[j]

    bars5[i]=y3_CP[j]

    bars5[i+1]=y3_EPEC[j]

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

r = [0,1]

#r1 = [0.5,3.5,6.5,9.5,12.5,15.5,18.5,21.5]

# Names of group and bar width
names = ["CP","EPEC"]

barWidth = 0.3

#patterns = ("OO", "", "OO", "","OO", "", "OO", "", "OO", "", "OO", "","OO", "", "OO", "")

patterns=( "" , "" )

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
title("Investments Decisisons CP vs EPEC", loc ="center", fontsize=11)
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
xlabel("Model Type", fontsize=9)
ylabel("MW", fontsize=10)
ylim(0, 60000)
# Show graphic
#plt.show()
savefig("results/Results_TotalInvestments_Bars$Τ.png",dpi=300, bbox_inches="tight")


#EPEC
#labels = ["Gas-CT";"Gas-CC";"Gas-CC-CCS";"Wind";"Solar"]
#colors = ["red";"navy";"deepskyblue";"darkgreen";"gold"]
labels = ["Gas-CT";"Wind";"Solar"]
colors = ["red";"darkgreen";"gold"]
sizes = NaN*zeros(3)
explode = zeros(length(sizes))
#explode[2] = 0.0 # Move slice 2 out by 0.1
##########
#Change
##########
sizes = [Total_Investments_Technology_EPEC[3],Total_Investments_Technology_EPEC[6],Total_Investments_Technology_EPEC[7]]
font = Dict("fontname"=>"Sans","weight"=>"semibold","color"=>"black","size"=>10)

###############
#  Pie Chart  #
###############
fig = figure("pyplot_piechart",figsize=(10,10))
patches, texts = pie(sizes,
		pctdistance=1.1,
		shadow=false,
		startangle=90,
		explode=explode,
		colors=colors,
		autopct="%1.2f%%",
		textprops=font)

legend(patches, labels, loc="upper center",frameon=false,fontsize=25,bbox_to_anchor=(1, 0, 0.5, 1))

axis("equal")

#PyPlot.title("Beer")
savefig("results/Results_PieChart_EPEC$Τ.png",dpi=300, bbox_inches="tight")
close()

#=======================================================EPEC-Firm 1==================================================================#
#EPEC-Firm 1
#labels = ["Gas-CT";"Gas-CC";"Gas-CC-CCS";"Wind";"Solar"]
#colors = ["red";"navy";"deepskyblue";"darkgreen";"gold"]
labels = ["Gas-CT";"Wind";"Solar"]
colors = ["red";"darkgreen";"gold"]
sizes = NaN*zeros(3)
explode = zeros(length(sizes))
#explode[2] = 0.0 # Move slice 2 out by 0.1
##########
#Change
##########
sizes = [Total_Investments_Technology_Firm1_EPEC[3],Total_Investments_Technology_Firm1_EPEC[6],Total_Investments_Technology_Firm1_EPEC[7]]
font = Dict("fontname"=>"Sans","weight"=>"semibold","color"=>"black","size"=>10)

###############
#  Pie Chart  #
###############
fig = figure("pyplot_piechart",figsize=(10,10))
patches, texts = pie(sizes,
		pctdistance=1.1,
		shadow=false,
		startangle=90,
		explode=explode,
		colors=colors,
		autopct="%1.2f%%",
		textprops=font)

legend(patches, labels, loc="upper center",frameon=false,fontsize=25,bbox_to_anchor=(1, 0, 0.5, 1))

axis("equal")

#PyPlot.title("Beer")
savefig("results/Results_PieChart_Firm1_EPEC$Τ.png",dpi=300, bbox_inches="tight")
close()

#=======================================================EPEC-Firm 2==================================================================#
#labels = ["Gas-CT";"Gas-CC";"Gas-CC-CCS";"Wind";"Solar"]
#colors = ["red";"navy";"deepskyblue";"darkgreen";"gold"]
labels = ["Gas-CT";"Wind";"Solar"]
colors = ["red";"darkgreen";"gold"]
sizes = NaN*zeros(3)
explode = zeros(length(sizes))
#explode[2] = 0.0 # Move slice 2 out by 0.1
##########
#Change
##########
sizes = [Total_Investments_Technology_Firm2_EPEC[3],Total_Investments_Technology_Firm2_EPEC[6],Total_Investments_Technology_Firm2_EPEC[7]]
font = Dict("fontname"=>"Sans","weight"=>"semibold","color"=>"black","size"=>10)

###############
#  Pie Chart  #
###############
fig = figure("pyplot_piechart",figsize=(10,10))
patches, texts = pie(sizes,
		pctdistance=1.1,
		shadow=false,
		startangle=90,
		explode=explode,
		colors=colors,
		autopct="%1.2f%%",
		textprops=font)

legend(patches, labels, loc="upper center",frameon=false,fontsize=25,bbox_to_anchor=(1, 0, 0.5, 1))

axis("equal")

#PyPlot.title("Beer")
savefig("results/Results_PieChart_Firm2_EPEC$Τ.png",dpi=300, bbox_inches="tight")
close()

#===================================Bars================================================================#
y3_Firm1 = Total_Investments_Technology_Firm1_EPEC[3] #Gas-CT
y4_Firm1 = Total_Investments_Technology_Firm1_EPEC[4] #Gas-CC
y5_Firm1 =  Total_Investments_Technology_Firm1_EPEC[5] #Gas-CC-CCS
y6_Firm1 =  Total_Investments_Technology_Firm1_EPEC[6] #Wind
y7_Firm1 =  Total_Investments_Technology_Firm1_EPEC[7] #Solar


y3_Firm2 = Total_Investments_Technology_Firm2_EPEC[3] #Gas-CT
y4_Firm2 = Total_Investments_Technology_Firm2_EPEC[4] #Gas-CC
y5_Firm2 = Total_Investments_Technology_Firm2_EPEC[5] #Gas-CC-CCS
y6_Firm2 = Total_Investments_Technology_Firm2_EPEC[6] #Wind
y7_Firm2 = Total_Investments_Technology_Firm2_EPEC[7] #Solar

figure(figsize=(4,4),dpi=300)

# y-axis in bold
rc("font")

# read data
j=1

bars1=zeros(2)
bars2=zeros(2)
bars3=zeros(2)
bars4=zeros(2)
bars5=zeros(2)

for i in [1]

    bars1[i]=y7_Firm1[j]

    bars1[i+1]=y7_Firm2[j]

    bars2[i]=y6_Firm1[j]

    bars2[i+1]=y6_Firm2[j]

    bars3[i]=y5_Firm1[j]

    bars3[i+1]=y5_Firm2[j]

    bars4[i]=y4_Firm1[j]

    bars4[i+1]=y4_Firm2[j]

    bars5[i]=y3_Firm1[j]

    bars5[i+1]=y3_Firm2[j]

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

r = [0,1]

#r1 = [0.5,3.5,6.5,9.5,12.5,15.5,18.5,21.5]

# Names of group and bar width
names = ["Firm A","Firm B"]

barWidth = 0.3

#patterns = ("OO", "", "OO", "","OO", "", "OO", "", "OO", "", "OO", "","OO", "", "OO", "")

patterns=( "" , "" )

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
title("Investments Decisions of All Firms", loc ="center", fontsize=11)
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
xlabel("Strategic Firms", fontsize=9)
ylabel("MW", fontsize=10)
ylim(0, 35000)
# Show graphic
#plt.show()
savefig("results/Results_TotalInvestments_Firms_Bars$Τ.png",dpi=300, bbox_inches="tight")
close()

return (Total_Investments_Technology_CP,Total_Investments_Technology_EPEC)
end
