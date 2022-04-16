module EPEC_CarbonTax
using JuMP
using Statistics
using StatsBase
using CSV
using DataFrames
using Distributed
using SharedArrays
using PyPlot
using PyCall
import MathOptInterface: AbstractOptimizer

#Macros
include("utils.jl")

#Functions
include("Solver_CentralPlanner.jl")
include("Solver_CentralPlanner_scenario.jl")
include("Solver_OPF.jl")
include("Solver_OPF_scenario.jl")
include("Solver_OPF_Experiment.jl")
include("Solver_MPEC.jl")
include("Solver_EPEC.jl")
include("Solver_EPEC_Experiment.jl")
include("Solver_EPEC_SOS1.jl")
include("Investment_OPF_original.jl")
include("Investment_OPF_original_Experiment.jl")
include("OPF_original.jl")
include("Investment_OPF_MPEC.jl")
include("Investment_OPF_MPEC_3firms.jl")
include("Investment_OPF_MPEC_4firms.jl")
include("Investment_OPF_MPEC_5firms.jl")
include("Investment_OPF_MPEC_Experiment.jl")
include("Investment_OPF_MPEC_SOS1.jl")
include("loadinputs_CentralPlanner.jl")
include("loadinputs_CentralPlanner_scenario.jl")
include("loadinputs.jl")
include("Plots_Prices.jl")
include("Plots_Prices_startpoints.jl")
include("Plots_CapacityMix.jl")
include("Plots_CapacityMix_startpoints.jl")
include("Plots_Generation.jl")
include("Plots_Generation_startpoints.jl")
include("Plots_Rev_Ope.jl")
include("Plots_Rev_Ope_startpoints.jl")
include("Investment_OPF_MPEC_Reaction.jl")

#Starting Points
include("Solver_EPEC_Diag_StartingPoints.jl")
include("Solver_EPEC_Diag_StartingPoints_3firms.jl")
include("Solver_EPEC_Diag_StartingPoints_4firms.jl")
include("Solver_EPEC_Diag_StartingPoints_5firms.jl")
include("loadinputs_startingpoints.jl")
include("loadinputs_startingpoints_3firms.jl")
include("loadinputs_startingpoints_4firms.jl")
include("loadinputs_startingpoints_5firms.jl")
include("Plots_CapacityMix_All_Solutions.jl")

#Reaction Function
include("loadinputs_Reaction.jl")
include("loadinputs_Reaction_Investments.jl")
include("Solver_EPEC_Reaction.jl")

#Tables
include("Tables_Capacity_Generation_Emissions.jl")

export Solver_CentralPlanner,Solver_OPF,Solver_OPF_Experiment,Solver_MPEC,Solver_EPEC,Solver_EPEC_Experiment,Solver_EPEC_SOS1,Investment_OPF_original,Investment_OPF_original_Experiment,OPF_original,Investment_OPF_MPEC,Investment_OPF_MPEC_Experiment,Investment_OPF_MPEC_SOS1,loadinputs_CentralPlanner,loadinputs,Plots_Prices,Plots_CapacityMix,Plots_Generation,Plots_Rev_Ope,Solver_EPEC_Diag_StartingPoints,loadinputs_startingpoints,Plots_Prices_startpoints,Plots_CapacityMix_startpoints,Plots_Generation_startpoints,Plots_Rev_Ope_startpoints,Plots_CapacityMix_All_Solutions,loadinputs_Reaction,loadinputs_Reaction_Investments,Solver_EPEC_Reaction,Investment_OPF_MPEC_Reaction,Tables_Capacity_Generation_Emissions,Solver_CentralPlanner_scenario,loadinputs_CentralPlanner_scenario,Solver_OPF_scenario,Investment_OPF_MPEC_3firms,loadinputs_startingpoints_3firms,Solver_EPEC_Diag_StartingPoints_3firms,Investment_OPF_MPEC_4firms,loadinputs_startingpoints_4firms,Solver_EPEC_Diag_StartingPoints_4firms,Investment_OPF_MPEC_5firms,loadinputs_startingpoints_5firms,Solver_EPEC_Diag_StartingPoints_5firms
end
#cd("C:\\Users\\braya\\.julia\\dev\\EPEC_CarbonTax\\src")
