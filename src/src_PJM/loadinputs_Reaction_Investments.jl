function loadinputs_Reaction_Investments(folder::String)

    #Congestion
    x_w_p=CSV.File(folder *"/wind_investments.csv") |> Tables.matrix
    x_e_p=CSV.File(folder *"/thermal_investments.csv") |> Tables.matrix

return (x_w_p,x_e_p)
end
