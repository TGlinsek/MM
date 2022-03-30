function [x] = navadna_iteracija(g, x_0, tol)
    x = x_0;
    while abs(x - g(x)) >= tol
        x = g(x);
    end
end

