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
include("Solver_OPF.jl")
include("Solver_OPF_Experiment.jl")
include("Solver_MPEC.jl")
include("Solver_EPEC.jl")
include("Solver_EPEC_4firms.jl")
include("Solver_EPEC_Experiment.jl")
include("Solver_EPEC_SOS1.jl")
include("Investment_OPF_original.jl")
include("Investment_OPF_original_Experiment.jl")
include("OPF_original.jl")
include("Investment_OPF_MPEC.jl")
include("Investment_OPF_MPEC_4firms.jl")
include("Investment_OPF_MPEC_Experiment.jl")
include("Investment_OPF_MPEC_SOS1.jl")
include("loadinputs_CentralPlanner.jl")
include("loadinputs.jl")
include("loadinputs_4firms.jl")
include("Plots_Prices.jl")
include("Plots_Prices_startpoints.jl")
include("Plots_CapacityMix.jl")
include("Plots_CapacityMix_startpoints.jl")
include("Plots_CapacityMix_4firms.jl")
include("Plots_Generation.jl")
include("Plots_Generation_startpoints.jl")
include("Plots_Rev_Ope.jl")
include("Plots_Rev_Ope_startpoints.jl")
include("Plots_Rev_Ope_4firms.jl")

#Starting Points
include("Solver_EPEC_Diag_StartingPoints.jl")
include("loadinputs_startingpoints.jl")
include("Plots_CapacityMix_All_Solutions.jl")

export Solver_CentralPlanner,Solver_OPF,Solver_OPF_Experiment,Solver_MPEC,Solver_EPEC,Solver_EPEC_4firms,Solver_EPEC_Experiment,Solver_EPEC_SOS1,Investment_OPF_original,Investment_OPF_original_Experiment,OPF_original,Investment_OPF_MPEC,Investment_OPF_MPEC_4firms,Investment_OPF_MPEC_Experiment,Investment_OPF_MPEC_SOS1,loadinputs_CentralPlanner,loadinputs,loadinputs_4firms,Plots_Prices,Plots_CapacityMix,Plots_CapacityMix_4firms,Plots_Generation,Plots_Rev_Ope,Plots_Rev_Ope_4firms,Solver_EPEC_Diag_StartingPoints,loadinputs_startingpoints,Plots_Prices_startpoints,Plots_CapacityMix_startpoints,Plots_Generation_startpoints,Plots_Rev_Ope_startpoints,Plots_CapacityMix_All_Solutions

end
#cd("C:\\Users\\braya\\.julia\\dev\\EPEC_CarbonTax\\src")
