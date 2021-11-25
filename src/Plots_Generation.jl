function Plots_Generation(Total_Generation_Technology_CP,Total_Generation_Technology_Existing_CP,Total_Generation_Technology_Candidate_CP, Total_Generation_Technology_node1_CP, Total_Generation_Technology_node2_CP, Total_Generation_Technology_node3_CP,Total_Generation_Technology_EPEC,Total_Generation_Technology_Existing_EPEC,Total_Generation_Technology_Candidate_EPEC, Total_Generation_Technology_node1_EPEC, Total_Generation_Technology_node2_EPEC, Total_Generation_Technology_node3_EPEC ,set_times,Τ)

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

savefig("results/Results_TotalGeneration_CP$Τ.png",dpi=300, bbox_inches="tight")
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

savefig("results/Results_TotalGeneration_EPEC$Τ.png",dpi=300, bbox_inches="tight")
close()


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

savefig("results/Results_TotalGeneration_node1_CP$Τ.png",dpi=300, bbox_inches="tight")
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

savefig("results/Results_TotalGeneration_node2_CP$Τ.png",dpi=300, bbox_inches="tight")
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

savefig("results/Results_TotalGeneration_node3_CP$Τ.png",dpi=300, bbox_inches="tight")
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

savefig("results/Results_TotalGeneration_node1_EPEC$Τ.png",dpi=300, bbox_inches="tight")
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

savefig("results/Results_TotalGeneration_node2_EPEC$Τ.png",dpi=300, bbox_inches="tight")
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

savefig("results/Results_TotalGeneration_node3_EPEC$Τ.png",dpi=300, bbox_inches="tight")
close()


return (Total_Generation_Technology_CP)
end
