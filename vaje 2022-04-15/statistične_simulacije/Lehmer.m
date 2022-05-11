function [X] = Lehmer(a, c, m, x_0, st_clenov)
    % x_{i + 1} = a*x_i + c (mod m)
    % na koncu se še normira

    X = [x_0/m];
    for i = 2 : st_clenov
        X(i) = mod(a * X(i - 1) * m + c, m)/m;
    end
end

