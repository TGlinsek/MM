function [int] = dolzina_zvVer(T1, T2, l, x, tol)
    if nargin < 5
        tol = toleranca();
    end

    [~, ~, w_] = zvVeriznica(T1, T2, l, tol);
    integrand = @(x) sqrt(1 + w_(x).^2);
    int = integral(integrand, T1(1), x);
end

