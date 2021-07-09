function Plots_CapacityMix(Total_Investments_Technology_CP,Total_Investments_Technology_EPEC,Total_Investments_Technology_Firm1_EPEC,Total_Investments_Technology_Firm2_EPEC,Τ)
plt=pyimport("matplotlib")
np=pyimport("numpy")

#Central Planner
#labels = ["Gas-CT";"Gas-CC";"Gas-CC-CCS";"Wind";"Solar"]
#colors = ["red";"navy";"deepskyblue";"darkgreen";"gold"]
labels = ["Gas-CC-CCS";"Wind";"Solar"]
colors = ["deepskyblue";"darkgreen";"gold"]
sizes = NaN*zeros(3)
explode = zeros(length(sizes))
#explode[2] = 0.0 # Move slice 2 out by 0.1
sizes = [Total_Investments_Technology_CP[5],Total_Investments_Technology_CP[6],Total_Investments_Technology_CP[7]]
font = Dict("fontname"=>"Sans","weight"=>"semibold","color"=>"white","size"=>25)

###############
#  Pie Chart  #
###############
fig = figure("pyplot_piechart",figsize=(10,10))
patches, texts = pie(sizes,
		labels=labels,
		shadow=false,
		startangle=90,
		explode=explode,
		colors=colors,
		autopct="%1.1f%%",
		textprops=font)

legend(patches, labels, loc="upper center",frameon=false,fontsize=25,bbox_to_anchor=(1, 0, 0.5, 1))

axis("equal")

#PyPlot.title("Beer")
savefig("results/Results_PieChart_CP$Τ.png",dpi=300, bbox_inches="tight")
close()

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
font = Dict("fontname"=>"Sans","weight"=>"semibold","color"=>"white","size"=>25)

###############
#  Pie Chart  #
###############
fig = figure("pyplot_piechart",figsize=(10,10))
patches, texts = pie(sizes,
		labels=labels,
		shadow=false,
		startangle=90,
		explode=explode,
		colors=colors,
		autopct="%1.1f%%",
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
font = Dict("fontname"=>"Sans","weight"=>"semibold","color"=>"white","size"=>25)

###############
#  Pie Chart  #
###############
fig = figure("pyplot_piechart",figsize=(10,10))
patches, texts = pie(sizes,
		labels=labels,
		shadow=false,
		startangle=90,
		explode=explode,
		colors=colors,
		autopct="%1.1f%%",
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
font = Dict("fontname"=>"Sans","weight"=>"semibold","color"=>"white","size"=>25)

###############
#  Pie Chart  #
###############
fig = figure("pyplot_piechart",figsize=(10,10))
patches, texts = pie(sizes,
		labels=labels,
		shadow=false,
		startangle=90,
		explode=explode,
		colors=colors,
		autopct="%1.1f%%",
		textprops=font)

legend(patches, labels, loc="upper center",frameon=false,fontsize=25,bbox_to_anchor=(1, 0, 0.5, 1))

axis("equal")

#PyPlot.title("Beer")
savefig("results/Results_PieChart_Firm2_EPEC$Τ.png",dpi=300, bbox_inches="tight")
close()

return (Total_Investments_Technology_CP,Total_Investments_Technology_EPEC)
end
