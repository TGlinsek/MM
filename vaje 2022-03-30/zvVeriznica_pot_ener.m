function [int] = zvVeriznica_pot_ener(T1, T2, l, tol)
    if nargin < 4
        tol = toleranca();
    end
    masa = 1;
    
    g = 9.81;
    [~, w, w_] = zvVeriznica(T1, T2, l, tol);
    % integrand = @(x) w(x).*sqrt(1 + w_(x).^2);
    % int = g*masa*integral(integrand, T1(1), T2(1));

    [~, tez_y] = zvVer_tezisce(T1, T2, l, tol);
    
    int = g * masa * tez_y;
end

