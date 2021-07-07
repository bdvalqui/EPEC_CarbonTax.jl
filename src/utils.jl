"""

    @complements(m, u, x, xmax, y, ymax)

Creates a complementarity constraint in `m` of the form:

    x >= 0
    y >= 0
    x*y == 0

The macro accomplishes this via Fortuny-Amat McCarl linearization,
which uses two sufficiently-large upper limits `xmax` and `ymax` to
approximate the true complementarity condition via:

    0 <= x <= xmax*u
    0 <= y <= ymax*(1-u)

where u is a binary variable that already exists in the model.
"""
macro complements(m, u, x, xmax, y, ymax)

    return quote
        @constraint($(esc(m)), 0 <= $(esc(x)))
        @constraint($(esc(m)), $(esc(x)) <= $(esc(xmax))*$(esc(u)))
        @constraint($(esc(m)), 0 <= $(esc(y)))
        @constraint($(esc(m)), $(esc(y)) <= $(esc(ymax))*(1-$(esc(u))))
    end

end
