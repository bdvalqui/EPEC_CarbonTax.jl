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


"""
@sos1(m, u, v_plus, v_minus, x, y)
Creates a complementarity constraint in `m` of the form:

    x >= 0
    y >= 0
    x*y == 0

The macro accomplishes this via SOS1 variables, to
approximate the true complementarity condition via:

  x >= 0
  y >= 0
  u-(v_plus+v_minus)=0
  u=(x+y)/2
  v_plus-v_minus=(x-y)/2

where v_plus and v_minus are SOS1 variables and
 u is a variable that already exist in the model.
"""
macro sos1(m, u, v_plus, v_minus, x, y)

    return quote
        @constraint($(esc(m)), $(esc(x)) >= 0)
        @constraint($(esc(m)), $(esc(y)) >= 0)
        @constraint($(esc(m)), $(esc(u)) -($(esc(v_plus))+$(esc(v_minus))) ==0)
        @constraint($(esc(m)), $(esc(u)) == ($(esc(x))+$(esc(y)))/2)
        @constraint($(esc(m)), $(esc(v_plus))-$(esc(v_minus)) == ($(esc(x))-$(esc(y)))/2)
    end

end
