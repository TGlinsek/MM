function [int_x, int_y] = zvVer_tezisce(T1, T2, l, tol)
    if nargin < 4
        tol = toleranca();
    end
    [~, w, w_] = zvVeriznica(T1, T2, l, tol);
    % l = integral(@(x) sqrt(1 + w_(x).^2), T1(1), T2(1))
    integrand_x = @(x) x.*sqrt(1 + w_(x).^2);
    int_x = integral(integrand_x, T1(1), T2(1))/l;
    integrand_y = @(x) w(x).*sqrt(1 + w_(x).^2);
    int_y = integral(integrand_y, T1(1), T2(1))/l;
end

