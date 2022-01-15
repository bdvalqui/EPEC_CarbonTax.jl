function Plots_Generation_startpoints(Total_Generation_Technology_CP,Total_Generation_Technology_Existing_CP,Total_Generation_Technology_Candidate_CP, Total_Generation_Technology_node1_CP, Total_Generation_Technology_node2_CP, Total_Generation_Technology_node3_CP,Total_Generation_Technology_EPEC,Total_Generation_Technology_Existing_EPEC,Total_Generation_Technology_Candidate_EPEC, Total_Generation_Technology_node1_EPEC, Total_Generation_Technology_node2_EPEC, Total_Generation_Technology_node3_EPEC ,set_times,Τ,Total_Emissions_Technology_CP,Total_Emissions_Technology_Candidate_CP,Total_Emissions_Technology_Existing_CP,Total_Emissions_Technology_Existing_EPEC,Total_Emissions_Technology_Candidate_EPEC,start_point)

plt=pyimport("matplotlib")
np=pyimport("numpy")
sns=pyimport("seaborn")
#x = [1,2,3,4,5,6,7,8,9,10]
#x = [230.53,461.06,922.11,1844.22,2766.33,3688.44,4610.55,5532.66,7376.87,8760.03]
x=zeros(8)
for i in 1:8
    x[i]=i
end

#x = [1,2,3,4,5,6,7,8,9,10]
labels_Ticks=["1","2","3","4","5","6","7","8"]
#labels_Ticks=["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"]
#===============================================Total Generation===================================================================#
y3 = Total_Generation_Technology_CP[3,:] #Gas-CT
y4 = Total_Generation_Technology_CP[4,:] #Gas-CC
y5 =  Total_Generation_Technology_CP[5,:] #Gas-CC-CCS
y6 =  Total_Generation_Technology_CP[6,:] #Nuclear
y7 =  Total_Generation_Technology_CP[7,:] #Coal
y8 =  Total_Generation_Technology_CP[8,:] #Wind
y9 =  Total_Generation_Technology_CP[9,:] #Solar

#labels = ["Nuclear","Coal","Gas-CT", "Gas-CC", "Gas-CC-CSS","Wind","Solar"]
#colors= ["darkorange","slategray","red","navy","deepskyblue","darkgreen","gold"]
labels = ["Solar","Wind","Nuclear","Gas-CC-CSS","Gas-CC","Gas-CT","Coal"]
colors= ["gold","darkgreen","darkorange","deepskyblue","navy","red","slategray"]
#patterns = [ "|" , "\\" , "/" , "+" , "-", ".", "*","x", "o", "O" ]

fig, ax = subplots()
stacks=ax.stackplot(x, y9,y8,y6,y5,y4,y3,y7, labels=labels, colors=colors)
ax.legend(loc="upper left")
sns.despine()
sns.despine(top=true, right=true, left=false, bottom=false)

xlabel("Demand Block")
ylabel("MWh")
xlim(1, length(set_times))
ylim(0, 80000)
xticks(x,labels_Ticks)

#===============================================Existing and Candidates=============================================================#
y3_E = Total_Generation_Technology_Existing_CP[3,:] #Gas-CT
y4_E = Total_Generation_Technology_Existing_CP[4,:] #Gas-CC
y5_E =  Total_Generation_Technology_Existing_CP[5,:] #Gas-CC-CCS
y6_E =  Total_Generation_Technology_Existing_CP[6,:] #Nuclear
y7_E =  Total_Generation_Technology_Existing_CP[7,:] #Coal
y8_E =  Total_Generation_Technology_Existing_CP[8,:] #Wind
y9_E =  Total_Generation_Technology_Existing_CP[9,:] #Solar

y3_C = Total_Generation_Technology_Candidate_CP[3,:] #Gas-CT
y4_C = Total_Generation_Technology_Candidate_CP[4,:] #Gas-CC
y5_C =  Total_Generation_Technology_Candidate_CP[5,:] #Gas-CC-CCS
y6_C =  Total_Generation_Technology_Candidate_CP[6,:] #Nuclear
y7_C =  Total_Generation_Technology_Candidate_CP[7,:] #Coal
y8_C =  Total_Generation_Technology_Candidate_CP[8,:] #Wind
y9_C =  Total_Generation_Technology_Candidate_CP[9,:] #Solar


colors= ["gold","gold","darkgreen","darkgreen","darkorange","darkorange","deepskyblue","deepskyblue","navy","navy","red","red","slategray","slategray"]

#fig, ax = subplots()
stacks=ax.stackplot(x, y9_E,y9_C,y8_E,y8_C,y6_E,y6_C,y5_E,y5_C,y4_E,y4_C,y3_E,y3_C,y7_E,y7_C, colors=colors)
#ax.legend(loc="upper right")
sns.despine()
sns.despine(top=true, right=true, left=false, bottom=false)

hatches=[ "OO" , "" ,"OO" , "" ,"OO" , "" ,"OO" , "" ,"OO" , "" ,"OO" , "" ,"OO" , "" ]
for (stack, hatch) in zip(stacks,hatches)
    stack.set_hatch(hatch)
end

xlabel("Demand Block")
ylabel("MWh")
xlim(1, length(set_times))
ylim(0, 80000)
xticks(x,labels_Ticks)

savefig("results_startingpoints/$start_point/Results_TotalGeneration_CP$Τ.png",dpi=300, bbox_inches="tight")
close()

#=================================================================================================================================#
#CP-Bars-Generation

figure(figsize=(6,3),dpi=300)

# y-axis in bold
rc("font")

# read data
j=1

bars1=zeros(16)
bars2=zeros(16)
bars3=zeros(16)
bars4=zeros(16)
bars5=zeros(16)
bars6=zeros(16)
bars7=zeros(16)

for i in [1,3,5,7,9,11,13,15]

    bars1[i]=y9_E[j]

    bars1[i+1]=y9_C[j]

    bars2[i]=y8_E[j]

    bars2[i+1]=y8_C[j]

    bars3[i]=y6_E[j]

    bars3[i+1]=y6_C[j]

    bars4[i]=y5_E[j]

    bars4[i+1]=y5_C[j]

    bars5[i]=y4_E[j]

    bars5[i+1]=y4_C[j]

    bars6[i]=y3_E[j]

    bars6[i+1]=y3_C[j]

    bars7[i]=y7_E[j]

    bars7[i+1]=y7_C[j]

    j=j+1

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

#bars_6 = np.add(bars_5,bars6).tolist()
bars_6=bars_5+bars6

#bars_7 = np.add(bars_6,bars7).tolist()
bars_7=bars_6+bars7

# The position of the bars on the x-axis

r = [0,1,3,4,6,7,9,10,12,13,15,16,18,19,21,22]

r1 = [0.5,3.5,6.5,9.5,12.5,15.5,18.5,21.5]

# Names of group and bar width
names = ["1","2","3","4","5","6","7","8"]

barWidth = 0.5

#patterns = ("OO", "", "OO", "","OO", "", "OO", "", "OO", "", "OO", "","OO", "", "OO", "")

patterns=( "" , "OO" ,"" , "OO" , "" , "OO" ,"" , "OO" , "" , "OO" ,"" , "OO" , "" , "OO" ,"" , "OO")

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
bars_hacth3=bar(r, bars3, bottom=bars_2, color="darkorange", width=barWidth)
for (bar, pattern) in zip(bars_hacth3, patterns)
    bar.set_hatch(pattern)
end

# Create bar 4
bars_hacth4=bar(r, bars4, bottom=bars_3, color="deepskyblue", width=barWidth)
for (bar, pattern) in zip(bars_hacth4, patterns)
    bar.set_hatch(pattern)
end

# Create bar 5
bars_hacth5=bar(r, bars5, bottom=bars_4, color="navy", width=barWidth)
for (bar, pattern) in zip(bars_hacth5, patterns)
    bar.set_hatch(pattern)
end

# Create bar 6
bars_hacth6=bar(r, bars6, bottom=bars_5, color="red", width=barWidth)
for (bar, pattern) in zip(bars_hacth6, patterns)
    bar.set_hatch(pattern)
end

# Create bar 7
bars_hacth7=bar(r, bars7, bottom=bars_6, color="slategray", width=barWidth)
for (bar, pattern) in zip(bars_hacth7, patterns)
    bar.set_hatch(pattern)
end

#
sns.despine()
sns.despine(top=true, right=true, left=false, bottom=false)

# Remove borders
#Title
title("Generation CP", loc ="center", fontsize=11)
legend(["Solar","Wind","Nuclear","Gas-CC-CCS","Gas-CC","Gas-CT","Coal"], loc="upper left", ncol = 1,frameon=true, fontsize=6)

#nclo is the number of columns in the legend.
#########
rc("axes", labelsize=8)
rc("xtick", labelsize=8)    # fontsize of the tick labels
rc("ytick", labelsize=8)    # fontsize of the tick labels
#rc("legend", fontsize=3)    # legend fontsize
rc("figure", titlesize=8)  # fontsize of the figure title

# Custom X axis
xticks(r1, names)
#plt.xticks(r, names)
xlabel("Representative Hour", fontsize=9)
ylabel("MWh", fontsize=10)
ylim(0, 50000)
# Show graphic
#plt.show()
savefig("results_startingpoints/$start_point/Results_TotalGeneration_CP_Bars$Τ.png",dpi=300, bbox_inches="tight")
close()
#=======================================================================================#
#=======================================================================================#
#Emissions
#=================================================================================================================================#
#CP-Bars-Emissions

y3_E = Total_Emissions_Technology_Existing_CP[3,:] #Gas-CT
y4_E = Total_Emissions_Technology_Existing_CP[4,:] #Gas-CC
y5_E =  Total_Emissions_Technology_Existing_CP[5,:] #Gas-CC-CCS
y6_E =  Total_Emissions_Technology_Existing_CP[6,:] #Nuclear
y7_E =  Total_Emissions_Technology_Existing_CP[7,:] #Coal
y8_E =  Total_Emissions_Technology_Existing_CP[8,:] #Wind
y9_E =  Total_Emissions_Technology_Existing_CP[9,:] #Solar

y3_C = Total_Emissions_Technology_Candidate_CP[3,:] #Gas-CT
y4_C = Total_Emissions_Technology_Candidate_CP[4,:] #Gas-CC
y5_C =  Total_Emissions_Technology_Candidate_CP[5,:] #Gas-CC-CCS
y6_C =  Total_Emissions_Technology_Candidate_CP[6,:] #Nuclear
y7_C =  Total_Emissions_Technology_Candidate_CP[7,:] #Coal
y8_C =  Total_Emissions_Technology_Candidate_CP[8,:] #Wind
y9_C =  Total_Emissions_Technology_Candidate_CP[9,:] #Solar

figure(figsize=(6,3),dpi=300)

# y-axis in bold
rc("font")

# read data
j=1

bars1=zeros(16)
bars2=zeros(16)
bars3=zeros(16)
bars4=zeros(16)
bars5=zeros(16)
bars6=zeros(16)
bars7=zeros(16)

for i in [1,3,5,7,9,11,13,15]

    bars1[i]=y9_E[j]

    bars1[i+1]=y9_C[j]

    bars2[i]=y8_E[j]

    bars2[i+1]=y8_C[j]

    bars3[i]=y6_E[j]

    bars3[i+1]=y6_C[j]

    bars4[i]=y5_E[j]

    bars4[i+1]=y5_C[j]

    bars5[i]=y4_E[j]

    bars5[i+1]=y4_C[j]

    bars6[i]=y3_E[j]

    bars6[i+1]=y3_C[j]

    bars7[i]=y7_E[j]

    bars7[i+1]=y7_C[j]

    j=j+1

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

#bars_6 = np.add(bars_5,bars6).tolist()
bars_6=bars_5+bars6

#bars_7 = np.add(bars_6,bars7).tolist()
bars_7=bars_6+bars7

# The position of the bars on the x-axis

r = [0,1,3,4,6,7,9,10,12,13,15,16,18,19,21,22]

r1 = [0.5,3.5,6.5,9.5,12.5,15.5,18.5,21.5]

# Names of group and bar width
names = ["1","2","3","4","5","6","7","8"]

barWidth = 0.5

#patterns = ("OO", "", "OO", "","OO", "", "OO", "", "OO", "", "OO", "","OO", "", "OO", "")

patterns=( "" , "OO" ,"" , "OO" , "" , "OO" ,"" , "OO" , "" , "OO" ,"" , "OO" , "" , "OO" ,"" , "OO")

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
bars_hacth3=bar(r, bars3, bottom=bars_2, color="darkorange", width=barWidth)
for (bar, pattern) in zip(bars_hacth3, patterns)
    bar.set_hatch(pattern)
end

# Create bar 4
bars_hacth4=bar(r, bars4, bottom=bars_3, color="deepskyblue", width=barWidth)
for (bar, pattern) in zip(bars_hacth4, patterns)
    bar.set_hatch(pattern)
end

# Create bar 5
bars_hacth5=bar(r, bars5, bottom=bars_4, color="navy", width=barWidth)
for (bar, pattern) in zip(bars_hacth5, patterns)
    bar.set_hatch(pattern)
end

# Create bar 6
bars_hacth6=bar(r, bars6, bottom=bars_5, color="red", width=barWidth)
for (bar, pattern) in zip(bars_hacth6, patterns)
    bar.set_hatch(pattern)
end

# Create bar 7
bars_hacth7=bar(r, bars7, bottom=bars_6, color="slategray", width=barWidth)
for (bar, pattern) in zip(bars_hacth7, patterns)
    bar.set_hatch(pattern)
end

#
sns.despine()
sns.despine(top=true, right=true, left=false, bottom=false)

# Remove borders
#Title
title("Emissions CP", loc ="center", fontsize=11)
legend(["Solar","Wind","Nuclear","Gas-CC-CCS","Gas-CC","Gas-CT","Coal"], loc="upper left", ncol = 1,frameon=true, fontsize=6)

#nclo is the number of columns in the legend.
#########
rc("axes", labelsize=8)
rc("xtick", labelsize=8)    # fontsize of the tick labels
rc("ytick", labelsize=8)    # fontsize of the tick labels
#rc("legend", fontsize=3)    # legend fontsize
rc("figure", titlesize=8)  # fontsize of the figure title

# Custom X axis
xticks(r1, names)
#plt.xticks(r, names)
xlabel("Representative Hour", fontsize=9)
ylabel("Ton", fontsize=10)
ylim(0, 12000)
# Show graphic
#plt.show()
savefig("results_startingpoints/$start_point/Results_TotalEmissions_CP_Bars$Τ.png",dpi=300, bbox_inches="tight")
close()
#=======================================================================================#
#EPEC
#===============================================Total Generation===================================================================#
y3 = Total_Generation_Technology_EPEC[3,:]
y4 = Total_Generation_Technology_EPEC[4,:]
y5 =  Total_Generation_Technology_EPEC[5,:]
y6 =  Total_Generation_Technology_EPEC[6,:]
y7 =  Total_Generation_Technology_EPEC[7,:]
y8 =  Total_Generation_Technology_EPEC[8,:]
y9 =  Total_Generation_Technology_EPEC[9,:]

labels = ["Solar","Wind","Nuclear","Gas-CC-CSS","Gas-CC","Gas-CT","Coal"]
colors= ["gold","darkgreen","darkorange","deepskyblue","navy","red","slategray"]

fig, ax = subplots()
stacks=ax.stackplot(x,y9,y8,y6,y5,y4,y3,y7, labels=labels, colors=colors)
ax.legend(loc="upper left")
sns.despine()
sns.despine(top=true, right=true, left=false, bottom=false)

xlabel("Demand Block")
ylabel("MWh")
xlim(1, length(set_times))
ylim(0, 80000)
xticks(x,labels_Ticks)

#===============================================Existing and Candidates=============================================================#
y3_E = Total_Generation_Technology_Existing_EPEC[3,:]
y4_E = Total_Generation_Technology_Existing_EPEC[4,:]
y5_E =  Total_Generation_Technology_Existing_EPEC[5,:]
y6_E =  Total_Generation_Technology_Existing_EPEC[6,:]
y7_E =  Total_Generation_Technology_Existing_EPEC[7,:]
y8_E =  Total_Generation_Technology_Existing_EPEC[8,:]
y9_E =  Total_Generation_Technology_Existing_EPEC[9,:]

y3_C = Total_Generation_Technology_Candidate_EPEC[3,:]
y4_C = Total_Generation_Technology_Candidate_EPEC[4,:]
y5_C =  Total_Generation_Technology_Candidate_EPEC[5,:]
y6_C =  Total_Generation_Technology_Candidate_EPEC[6,:]
y7_C =  Total_Generation_Technology_Candidate_EPEC[7,:]
y8_C =  Total_Generation_Technology_Candidate_EPEC[8,:]
y9_C =  Total_Generation_Technology_Candidate_EPEC[9,:]

colors= ["gold","gold","darkgreen","darkgreen","darkorange","darkorange","deepskyblue","deepskyblue","navy","navy","red","red","slategray","slategray"]


stacks=ax.stackplot(x, y9_E,y9_C,y8_E,y8_C,y6_E,y6_C,y5_E,y5_C,y4_E,y4_C,y3_E,y3_C,y7_E,y7_C, colors=colors)

sns.despine()
sns.despine(top=true, right=true, left=false, bottom=false)

hatches=[ "OO" , "" ,"OO" , "" ,"OO" , "" ,"OO" , "" ,"OO" , "" ,"OO" , "" ,"OO" , "" ]
#Note that I have changed the syntax here, so I can use it in Julia
for (stack, hatch) in zip(stacks,hatches)
    stack.set_hatch(hatch)
end

xlabel("Demand Block")
ylabel("MWh")
#xlim(230.53, 8760.03)
xlim(1, length(set_times))
ylim(0, 80000)
xticks(x,labels_Ticks)

savefig("results_startingpoints/$start_point/Results_TotalGeneration_EPEC$Τ.png",dpi=300, bbox_inches="tight")
close()

#==============================================================================#
#==========================EPEC Bars===========================================#
#Generation

figure(figsize=(6,3),dpi=300)

# y-axis in bold
rc("font")

# read data
j=1

bars1=zeros(16)
bars2=zeros(16)
bars3=zeros(16)
bars4=zeros(16)
bars5=zeros(16)
bars6=zeros(16)
bars7=zeros(16)

for i in [1,3,5,7,9,11,13,15]

    bars1[i]=y9_E[j]

    bars1[i+1]=y9_C[j]

    bars2[i]=y8_E[j]

    bars2[i+1]=y8_C[j]

    bars3[i]=y6_E[j]

    bars3[i+1]=y6_C[j]

    bars4[i]=y5_E[j]

    bars4[i+1]=y5_C[j]

    bars5[i]=y4_E[j]

    bars5[i+1]=y4_C[j]

    bars6[i]=y3_E[j]

    bars6[i+1]=y3_C[j]

    bars7[i]=y7_E[j]

    bars7[i+1]=y7_C[j]

    j=j+1

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

#bars_6 = np.add(bars_5,bars6).tolist()
bars_6=bars_5+bars6

#bars_7 = np.add(bars_6,bars7).tolist()
bars_7=bars_6+bars7

# The position of the bars on the x-axis

r = [0,1,3,4,6,7,9,10,12,13,15,16,18,19,21,22]

r1 = [0.5,3.5,6.5,9.5,12.5,15.5,18.5,21.5]

# Names of group and bar width
names = ["1","2","3","4","5","6","7","8"]

barWidth = 0.5

#patterns = ("OO", "", "OO", "","OO", "", "OO", "", "OO", "", "OO", "","OO", "", "OO", "")

patterns=( "" , "OO" ,"" , "OO" , "" , "OO" ,"" , "OO" , "" , "OO" ,"" , "OO" , "" , "OO" ,"" , "OO")

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
bars_hacth3=bar(r, bars3, bottom=bars_2, color="darkorange", width=barWidth)
for (bar, pattern) in zip(bars_hacth3, patterns)
    bar.set_hatch(pattern)
end

# Create bar 4
bars_hacth4=bar(r, bars4, bottom=bars_3, color="deepskyblue", width=barWidth)
for (bar, pattern) in zip(bars_hacth4, patterns)
    bar.set_hatch(pattern)
end

# Create bar 5
bars_hacth5=bar(r, bars5, bottom=bars_4, color="navy", width=barWidth)
for (bar, pattern) in zip(bars_hacth5, patterns)
    bar.set_hatch(pattern)
end

# Create bar 6
bars_hacth6=bar(r, bars6, bottom=bars_5, color="red", width=barWidth)
for (bar, pattern) in zip(bars_hacth6, patterns)
    bar.set_hatch(pattern)
end

# Create bar 7
bars_hacth7=bar(r, bars7, bottom=bars_6, color="slategray", width=barWidth)
for (bar, pattern) in zip(bars_hacth7, patterns)
    bar.set_hatch(pattern)
end

#
sns.despine()
sns.despine(top=true, right=true, left=false, bottom=false)

# Remove borders
#Title
title("Generation EPEC", loc ="center", fontsize=11)
legend(["Solar","Wind","Nuclear","Gas-CC-CCS","Gas-CC","Gas-CT","Coal"], loc="upper left", ncol = 1,frameon=true, fontsize=6)

#nclo is the number of columns in the legend.
#########
rc("axes", labelsize=8)
rc("xtick", labelsize=8)    # fontsize of the tick labels
rc("ytick", labelsize=8)    # fontsize of the tick labels
#rc("legend", fontsize=3)    # legend fontsize
rc("figure", titlesize=8)  # fontsize of the figure title

# Custom X axis
xticks(r1, names)
#plt.xticks(r, names)
xlabel("Representative Hour", fontsize=9)
ylabel("MWh", fontsize=10)
ylim(0, 50000)
# Show graphic
#plt.show()
savefig("results_startingpoints/$start_point/Results_TotalGeneration_EPEC_Bars$Τ.png",dpi=300, bbox_inches="tight")
close()
#====================================================================================#
#Emissions

y3_E = Total_Emissions_Technology_Existing_EPEC[3,:] #Gas-CT
y4_E = Total_Emissions_Technology_Existing_EPEC[4,:] #Gas-CC
y5_E =  Total_Emissions_Technology_Existing_EPEC[5,:] #Gas-CC-CCS
y6_E =  Total_Emissions_Technology_Existing_EPEC[6,:] #Nuclear
y7_E =  Total_Emissions_Technology_Existing_EPEC[7,:] #Coal
y8_E =  Total_Emissions_Technology_Existing_EPEC[8,:] #Wind
y9_E =  Total_Emissions_Technology_Existing_EPEC[9,:] #Solar

y3_C = Total_Emissions_Technology_Candidate_EPEC[3,:] #Gas-CT
y4_C = Total_Emissions_Technology_Candidate_EPEC[4,:] #Gas-CC
y5_C =  Total_Emissions_Technology_Candidate_EPEC[5,:] #Gas-CC-CCS
y6_C =  Total_Emissions_Technology_Candidate_EPEC[6,:] #Nuclear
y7_C =  Total_Emissions_Technology_Candidate_EPEC[7,:] #Coal
y8_C =  Total_Emissions_Technology_Candidate_EPEC[8,:] #Wind
y9_C =  Total_Emissions_Technology_Candidate_EPEC[9,:] #Solar

figure(figsize=(6,3),dpi=300)

# y-axis in bold
rc("font")

# read data
j=1

bars1=zeros(16)
bars2=zeros(16)
bars3=zeros(16)
bars4=zeros(16)
bars5=zeros(16)
bars6=zeros(16)
bars7=zeros(16)

for i in [1,3,5,7,9,11,13,15]

    bars1[i]=y9_E[j]

    bars1[i+1]=y9_C[j]

    bars2[i]=y8_E[j]

    bars2[i+1]=y8_C[j]

    bars3[i]=y6_E[j]

    bars3[i+1]=y6_C[j]

    bars4[i]=y5_E[j]

    bars4[i+1]=y5_C[j]

    bars5[i]=y4_E[j]

    bars5[i+1]=y4_C[j]

    bars6[i]=y3_E[j]

    bars6[i+1]=y3_C[j]

    bars7[i]=y7_E[j]

    bars7[i+1]=y7_C[j]

    j=j+1

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

#bars_6 = np.add(bars_5,bars6).tolist()
bars_6=bars_5+bars6

#bars_7 = np.add(bars_6,bars7).tolist()
bars_7=bars_6+bars7

# The position of the bars on the x-axis

r = [0,1,3,4,6,7,9,10,12,13,15,16,18,19,21,22]

r1 = [0.5,3.5,6.5,9.5,12.5,15.5,18.5,21.5]

# Names of group and bar width
names = ["1","2","3","4","5","6","7","8"]

barWidth = 0.5

#patterns = ("OO", "", "OO", "","OO", "", "OO", "", "OO", "", "OO", "","OO", "", "OO", "")

patterns=( "" , "OO" ,"" , "OO" , "" , "OO" ,"" , "OO" , "" , "OO" ,"" , "OO" , "" , "OO" ,"" , "OO")

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
bars_hacth3=bar(r, bars3, bottom=bars_2, color="darkorange", width=barWidth)
for (bar, pattern) in zip(bars_hacth3, patterns)
    bar.set_hatch(pattern)
end

# Create bar 4
bars_hacth4=bar(r, bars4, bottom=bars_3, color="deepskyblue", width=barWidth)
for (bar, pattern) in zip(bars_hacth4, patterns)
    bar.set_hatch(pattern)
end

# Create bar 5
bars_hacth5=bar(r, bars5, bottom=bars_4, color="navy", width=barWidth)
for (bar, pattern) in zip(bars_hacth5, patterns)
    bar.set_hatch(pattern)
end

# Create bar 6
bars_hacth6=bar(r, bars6, bottom=bars_5, color="red", width=barWidth)
for (bar, pattern) in zip(bars_hacth6, patterns)
    bar.set_hatch(pattern)
end

# Create bar 7
bars_hacth7=bar(r, bars7, bottom=bars_6, color="slategray", width=barWidth)
for (bar, pattern) in zip(bars_hacth7, patterns)
    bar.set_hatch(pattern)
end

#
sns.despine()
sns.despine(top=true, right=true, left=false, bottom=false)

# Remove borders
#Title
title("Emissions EPEC", loc ="center", fontsize=11)
legend(["Solar","Wind","Nuclear","Gas-CC-CCS","Gas-CC","Gas-CT","Coal"], loc="upper left", ncol = 1,frameon=true, fontsize=6)

#nclo is the number of columns in the legend.
#########
rc("axes", labelsize=8)
rc("xtick", labelsize=8)    # fontsize of the tick labels
rc("ytick", labelsize=8)    # fontsize of the tick labels
#rc("legend", fontsize=3)    # legend fontsize
rc("figure", titlesize=8)  # fontsize of the figure title

# Custom X axis
xticks(r1, names)
#plt.xticks(r, names)
xlabel("Representative Hour", fontsize=9)
ylabel("Ton", fontsize=10)
ylim(0, 12000)
# Show graphic
#plt.show()
savefig("results_startingpoints/$start_point/Results_TotalEmissions_EPEC_Bars$Τ.png",dpi=300, bbox_inches="tight")
close()

#Generation
#=======================================================================================#
#EPEC and Central Planner-Bars

y3_CP_E = Total_Generation_Technology_Existing_CP[3,:] #Gas-CT
y4_CP_E = Total_Generation_Technology_Existing_CP[4,:] #Gas-CC
y5_CP_E =  Total_Generation_Technology_Existing_CP[5,:] #Gas-CC-CCS
y6_CP_E =  Total_Generation_Technology_Existing_CP[6,:] #Nuclear
y7_CP_E =  Total_Generation_Technology_Existing_CP[7,:] #Coal
y8_CP_E =  Total_Generation_Technology_Existing_CP[8,:] #Wind
y9_CP_E =  Total_Generation_Technology_Existing_CP[9,:] #Solar

y3_CP_C = Total_Generation_Technology_Candidate_CP[3,:] #Gas-CT
y4_CP_C = Total_Generation_Technology_Candidate_CP[4,:] #Gas-CC
y5_CP_C =  Total_Generation_Technology_Candidate_CP[5,:] #Gas-CC-CCS
y6_CP_C =  Total_Generation_Technology_Candidate_CP[6,:] #Nuclear
y7_CP_C =  Total_Generation_Technology_Candidate_CP[7,:] #Coal
y8_CP_C =  Total_Generation_Technology_Candidate_CP[8,:] #Wind
y9_CP_C =  Total_Generation_Technology_Candidate_CP[9,:] #Solar

y3_EPEC_E = Total_Generation_Technology_Existing_EPEC[3,:]
y4_EPEC_E = Total_Generation_Technology_Existing_EPEC[4,:]
y5_EPEC_E =  Total_Generation_Technology_Existing_EPEC[5,:]
y6_EPEC_E =  Total_Generation_Technology_Existing_EPEC[6,:]
y7_EPEC_E =  Total_Generation_Technology_Existing_EPEC[7,:]
y8_EPEC_E =  Total_Generation_Technology_Existing_EPEC[8,:]
y9_EPEC_E =  Total_Generation_Technology_Existing_EPEC[9,:]

y3_EPEC_C = Total_Generation_Technology_Candidate_EPEC[3,:]
y4_EPEC_C = Total_Generation_Technology_Candidate_EPEC[4,:]
y5_EPEC_C =  Total_Generation_Technology_Candidate_EPEC[5,:]
y6_EPEC_C =  Total_Generation_Technology_Candidate_EPEC[6,:]
y7_EPEC_C =  Total_Generation_Technology_Candidate_EPEC[7,:]
y8_EPEC_C =  Total_Generation_Technology_Candidate_EPEC[8,:]
y9_EPEC_C =  Total_Generation_Technology_Candidate_EPEC[9,:]

figure(figsize=(6,3),dpi=300)

# y-axis in bold
rc("font")

# read data
j=1

bars1=zeros(32)
bars2=zeros(32)
bars3=zeros(32)
bars4=zeros(32)
bars5=zeros(32)
bars6=zeros(32)
bars7=zeros(32)

for i in [1,5,9,13,17,21,25,29]

    bars1[i]=y9_CP_E[j]

    bars1[i+1]=y9_EPEC_E[j]

    bars1[i+2]=y9_CP_C[j]

    bars1[i+3]=y9_EPEC_C[j]

    bars2[i]=y8_CP_E[j]

    bars2[i+1]=y8_EPEC_E[j]

    bars2[i+2]=y8_CP_C[j]

    bars2[i+3]=y8_EPEC_C[j]

    bars3[i]=y6_CP_E[j]

    bars3[i+1]=y6_EPEC_E[j]

    bars3[i+2]=y6_CP_C[j]

    bars3[i+3]=y6_EPEC_C[j]

    bars4[i]=y5_CP_E[j]

    bars4[i+1]=y5_EPEC_E[j]

    bars4[i+2]=y5_CP_C[j]

    bars4[i+3]=y5_EPEC_C[j]

    bars5[i]=y4_CP_E[j]

    bars5[i+1]=y4_EPEC_E[j]

    bars5[i+2]=y4_CP_C[j]

    bars5[i+3]=y4_EPEC_C[j]

    bars6[i]=y3_CP_E[j]

    bars6[i+1]=y3_EPEC_E[j]

    bars6[i+2]=y3_CP_C[j]

    bars6[i+3]=y3_EPEC_C[j]

    bars7[i]=y7_CP_E[j]

    bars7[i+1]=y7_EPEC_E[j]

    bars7[i+2]=y7_CP_C[j]

    bars7[i+3]=y7_EPEC_C[j]

    j=j+1

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

#bars_6 = np.add(bars_5,bars6).tolist()
bars_6=bars_5+bars6

#bars_7 = np.add(bars_6,bars7).tolist()
bars_7=bars_6+bars7

# The position of the bars on the x-axis

#r = [0,1,2,3,5,6,7,8,10,11,12,13,15,16,17,18,20,21,22,23,25,26,27,28,30,31,32,33,35,36,37,38]
r = [0,1,3,4,7,8,10,11,14,15,17,18,21,22,24,25,28,29,31,32,35,36,38,39,42,43,45,46,49,50,52,53]

#Should be located in the middle of r
#r1 = [1.5,7.5,11.5,16.5,21.5,26.5,31.5,36.5]
r1 = [2,9,16,23,30,37,44,51]

# Names of group and bar width
names = ["1","2","3","4","5","6","7","8"]

barWidth = 0.5

#patterns=( "" , "***" ,"--" , "OO","" , "***" ,"--" , "OO","" , "***" ,"--" , "OO","" , "***" ,"--" , "OO","" , "***" ,"--" , "OO","" , "***" ,"--" , "OO","" , "***" ,"--" , "OO","" , "***" ,"--" , "OO")

patterns=( "" , "OOO" ,"" , "OOO","" , "OOO" ,"" , "OOO","" , "OOO" ,"" , "OOO","" , "OOO" ,"" , "OOO","" , "OOO" ,"" , "OOO","" , "OOO" ,"" , "OOO","" , "OOO" ,"" , "OOO","" , "OOO" ,"" , "OOO")

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
bars_hacth3=bar(r, bars3, bottom=bars_2, color="darkorange", width=barWidth)
for (bar, pattern) in zip(bars_hacth3, patterns)
    bar.set_hatch(pattern)
end

# Create bar 4
bars_hacth4=bar(r, bars4, bottom=bars_3, color="deepskyblue", width=barWidth)
for (bar, pattern) in zip(bars_hacth4, patterns)
    bar.set_hatch(pattern)
end

# Create bar 5
bars_hacth5=bar(r, bars5, bottom=bars_4, color="navy", width=barWidth)
for (bar, pattern) in zip(bars_hacth5, patterns)
    bar.set_hatch(pattern)
end

# Create bar 6
bars_hacth6=bar(r, bars6, bottom=bars_5, color="red", width=barWidth)
for (bar, pattern) in zip(bars_hacth6, patterns)
    bar.set_hatch(pattern)
end

# Create bar 7
bars_hacth7=bar(r, bars7, bottom=bars_6, color="slategray", width=barWidth)
for (bar, pattern) in zip(bars_hacth7, patterns)
    bar.set_hatch(pattern)
end

#
sns.despine()
sns.despine(top=true, right=true, left=false, bottom=false)

# Remove borders
#Title
title("Generation CP and EPEC", loc ="center", fontsize=11)
legend(["Solar","Wind","Nuclear","Gas-CC-CCS","Gas-CC","Gas-CT","Coal"], loc="upper left", ncol = 1,frameon=true, fontsize=6)

#nclo is the number of columns in the legend.
#########
rc("axes", labelsize=8)
rc("xtick", labelsize=8)    # fontsize of the tick labels
rc("ytick", labelsize=8)    # fontsize of the tick labels
#rc("legend", fontsize=3)    # legend fontsize
rc("figure", titlesize=8)  # fontsize of the figure title

# Custom X axis
xticks(r1, names)
#plt.xticks(r, names)
xlabel("Representative Hour", fontsize=9)
ylabel("MWh", fontsize=10)
ylim(0, 50000)
# Show graphic
#plt.show()
savefig("results_startingpoints/$start_point/Results_TotalGeneration_CP_EPEC_Bars$Τ.png",dpi=300, bbox_inches="tight")
close()

#===============================Emissions CP and EPEC===================================#
#=======================================================================================#
#EPEC and Central Planner-Bars

y3_CP_E = Total_Emissions_Technology_Existing_CP[3,:] #Gas-CT
y4_CP_E = Total_Emissions_Technology_Existing_CP[4,:] #Gas-CC
y5_CP_E =  Total_Emissions_Technology_Existing_CP[5,:] #Gas-CC-CCS
y6_CP_E =  Total_Emissions_Technology_Existing_CP[6,:] #Nuclear
y7_CP_E =  Total_Emissions_Technology_Existing_CP[7,:] #Coal
y8_CP_E =  Total_Emissions_Technology_Existing_CP[8,:] #Wind
y9_CP_E =  Total_Emissions_Technology_Existing_CP[9,:] #Solar

y3_CP_C = Total_Emissions_Technology_Candidate_CP[3,:] #Gas-CT
y4_CP_C = Total_Emissions_Technology_Candidate_CP[4,:] #Gas-CC
y5_CP_C =  Total_Emissions_Technology_Candidate_CP[5,:] #Gas-CC-CCS
y6_CP_C =  Total_Emissions_Technology_Candidate_CP[6,:] #Nuclear
y7_CP_C =  Total_Emissions_Technology_Candidate_CP[7,:] #Coal
y8_CP_C =  Total_Emissions_Technology_Candidate_CP[8,:] #Wind
y9_CP_C =  Total_Emissions_Technology_Candidate_CP[9,:] #Solar

y3_EPEC_E = Total_Emissions_Technology_Existing_EPEC[3,:]
y4_EPEC_E = Total_Emissions_Technology_Existing_EPEC[4,:]
y5_EPEC_E =  Total_Emissions_Technology_Existing_EPEC[5,:]
y6_EPEC_E =  Total_Emissions_Technology_Existing_EPEC[6,:]
y7_EPEC_E =  Total_Emissions_Technology_Existing_EPEC[7,:]
y8_EPEC_E =  Total_Emissions_Technology_Existing_EPEC[8,:]
y9_EPEC_E =  Total_Emissions_Technology_Existing_EPEC[9,:]

y3_EPEC_C = Total_Emissions_Technology_Candidate_EPEC[3,:]
y4_EPEC_C = Total_Emissions_Technology_Candidate_EPEC[4,:]
y5_EPEC_C =  Total_Emissions_Technology_Candidate_EPEC[5,:]
y6_EPEC_C =  Total_Emissions_Technology_Candidate_EPEC[6,:]
y7_EPEC_C =  Total_Emissions_Technology_Candidate_EPEC[7,:]
y8_EPEC_C =  Total_Emissions_Technology_Candidate_EPEC[8,:]
y9_EPEC_C =  Total_Emissions_Technology_Candidate_EPEC[9,:]

figure(figsize=(6,3),dpi=300)

# y-axis in bold
rc("font")

# read data
j=1

bars1=zeros(32)
bars2=zeros(32)
bars3=zeros(32)
bars4=zeros(32)
bars5=zeros(32)
bars6=zeros(32)
bars7=zeros(32)

for i in [1,5,9,13,17,21,25,29]

    bars1[i]=y9_CP_E[j]

    bars1[i+1]=y9_EPEC_E[j]

    bars1[i+2]=y9_CP_C[j]

    bars1[i+3]=y9_EPEC_C[j]

    bars2[i]=y8_CP_E[j]

    bars2[i+1]=y8_EPEC_E[j]

    bars2[i+2]=y8_CP_C[j]

    bars2[i+3]=y8_EPEC_C[j]

    bars3[i]=y6_CP_E[j]

    bars3[i+1]=y6_EPEC_E[j]

    bars3[i+2]=y6_CP_C[j]

    bars3[i+3]=y6_EPEC_C[j]

    bars4[i]=y5_CP_E[j]

    bars4[i+1]=y5_EPEC_E[j]

    bars4[i+2]=y5_CP_C[j]

    bars4[i+3]=y5_EPEC_C[j]

    bars5[i]=y4_CP_E[j]

    bars5[i+1]=y4_EPEC_E[j]

    bars5[i+2]=y4_CP_C[j]

    bars5[i+3]=y4_EPEC_C[j]

    bars6[i]=y3_CP_E[j]

    bars6[i+1]=y3_EPEC_E[j]

    bars6[i+2]=y3_CP_C[j]

    bars6[i+3]=y3_EPEC_C[j]

    bars7[i]=y7_CP_E[j]

    bars7[i+1]=y7_EPEC_E[j]

    bars7[i+2]=y7_CP_C[j]

    bars7[i+3]=y7_EPEC_C[j]

    j=j+1

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

#bars_6 = np.add(bars_5,bars6).tolist()
bars_6=bars_5+bars6

#bars_7 = np.add(bars_6,bars7).tolist()
bars_7=bars_6+bars7

# The position of the bars on the x-axis

#r = [0,1,2,3,5,6,7,8,10,11,12,13,15,16,17,18,20,21,22,23,25,26,27,28,30,31,32,33,35,36,37,38]
r = [0,1,3,4,7,8,10,11,14,15,17,18,21,22,24,25,28,29,31,32,35,36,38,39,42,43,45,46,49,50,52,53]

#Should be located in the middle of r
#r1 = [1.5,7.5,11.5,16.5,21.5,26.5,31.5,36.5]
r1 = [2,9,16,23,30,37,44,51]

# Names of group and bar width
names = ["1","2","3","4","5","6","7","8"]

barWidth = 0.5

patterns=( "" , "OOO" ,"" , "OOO","" , "OOO" ,"" , "OOO","" , "OOO" ,"" , "OOO","" , "OOO" ,"" , "OOO","" , "OOO" ,"" , "OOO","" , "OOO" ,"" , "OOO","" , "OOO" ,"" , "OOO","" , "OOO" ,"" , "OOO")

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
bars_hacth3=bar(r, bars3, bottom=bars_2, color="darkorange", width=barWidth)
for (bar, pattern) in zip(bars_hacth3, patterns)
    bar.set_hatch(pattern)
end

# Create bar 4
bars_hacth4=bar(r, bars4, bottom=bars_3, color="deepskyblue", width=barWidth)
for (bar, pattern) in zip(bars_hacth4, patterns)
    bar.set_hatch(pattern)
end

# Create bar 5
bars_hacth5=bar(r, bars5, bottom=bars_4, color="navy", width=barWidth)
for (bar, pattern) in zip(bars_hacth5, patterns)
    bar.set_hatch(pattern)
end

# Create bar 6
bars_hacth6=bar(r, bars6, bottom=bars_5, color="red", width=barWidth)
for (bar, pattern) in zip(bars_hacth6, patterns)
    bar.set_hatch(pattern)
end

# Create bar 7
bars_hacth7=bar(r, bars7, bottom=bars_6, color="slategray", width=barWidth)
for (bar, pattern) in zip(bars_hacth7, patterns)
    bar.set_hatch(pattern)
end

#
sns.despine()
sns.despine(top=true, right=true, left=false, bottom=false)

# Remove borders
#Title
title("Emissions CP and EPEC", loc ="center", fontsize=11)
legend(["Solar","Wind","Nuclear","Gas-CC-CCS","Gas-CC","Gas-CT","Coal"], loc="upper left", ncol = 1,frameon=true, fontsize=6)

#nclo is the number of columns in the legend.
#########
rc("axes", labelsize=8)
rc("xtick", labelsize=8)    # fontsize of the tick labels
rc("ytick", labelsize=8)    # fontsize of the tick labels
#rc("legend", fontsize=3)    # legend fontsize
rc("figure", titlesize=8)  # fontsize of the figure title

# Custom X axis
xticks(r1, names)
#plt.xticks(r, names)
xlabel("Representative Hour", fontsize=9)
ylabel("MWh", fontsize=10)
ylim(0, 12000)
# Show graphic
#plt.show()
savefig("results_startingpoints/$start_point/Results_TotalEmissions_CP_EPEC_Bars$Τ.png",dpi=300, bbox_inches="tight")
close()

#=========================Generation per Nodes==========================================#

#Central Planner
#============================+Node 1===========================================#
y3 = Total_Generation_Technology_node1_CP[3,:]
y4 = Total_Generation_Technology_node1_CP[4,:]
y5 =  Total_Generation_Technology_node1_CP[5,:]
y6 =  Total_Generation_Technology_node1_CP[6,:]
y7 =  Total_Generation_Technology_node1_CP[7,:]
y8 =  Total_Generation_Technology_node1_CP[8,:]
y9 =  Total_Generation_Technology_node1_CP[9,:]

labels = ["Solar","Wind","Nuclear","Gas-CC-CSS","Gas-CC","Gas-CT","Coal"]
colors= ["gold","darkgreen","darkorange","deepskyblue","navy","red","slategray"]

fig, ax = subplots()
ax.stackplot(x, y9,y8,y6,y5,y4,y3,y7, labels=labels, colors=colors)
ax.legend(loc="upper left")
sns.despine()
sns.despine(top=true, right=true, left=false, bottom=false)
xlabel("Demand Block")
ylabel("MWh")
xlim(1, length(set_times))
xticks(x,labels_Ticks)
ylim(0, 10000)

savefig("results_startingpoints/$start_point/Results_TotalGeneration_node1_CP$Τ.png",dpi=300, bbox_inches="tight")
close()

#============================+Node 2===========================================#
y3 = Total_Generation_Technology_node2_CP[3,:]
y4 = Total_Generation_Technology_node2_CP[4,:]
y5 =  Total_Generation_Technology_node2_CP[5,:]
y6 =  Total_Generation_Technology_node2_CP[6,:]
y7 =  Total_Generation_Technology_node2_CP[7,:]
y8 =  Total_Generation_Technology_node2_CP[8,:]
y9 =  Total_Generation_Technology_node2_CP[9,:]

labels = ["Solar","Wind","Nuclear","Gas-CC-CSS","Gas-CC","Gas-CT","Coal"]
colors= ["gold","darkgreen","darkorange","deepskyblue","navy","red","slategray"]

fig, ax = subplots()
ax.stackplot(x, y9,y8,y6,y5,y4,y3,y7, labels=labels, colors=colors)
ax.legend(loc="upper left")
sns.despine()
sns.despine(top=true, right=true, left=false, bottom=false)
xlabel("Demand Block")
ylabel("MWh")
xlim(1, length(set_times))
xticks(x,labels_Ticks)
ylim(0, 45000)

savefig("results_startingpoints/$start_point/Results_TotalGeneration_node2_CP$Τ.png",dpi=300, bbox_inches="tight")
close()

#============================+Node 3===========================================#
y3 = Total_Generation_Technology_node3_CP[3,:]
y4 = Total_Generation_Technology_node3_CP[4,:]
y5 =  Total_Generation_Technology_node3_CP[5,:]
y6 =  Total_Generation_Technology_node3_CP[6,:]
y7 =  Total_Generation_Technology_node3_CP[7,:]
y8 =  Total_Generation_Technology_node3_CP[8,:]
y9 =  Total_Generation_Technology_node3_CP[9,:]

labels = ["Solar","Wind","Nuclear","Gas-CC-CSS","Gas-CC","Gas-CT","Coal"]
colors= ["gold","darkgreen","darkorange","deepskyblue","navy","red","slategray"]

fig, ax = subplots()
ax.stackplot(x,y9,y8,y6,y5,y4,y3,y7,labels=labels, colors=colors)
ax.legend(loc="upper left")
sns.despine()
sns.despine(top=true, right=true, left=false, bottom=false)
xlabel("Demand Block")
ylabel("MWh")
xlim(1, length(set_times))
xticks(x,labels_Ticks)
ylim(0, 30000)

savefig("results_startingpoints/$start_point/Results_TotalGeneration_node3_CP$Τ.png",dpi=300, bbox_inches="tight")
close()

#EPEC
#============================+Node 1===========================================#
y3 = Total_Generation_Technology_node1_EPEC[3,:]
y4 = Total_Generation_Technology_node1_EPEC[4,:]
y5 =  Total_Generation_Technology_node1_EPEC[5,:]
y6 =  Total_Generation_Technology_node1_EPEC[6,:]
y7 =  Total_Generation_Technology_node1_EPEC[7,:]
y8 =  Total_Generation_Technology_node1_EPEC[8,:]
y9 =  Total_Generation_Technology_node1_EPEC[9,:]

labels = ["Solar","Wind","Nuclear","Gas-CC-CSS","Gas-CC","Gas-CT","Coal"]
colors= ["gold","darkgreen","darkorange","deepskyblue","navy","red","slategray"]

fig, ax = subplots()
ax.stackplot(x, y9,y8,y6,y5,y4,y3,y7, labels=labels, colors=colors)
ax.legend(loc="upper left")
sns.despine()
sns.despine(top=true, right=true, left=false, bottom=false)
xlabel("Demand Block")
ylabel("MWh")
xlim(1, length(set_times))
xticks(x,labels_Ticks)
ylim(0, 10000)

savefig("results_startingpoints/$start_point/Results_TotalGeneration_node1_EPEC$Τ.png",dpi=300, bbox_inches="tight")
close()

#============================+Node 2===========================================#
y3 = Total_Generation_Technology_node2_EPEC[3,:]
y4 = Total_Generation_Technology_node2_EPEC[4,:]
y5 =  Total_Generation_Technology_node2_EPEC[5,:]
y6 =  Total_Generation_Technology_node2_EPEC[6,:]
y7 =  Total_Generation_Technology_node2_EPEC[7,:]
y8 =  Total_Generation_Technology_node2_EPEC[8,:]
y9 =  Total_Generation_Technology_node2_EPEC[9,:]

labels = ["Solar","Wind","Nuclear","Gas-CC-CSS","Gas-CC","Gas-CT","Coal"]
colors= ["gold","darkgreen","darkorange","deepskyblue","navy","red","slategray"]

fig, ax = subplots()
ax.stackplot(x, y9,y8,y6,y5,y4,y3,y7, labels=labels, colors=colors)
ax.legend(loc="upper left")
sns.despine()
sns.despine(top=true, right=true, left=false, bottom=false)
xlabel("Demand Block")
ylabel("MWh")
xlim(1, length(set_times))
xticks(x,labels_Ticks)
ylim(0, 45000)

savefig("results_startingpoints/$start_point/Results_TotalGeneration_node2_EPEC$Τ.png",dpi=300, bbox_inches="tight")
close()

#============================+Node 3===========================================#
y3 = Total_Generation_Technology_node3_EPEC[3,:]
y4 = Total_Generation_Technology_node3_EPEC[4,:]
y5 =  Total_Generation_Technology_node3_EPEC[5,:]
y6 =  Total_Generation_Technology_node3_EPEC[6,:]
y7 =  Total_Generation_Technology_node3_EPEC[7,:]
y8 =  Total_Generation_Technology_node3_EPEC[8,:]
y9 =  Total_Generation_Technology_node3_EPEC[9,:]

labels = ["Solar","Wind","Nuclear","Gas-CC-CSS","Gas-CC","Gas-CT","Coal"]
colors= ["gold","darkgreen","darkorange","deepskyblue","navy","red","slategray"]

fig, ax = subplots()
ax.stackplot(x,y9,y8,y6,y5,y4,y3,y7, labels=labels, colors=colors)
ax.legend(loc="upper left")
sns.despine()
sns.despine(top=true, right=true, left=false, bottom=false)
xlabel("Demand Block")
ylabel("MWh")
xlim(1, length(set_times))
xticks(x,labels_Ticks)
ylim(0, 30000)

savefig("results_startingpoints/$start_point/Results_TotalGeneration_node3_EPEC$Τ.png",dpi=300, bbox_inches="tight")
close()


return (Total_Generation_Technology_CP)
end
