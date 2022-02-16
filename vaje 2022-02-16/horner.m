function [vrednost] = horner(a, x)
    % a = (a_n, a_(n - 1), ..., a_0)
    % p(x) = a_n*x^n + ... + a_0
    n = length(a) - 1;
    b = flip(a);
    vrednost = 0;
    for i = n:-1:0
        vrednost = vrednost * x;
        vrednost = vrednost + b(i + 1);
    end

end

